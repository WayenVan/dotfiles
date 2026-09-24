#!/usr/bin/env python3
"""Parse a local PDF with Baidu PaddleOCR-VL and save every artifact locally."""

from __future__ import annotations

import argparse
import base64
import hashlib
import json
import os
import secrets
import sys
import time
from datetime import datetime, timezone
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.parse import urlencode
from urllib.request import Request, urlopen


SUBMIT_URL = "https://aip.baidubce.com/rest/2.0/brain/online/v2/paddle-vl-parser/task"
QUERY_URL = SUBMIT_URL + "/query"
TOKEN_URL = "https://aip.baidubce.com/oauth/2.0/token"
MAX_LOCAL_UPLOAD = 50 * 1024 * 1024


class ParseError(RuntimeError):
    pass


def write_json(path: Path, value: object) -> None:
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def request_json(url: str, data: dict[str, str], timeout: float) -> dict:
    body = urlencode(data).encode("utf-8")
    request = Request(
        url,
        data=body,
        headers={"Content-Type": "application/x-www-form-urlencoded"},
        method="POST",
    )
    try:
        with urlopen(request, timeout=timeout) as response:
            payload = json.load(response)
    except HTTPError as exc:
        detail = exc.read(4096).decode("utf-8", errors="replace")
        raise ParseError(f"HTTP {exc.code}: {detail}") from exc
    except (URLError, TimeoutError) as exc:
        raise ParseError(f"network request failed: {exc}") from exc
    except json.JSONDecodeError as exc:
        raise ParseError("service returned invalid JSON") from exc
    if not isinstance(payload, dict):
        raise ParseError("service returned a non-object JSON response")
    return payload


def get_access_token(timeout: float) -> str:
    token = os.environ.get("BAIDU_OCR_ACCESS_TOKEN")
    if token:
        return token
    api_key = os.environ.get("BAIDU_OCR_API_KEY")
    secret_key = os.environ.get("BAIDU_OCR_SECRET_KEY")
    if not api_key or not secret_key:
        raise ParseError(
            "set BAIDU_OCR_ACCESS_TOKEN, or both BAIDU_OCR_API_KEY and "
            "BAIDU_OCR_SECRET_KEY"
        )
    payload = request_json(
        TOKEN_URL,
        {"grant_type": "client_credentials", "client_id": api_key, "client_secret": secret_key},
        timeout,
    )
    token = payload.get("access_token")
    if not isinstance(token, str) or not token:
        raise ParseError(f"could not obtain access token: {payload.get('error_description', payload)}")
    return token


def api_url(endpoint: str, token: str) -> str:
    return endpoint + "?" + urlencode({"access_token": token})


def check_api_response(payload: dict, operation: str) -> dict:
    error_code = payload.get("error_code", 0)
    if error_code not in (0, None):
        raise ParseError(f"{operation} failed ({error_code}): {payload.get('error_msg', 'unknown error')}")
    result = payload.get("result")
    if not isinstance(result, dict):
        raise ParseError(f"{operation} returned no result object")
    return result


def download(url: str, destination: Path, timeout: float) -> None:
    request = Request(url, headers={"User-Agent": "pdf-reader/1.0"})
    try:
        with urlopen(request, timeout=timeout) as response, destination.open("wb") as output:
            while chunk := response.read(1024 * 1024):
                output.write(chunk)
    except (HTTPError, URLError, TimeoutError) as exc:
        destination.unlink(missing_ok=True)
        raise ParseError(f"failed to download result: {exc}") from exc


