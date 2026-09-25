"""Exercise the shell-ai wrapper without contacting a model provider."""

import json
import os
import subprocess
import tempfile
import unittest
from pathlib import Path


SCRIPT = Path(__file__).resolve().parents[1] / "home/dot_local/bin/executable_shell-ai"


class ShellAiTest(unittest.TestCase):
    def test_pi_sessions_and_modes(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            project = root / "project"
            project.mkdir()
            bin_dir = root / "bin"
            bin_dir.mkdir()
            pi = bin_dir / "pi"
            pi.write_text(
                "#!/usr/bin/env python3\n"
                "import json, os, sys, uuid\n"
                "args = sys.argv[1:]\n"
                "sid = args[args.index('--session-id') + 1] if '--session-id' in args else str(uuid.uuid4())\n"
                "with open(os.environ['PI_LOG'], 'a') as log:\n"
                "    log.write(json.dumps({'cwd': os.getcwd(), 'args': args}) + '\\n')\n"
                "if '--extension' in args:\n"
                "    print('[pi-web-access] Dynamic tool activation requires Pi 0.86.1 or newer; web tools remain eagerly available.', file=sys.stderr)\n"
                "print(json.dumps({'type': 'session', 'id': sid}))\n"
                "print(json.dumps({'type': 'agent_start'}))\n"
                "if os.environ.get('PI_MOCK_TOOL_ERROR'):\n"
                "    print(json.dumps({'type': 'tool_execution_start', 'toolName': 'web_search'}))\n"
                "    print(json.dumps({'type': 'tool_execution_end', 'toolName': 'web_search', 'isError': True, 'result': {'content': [{'type': 'text', 'text': 'Search failed\\nHTTP 429: rate limit exceeded'}]}}))\n"
                "reason = 'error' if os.environ.get('PI_MOCK_ERROR') else 'stop'\n"
                "print(json.dumps({'type': 'message_end', 'message': {'role': 'assistant', 'stopReason': reason, 'content': [{'type': 'text', 'text': 'answer'}], 'errorMessage': 'mock failure'}}))\n"
                "print(json.dumps({'type': 'agent_settled'}))\n"
            )
            pi.chmod(0o755)
            glow = bin_dir / "glow"
            glow.write_text("#!/bin/sh\ncat\n")
            glow.chmod(0o755)

            log = root / "pi.log"
            cache = root / "cache"
            data = root / "data"
            old_scopes = cache / "shell-ai/scopes"
            old_scopes.mkdir(parents=True)
            (old_scopes / "old.json").write_text("old OpenCode state")
            env = dict(os.environ)
            env.update(
                PATH=f"{bin_dir}:{env['PATH']}",
                XDG_CACHE_HOME=str(cache),
                XDG_DATA_HOME=str(data),
                PI_LOG=str(log),
            )

            def run(*args, error=False, tool_error=False, ask_tools=None, exec_tools=None):
                current_env = dict(env)
                if error:
                    current_env["PI_MOCK_ERROR"] = "1"
                if tool_error:
                    current_env["PI_MOCK_TOOL_ERROR"] = "1"
                if ask_tools is not None:
                    current_env["SHELL_AI_ASK_TOOLS"] = ask_tools
                if exec_tools is not None:
                    current_env["SHELL_AI_EXEC_TOOLS"] = exec_tools
                return subprocess.run(
                    ["bash", str(SCRIPT), *args], cwd=project, env=current_env,
                    text=True, capture_output=True,
                )

            first = run("ask", "hello")
            self.assertEqual(first.returncode, 0, first.stderr)
            self.assertIn("answer", first.stdout)
            self.assertIn("✦ Pi  Ask · deepseek-flash", first.stderr)
            self.assertIn("  ◌ Thinking…", first.stderr)
            self.assertNotIn("\x1b[", first.stderr)
            self.assertNotIn("Dynamic tool activation", first.stderr)
            scopes = list((cache / "shell-ai/pi-scopes").glob("*.json"))
            self.assertEqual(len(scopes), 1)
            state = json.loads(scopes[0].read_text())
            first_id = state["session_id"]
            calls = [json.loads(line) for line in log.read_text().splitlines()]
            self.assertEqual(calls[0]["cwd"], str(project.resolve()))
            self.assertNotIn("--session-id", calls[0]["args"])
            self.assertEqual(calls[0]["args"][calls[0]["args"].index("--tools") + 1], "read,grep,find,ls,web_search,fetch_content,get_search_content")
            self.assertEqual(calls[0]["args"][calls[0]["args"].index("--extension") + 1], "npm:pi-web-access")
            self.assertEqual(calls[0]["args"][calls[0]["args"].index("--session-dir") + 1], str(data / "shell-ai/pi-sessions"))

            second = run("exec", "change a file")
            self.assertEqual(second.returncode, 0, second.stderr)
            self.assertIn("✦ Pi  Execute · deepseek-flash", second.stderr)
            calls = [json.loads(line) for line in log.read_text().splitlines()]
            self.assertEqual(calls[1]["args"][calls[1]["args"].index("--session-id") + 1], first_id)
            self.assertEqual(calls[1]["args"][calls[1]["args"].index("--tools") + 1], "read,bash,edit,write,grep,find,ls,web_search,fetch_content,get_search_content")
            self.assertEqual(calls[1]["args"][calls[1]["args"].index("--extension") + 1], "npm:pi-web-access")
            self.assertNotIn("Dynamic tool activation", second.stderr)
            self.assertIn("Session:", run("current").stdout)

            failed = run("ask", "fail", error=True)
            self.assertNotEqual(failed.returncode, 0)
            self.assertIn("mock failure", failed.stderr)
            self.assertEqual(json.loads(scopes[0].read_text())["session_id"], first_id)

            fresh = run("new", "fresh")
            self.assertEqual(fresh.returncode, 0, fresh.stderr)
            self.assertIn("✦ Pi  New chat · deepseek-flash", fresh.stderr)
            self.assertNotEqual(json.loads(scopes[0].read_text())["session_id"], first_id)
            self.assertEqual(run("reset").returncode, 0)
            self.assertFalse(scopes[0].exists())
            self.assertEqual((old_scopes / "old.json").read_text(), "old OpenCode state")

            expanded = run("ask", "inspect", ask_tools="read,grep,find,ls,bash")
            self.assertEqual(expanded.returncode, 0, expanded.stderr)
            last_call = json.loads(log.read_text().splitlines()[-1])
            self.assertEqual(last_call["args"][last_call["args"].index("--tools") + 1], "read,grep,find,ls,bash")

            tool_failed = run("ask", "search", tool_error=True)
            self.assertEqual(tool_failed.returncode, 0, tool_failed.stderr)
            self.assertIn("  ✗ web_search\n    Search failed\n    HTTP 429: rate limit exceeded", tool_failed.stderr)

            custom_exec = run("exec", "inspect", exec_tools="read,bash,grep")
            self.assertEqual(custom_exec.returncode, 0, custom_exec.stderr)
            last_call = json.loads(log.read_text().splitlines()[-1])
            self.assertEqual(last_call["args"][last_call["args"].index("--tools") + 1], "read,bash,grep")


if __name__ == "__main__":
    unittest.main()
