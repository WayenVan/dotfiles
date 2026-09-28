#!/usr/bin/env python3
"""Compile local Rime OpenCC dictionaries without changing upstream files.

Run again after updating 白霜, then redeploy Rime. Apply the custom config
after the first compilation. Supports Linux (IBus) and macOS (Squirrel).
"""

import argparse
import ctypes
import ctypes.util
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


CONFIGS = ("emoji", "moqi_chaifen", "moqi_chaifen_all", "chinese_english", "martian")


def default_rime_dir():
    return Path.home() / ("Library/Rime" if sys.platform == "darwin"
                          else ".config/ibus/rime")


def load_opencc(tool):
    candidates = []
    if sys.platform == "darwin":
        # Homebrew on both Apple Silicon and Intel: resolve the executable's
        # symlink to its Cellar prefix instead of assuming a global dylib path.
        candidates.append(str(Path(tool).resolve().parent.parent / "lib/libopencc.dylib"))
    found = ctypes.util.find_library("opencc")
    if found:
        candidates.append(found)
    errors = []
    for candidate in candidates:
        try:
            return ctypes.CDLL(candidate)
        except OSError as error:
            errors.append(str(error))
    raise RuntimeError("Cannot load the OpenCC library. Use a Python interpreter "
                       "with the same architecture as OpenCC. " + "; ".join(errors))


def verify(source, target, staging, lib):
    # OpenCC 1.1.9 crashes exporting ocd2 to text (upstream issue #923).
    # Compare actual conversions for every source key using the runtime library.
    lib.opencc_open.argtypes = [ctypes.c_char_p]
    lib.opencc_open.restype = ctypes.c_void_p
    lib.opencc_close.argtypes = [ctypes.c_void_p]
    lib.opencc_convert_utf8.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_size_t]
    lib.opencc_convert_utf8.restype = ctypes.c_void_p
    lib.opencc_convert_utf8_free.argtypes = [ctypes.c_void_p]
    handles = []
    try:
        for kind, path in [("text", source), ("ocd2", target)]:
            dictionary = {"type": kind, "file": str(path)}
            config = {"name": "verification",
                      "segmentation": {"type": "mmseg", "dict": dictionary},
                      "conversion_chain": [{"dict": dictionary}]}
            config_path = staging / f"verify-{kind}.json"
            config_path.write_text(json.dumps(config))
            handle = lib.opencc_open(os.fsencode(config_path))
            if not handle or handle == ctypes.c_void_p(-1).value:
                raise RuntimeError(f"Cannot load {path}")
            handles.append(handle)
        count = 0
        for line in source.read_text(encoding="utf-8-sig").splitlines():
            if not line.strip() or line.lstrip().startswith("#"):
                continue
            key = line.split("\t", 1)[0].encode()
            results = []
            for handle in handles:
                result = lib.opencc_convert_utf8(handle, key, len(key))
                if not result:
                    raise RuntimeError(f"Conversion failed: {source}")
                try:
                    results.append(ctypes.string_at(result))
                finally:
                    lib.opencc_convert_utf8_free(result)
            if results[0] != results[1]:
                raise RuntimeError(f"Conversion differs: {source}: {key!r}")
            count += 1
        return count
    finally:
        for handle in handles:
            lib.opencc_close(handle)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--rime-dir", type=Path,
                        default=default_rime_dir())
    args = parser.parse_args()
    tool = shutil.which("opencc_dict")
    if not tool:
        install = "brew install opencc" if sys.platform == "darwin" else "sudo dnf install opencc-tools"
        parser.error(f"Missing opencc_dict. Install it first: {install}")
    try:
        lib = load_opencc(tool)
    except RuntimeError as error:
        parser.error(str(error))
    directory = args.rime_dir.expanduser().resolve() / "opencc"
    if not directory.is_dir():
        parser.error(f"Missing OpenCC directory: {directory}")

    # Compile and check everything before publishing any configuration.
    with tempfile.TemporaryDirectory(prefix=".dotfiles-build-", dir=directory) as tmp:
        staging = Path(tmp)
        compiled = {}
        outputs = []

        def convert(node):
            if isinstance(node, list):
                for item in node:
                    convert(item)
            elif isinstance(node, dict):
                if node.get("type") == "text" and "file" in node:
                    source = directory / node["file"]
                    if source not in compiled:
                        digest = hashlib.sha256(source.read_bytes()).hexdigest()[:16]
                        target = staging / f"dotfiles-{source.stem}-{digest}.ocd2"
                        subprocess.run([tool, "-i", str(source), "-o", str(target),
                                        "-f", "text", "-t", "ocd2"], check=True)
                        count = verify(source, target, staging, lib)
                        compiled[source] = target.name
                        outputs.append(target)
                        print(f"Verified {count} keys: {source.name} -> {target.name}")
                    node["type"] = "ocd2"
                    node["file"] = compiled[source]
                else:
                    for value in node.values():
                        convert(value)

        for name in CONFIGS:
            config = json.loads((directory / f"{name}.json").read_text())
            convert(config)
            target = staging / f"dotfiles-{name}.json"
            target.write_text(json.dumps(config, ensure_ascii=False, indent=2) + "\n")
            outputs.append(target)

        # Publish all immutable dictionaries before configurations that refer to them.
        for output in sorted(outputs, key=lambda p: p.suffix == ".json"):
            os.replace(output, directory / output.name)
    print(f"Done. First run: apply {directory.parent / 'rime_frost.custom.yaml'}.")
    print("Then redeploy Rime from its menu.")


if __name__ == "__main__":
    main()
