---
name: obsidian-logging
description: "Log every AI task to an Obsidian vault note. MUST run before any task — coding, debugging, planning, documentation, or any other request. Classifies the task, fills the matching template, solves it, appends the solution, and reminds user to save the note."
---

# Obsidian Logging

Before solving any task, create a filled Obsidian vault note, solve the task, append
the solution into the note, and remind the user to save it.

<HARD-GATE>
Do NOT produce any solution output until you have first produced the complete filled
Obsidian note template for the task. The note comes first, always.
</HARD-GATE>

## Step 1 — Classify the Task

| Task type | Vault folder | Template file |
|---|---|---|
| Bug / error / traceback / crash | `obsidian/Bug_Fixes/` | `Bug_Fix_Template.md` |
| Code snippet / function / utility | `obsidian/Snippets/` | `Snippet_Template.md` |
| Project / feature / planning / architecture | `obsidian/Projects/` | `Project_Template.md` |
| Daily progress / summary / journal | `obsidian/Daily_Journal/` | `Daily_Journal_Template.md` |
| Reusable AI prompt / instruction | `obsidian/Prompts/` | `Prompt_Template.md` |
| Concept / research / explanation / docs | `obsidian/Knowledge/` | *(free-form note)* |

## Step 2 — Fill the Template

Read the matching template from `obsidian/[FOLDER]/[TEMPLATE].md`, then produce a
completely filled note. Include all frontmatter fields:

```yaml
---
title: "<descriptive title>"
date: "<YYYY-MM-DD>"
language: "<programming language or 'general'>"
status: "in-progress"
tags: [<relevant>, <tags>]
---
```

Include every section header from the template, even if some are blank placeholders.

## Step 3 — Solve the Task

Provide the full solution: code, diagnosis, explanation, steps — whatever the task
requires. Be thorough.

## Step 4 — Append AI Output to the Note

Paste your solution into the correct section of the note:

| Note type | Target section |
|---|---|
| Bug fix | `## 🤖 AI Solution` |
| Snippet | `## 💻 Code` and `## 🔍 How It Works` |
| Project | `## 🤖 AI Prompts Used` |
| Daily journal | `## 🤖 AI Interactions` |
| Prompt | `## 💬 Example Interaction` |
| Knowledge | main body of the note |

## Step 5 — Remind to Save

End **every** response with exactly:

```
📁 Save this note to: obsidian/[FOLDER]/[NOTE_TITLE].md
🔄 Obsidian Git will auto-push to GitHub within 30 minutes.
```

## Vault Structure Reference

```
obsidian/
├── Bug_Fixes/Bug_Fix_Template.md
├── Snippets/Snippet_Template.md
├── Projects/Project_Template.md
├── Daily_Journal/Daily_Journal_Template.md
├── Prompts/Prompt_Template.md
└── Knowledge/README.md
```

## Key Principles

- **Note first, solution second** — never skip the note generation step
- **Always fill all frontmatter** — title, date, language, status, tags
- **Always end with the save reminder** — every single response, no exceptions
- **Note title = descriptive slug** — e.g. `fix-null-pointer-login-handler` not `bug`
