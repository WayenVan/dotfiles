---
name: inbox-capture
description: Quickly capture ideas, tasks, questions, and thoughts into the project's .ai/INBOX.md without interrupting the current task.
---

# Inbox Capture

Capture first. Organize later.

## Target

All captured items go to a **single file**:

```
.ai/INBOX.md
```

located at the **root of the current project** — i.e. the working directory of the active task (if the user names a project, use that project's root).

**Appending is chronological:** every new item goes at the END of the file. Never insert in the middle, never reorder, never rewrite existing entries.

## Triggers

When the user says things like:

- 记一下……
- 先记下来……
- 放 inbox
- 这个以后研究
- capture this
- remember this for later

capture the thought into the inbox.

## File format

`.ai/INBOX.md` uses this structure:

```markdown
# 📥 Inbox

> Capture first. Organize later.
> 条目按时间顺序排列,最新在底部。

---

## 2026-08-10 14:32

<原文内容,保留用户原意>

#todo #research

---

## 2026-08-10 14:35

<第二条内容……>

#idea
```

Format rules:

- One entry per capture: `## YYYY-MM-DD HH:MM` heading, followed by the cleaned-up content, followed by a tag line (`#tag1 #tag2`, at most a few obvious ones).
- Entries separated by `---`.
- Timestamps use local time. If two entries land in the same minute, add seconds (`HH:MM:SS`).
- The first time the file is created, write the header block (`# 📥 Inbox` + the `>` quote) above the first entry.

## Behavior

1. Determine the current project root (current working directory of the task).
2. If `.ai/INBOX.md` does not exist, create `.ai/` and the file with the header template above.
3. **Append** the new entry to the end of the file — use an append operation (e.g. `cat >>` / read-modify-write), never a whole-file overwrite that would drop existing entries.
4. Preserve the user's original idea.
5. Lightly clean up wording only when necessary.
6. Add timestamp: local time, `YYYY-MM-DD HH:MM`.
7. Add at most a few obvious tags.
8. Do NOT ask the user where it belongs.
9. Do NOT reorganize existing notes.
10. Do NOT expand the idea into a research task.
11. Do NOT start investigating the captured idea unless explicitly asked.

After capture, respond briefly:

"✓ 已放入 Inbox"

Then return attention to the task that was active before the capture.

## Organizing (only when explicitly asked)

If the user explicitly asks to clean up / organize the inbox (e.g. 整理 inbox), you may archive or move processed entries. Otherwise, never touch the file's existing content.

## Important principle

Side idea ≠ new task.

Capture it and return to the current task.
