---
name: pdf-reader
description: Parse and read PDF documents through an isolated workspace, using generated Markdown as a searchable, lazily loaded reading context while checking the original pages whenever layout or recognition matters.
---

# PDF Reader

Use this skill when a task requires reading, searching, explaining, summarizing, or extracting information from a PDF.

## Establish the workspace

After resolving the input PDF to an absolute path, create a fresh directory under the active task's current working directory:

```text
.pdf-parse-cache/<YYYYMMDD-HHMMSS>-<uid>/
```

Treat this directory as `pdf-workspace` for that PDF-processing run. Use a collision-resistant short `uid`; do not derive identity from the filename alone.

Keep every generated artifact inside `pdf-workspace`, including Markdown, parser metadata, extracted images, rendered pages, logs, and intermediate files. Do not modify the source PDF.

## Parse the PDF

Use the hosted Baidu PaddleOCR-VL 1.6 parser through `scripts/parse_pdf.py`. This uploads the source document to Baidu; obtain the user's approval before the first upload unless the user has already explicitly asked to use this cloud parser for that document.

Provide credentials through one of these environment-variable combinations:

```text
BAIDU_OCR_ACCESS_TOKEN
```

or:

```text
BAIDU_OCR_API_KEY
BAIDU_OCR_SECRET_KEY
```

Run:

```bash
python3 <skill-directory>/scripts/parse_pdf.py \
  /absolute/path/to/source.pdf \
  --workspace /absolute/path/to/pdf-workspace \
  --confirm-cloud-upload \
  --merge-tables \
  --relevel-titles
```

The workspace must be new or empty. The script does not copy or modify the source PDF. It writes:

- `document.md`: primary text-reading context;
- `parse-result.json`: page-, layout-, table-, image-, formula-, and coordinate-level structured output;
- `manifest.json`: source hash, parser, task ID, status, and local output mapping; and
- `provider/`: raw submission and latest-status responses for troubleshooting.

For local uploads, the script accepts PDFs up to 50 MiB. The service supports PDFs up to 500 pages and 100 MiB, but documents over 50 MiB require a separately reviewed URL-upload workflow. Do not invent or silently switch to another parser when this integration cannot process the file.

## Read lazily

Treat the generated Markdown as the PDF's primary text-reading context and as an external document that can be searched and accessed on demand. Do not load the entire Markdown file at the start.

1. Inspect its structure using a table of contents, headings, or small targeted excerpts.
2. Search for the sections, terms, symbols, names, or claims relevant to the current question.
3. Read only the matching portions and the context needed to interpret them.
4. Expand to adjacent or related sections only when the current evidence is insufficient.
5. Traverse the complete document in chunks only when the task genuinely requires whole-document coverage.

Prefer targeted search and bounded reads. Preserve enough surrounding context to avoid detaching claims, definitions, equations, or table entries from their qualifiers.

## Verify against the source

Markdown is a reading aid, not visual ground truth. Return to the original PDF or render the relevant pages into `pdf-workspace` when:

- layout or reading order carries meaning;
- the answer depends on an image, diagram, formula, table, footnote, or page-specific formatting;
- OCR or parsing appears incomplete, malformed, or ambiguous;
- exact wording, symbols, values, or page citations matter; or
- the Markdown conflicts with another part of the document.

When uncertainty remains after checking the page, state it rather than silently repairing or guessing the source content.

## Output discipline

- Distinguish statements supported by parsed text from interpretations or inferences.
- Include page references when available and useful.
- Do not place generated files outside `pdf-workspace` unless the user explicitly requests a separate deliverable.
- Do not delete prior cache workspaces as part of ordinary reading.