def default_workspace() -> Path:
    stamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    return Path.cwd() / ".pdf-parse-cache" / f"{stamp}-{secrets.token_hex(4)}"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Upload a PDF to Baidu PaddleOCR-VL 1.6 and save Markdown/JSON results.",
    )
    parser.add_argument("pdf", type=Path, help="local source PDF")
    parser.add_argument("--workspace", type=Path, help="fresh output directory (default: .pdf-parse-cache/...)")
    parser.add_argument(
        "--confirm-cloud-upload",
        action="store_true",
        help="required acknowledgement that the PDF will be sent to Baidu",
    )
    parser.add_argument("--poll-interval", type=float, default=7.0, help="seconds between status checks")
    parser.add_argument("--poll-timeout", type=float, default=1800.0, help="maximum total polling time")
    parser.add_argument("--request-timeout", type=float, default=300.0, help="timeout for each HTTP request")
    parser.add_argument("--analysis-chart", action="store_true", help="enable chart-content analysis")
    parser.add_argument("--merge-tables", action="store_true", help="enable cross-page table merging")
    parser.add_argument("--relevel-titles", action="store_true", help="infer heading levels")
    parser.add_argument("--return-span-boxes", action="store_true", help="return line-level coordinates")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    source = args.pdf.expanduser().resolve()
    if not source.is_file():
        raise ParseError(f"PDF not found: {source}")
    with source.open("rb") as stream:
        signature = stream.read(5)
    if source.suffix.lower() != ".pdf" or signature != b"%PDF-":
        raise ParseError(f"not a PDF file: {source}")
    size = source.stat().st_size
    if size > MAX_LOCAL_UPLOAD:
        raise ParseError(
            f"local upload is {size / 1024 / 1024:.1f} MiB; this script limits file_data uploads "
            "to 50 MiB. Use a reviewed HTTPS file_url integration for larger documents."
        )
    if not args.confirm_cloud_upload:
        raise ParseError("refusing cloud upload without --confirm-cloud-upload")
    if args.poll_interval < 5:
        raise ParseError("--poll-interval must be at least 5 seconds")
    if args.poll_timeout <= 0 or args.request_timeout <= 0:
        raise ParseError("timeouts must be positive")

    workspace = (args.workspace or default_workspace()).expanduser().resolve()
    if workspace.exists():
        if not workspace.is_dir() or any(workspace.iterdir()):
            raise ParseError(f"workspace must be a new or empty directory: {workspace}")
    workspace.mkdir(parents=True, exist_ok=True)
    provider_dir = workspace / "provider"
    provider_dir.mkdir()

    digest = hashlib.sha256()
    with source.open("rb") as stream:
        while chunk := stream.read(1024 * 1024):
            digest.update(chunk)
    manifest = {
        "parser": "Baidu PaddleOCR-VL 1.6",
        "source_pdf": str(source),
        "source_size": size,
        "source_sha256": digest.hexdigest(),
        "created_at": datetime.now(timezone.utc).isoformat(),
        "status": "submitting",
    }
    write_json(workspace / "manifest.json", manifest)

    token = get_access_token(args.request_timeout)
    encoded_pdf = base64.b64encode(source.read_bytes()).decode("ascii")
    submit_data = {
        "file_data": encoded_pdf,
        "file_name": source.name,
        "analysis_chart": str(args.analysis_chart).lower(),
        "merge_tables": str(args.merge_tables).lower(),
        "relevel_titles": str(args.relevel_titles).lower(),
        "return_span_boxes": str(args.return_span_boxes).lower(),
    }
    submitted = request_json(api_url(SUBMIT_URL, token), submit_data, args.request_timeout)
    write_json(provider_dir / "submit.json", submitted)
    task = check_api_response(submitted, "submission")
    task_id = task.get("task_id")
    if not isinstance(task_id, str) or not task_id:
        raise ParseError("submission returned no task_id")
    manifest.update({"task_id": task_id, "status": "processing"})
    write_json(workspace / "manifest.json", manifest)
    print(f"Submitted {source.name} as {task_id}; polling every {args.poll_interval:g}s", flush=True)

    deadline = time.monotonic() + args.poll_timeout
    last_payload: dict = {}
    while time.monotonic() < deadline:
        time.sleep(args.poll_interval)
        last_payload = request_json(
            api_url(QUERY_URL, token), {"task_id": task_id}, args.request_timeout
        )
        write_json(provider_dir / "latest-status.json", last_payload)
        result = check_api_response(last_payload, "status query")
        status = result.get("status")
        print(f"Status: {status}", flush=True)
        if status == "failed":
            raise ParseError(f"PaddleOCR-VL task failed: {result.get('task_error', 'unknown error')}")
        if status == "success":
            break
    else:
        raise ParseError(f"timed out waiting for task {task_id}")

    result = check_api_response(last_payload, "status query")
    markdown_url = result.get("markdown_url")
    json_url = result.get("parse_result_url")
    if not isinstance(markdown_url, str) or not isinstance(json_url, str):
        raise ParseError("successful task did not include Markdown and JSON result URLs")
    download(markdown_url, workspace / "document.md", args.request_timeout)
    download(json_url, workspace / "parse-result.json", args.request_timeout)
    manifest.update(
        {
            "status": "success",
            "completed_at": datetime.now(timezone.utc).isoformat(),
            "primary_markdown": "document.md",
            "structured_result": "parse-result.json",
        }
    )
    write_json(workspace / "manifest.json", manifest)
    print(f"Primary Markdown: {workspace / 'document.md'}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except ParseError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
