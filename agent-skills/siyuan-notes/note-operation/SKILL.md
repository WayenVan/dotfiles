---
name: note-operation
description: Operate on the user's notes. Use this skill whenever the user requests any operation involving notes, including adding, deleting, modifying, or querying notes.
---

# Note Operation

## Required Rules

1. Use SiYuan as the note-taking application. Perform every note operation exclusively through the available SiYuan note tools, including creating, deleting, modifying, and querying notes. If no relevant SiYuan tool can be found or the required tools are not enabled, stop all note operations immediately and ask the user to enable or provide the SiYuan tools. Do not use filesystem operations, another note application, or any other workaround.
2. Name every new note using the format `yyyy-mm-dd <note name>`. Use the applicable note date in ISO format followed by one space and the note name. Example: `2026-08-09 今天的计划表`.

## Adding Notes

1. When the user does not specify a notebook, create plan-related notes in the notebook named `agenda`. Create all other notes in the notebook named `capture`.
