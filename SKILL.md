# obsidian_superpower — SKILL.md

## Overview
This skill automatically integrates Obsidian vault note-taking into every Claude coding task.
Before solving any problem, Claude produces a filled Obsidian note, solves the task,
appends the solution back into the note, and reminds you to save it to the vault.

**One install. Works across every coding project. Always on.**

---

## Installation

### Step 1 — Create the vault folder in your repo (run once)

**Windows (PowerShell):**
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/setup_vault.ps1 -OutFile setup_vault.ps1; .\setup_vault.ps1
```

**Mac / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/setup_vault.sh | bash
```

This creates the full `obsidian/` folder structure and downloads all templates directly into your current repo. You only need to run this once per project.

### Step 2 — Activate the skill with Claude
Tell Claude once at the start of any session:
```
Install skill from https://github.com/maxwellcudjoe/maxsidian/tree/master/obsidian
```

Or reference the YAML directly:
```
Load obsidian_superpower from https://github.com/maxwellcudjoe/maxsidian/blob/master/obsidian_skill.yaml
```

### What the setup script creates
```
your-repo/
└── obsidian/
    ├── README.md
    ├── Projects/Project_Template.md
    ├── Snippets/Snippet_Template.md
    ├── Bug_Fixes/Bug_Fix_Template.md
    ├── Knowledge/README.md
    ├── Prompts/Prompt_Template.md
    └── Daily_Journal/Daily_Journal_Template.md
```
After setup, Claude saves notes into these folders. Obsidian Git auto-pushes updates to GitHub on a 30-minute schedule.

---

## Trigger Keywords

Claude will automatically invoke this skill when it detects any of:

| Trigger | Action |
|---|---|
| bug, error, traceback, exception, crash | Creates a `Bug_Fix_Template.md` note |
| snippet, function, utility, helper | Creates a `Snippet_Template.md` note |
| project, feature, planning, architecture | Creates a `Project_Template.md` note |
| journal, today, progress, summary, daily | Creates a `Daily_Journal_Template.md` note |
| prompt, instruction, system prompt | Creates a `Prompt_Template.md` note |
| explain, concept, how does, what is | Creates a free-form `Knowledge/` note |

---

## How It Works (Every Task)

```
User sends any request
       │
       ▼
① Classify task type
  (bug / snippet / project / journal / prompt / knowledge)
       │
       ▼
② Select template from obsidian/[FOLDER]/[TEMPLATE].md
  Fill all frontmatter: title, date, language, status, tags
       │
       ▼
③ Solve the task
  Full solution: code, diagnosis, explanation, steps
       │
       ▼
④ Append solution to note
  Paste into the correct Claude field in the template
       │
       ▼
⑤ Return the complete note + solution to user
  Remind: "📁 Save this note to obsidian/[FOLDER]/[NOTE].md"
       │
       ▼
⑥ Obsidian Git auto-pushes to GitHub within 30 min
```

---

## Call by Name (Any Project)

Once installed, call it explicitly for any task:

```
Claude, use obsidian_superpower to log this bug: [PASTE ERROR]
```
```
Claude, use obsidian_superpower to generate a Python snippet for [TASK].
```
```
Claude, use obsidian_superpower to write my daily journal entry. I worked on: [SUMMARY]
```
```
Claude, use obsidian_superpower to document the [PROJECT NAME] project.
```
```
Claude, use obsidian_superpower to save this prompt to my library: [PROMPT TEXT]
```
```
Claude, use obsidian_superpower to explain [CONCEPT] as a knowledge note.
```

---

## Vault Structure

```
obsidian/
├── Projects/Project_Template.md
├── Snippets/Snippet_Template.md
├── Bug_Fixes/Bug_Fix_Template.md
├── Knowledge/README.md
├── Prompts/Prompt_Template.md
└── Daily_Journal/Daily_Journal_Template.md
```

All templates use Obsidian Templater syntax (`<% tp.system.prompt("...") %>`).
Dataview queries surface notes as live dashboards inside Obsidian.
Obsidian Git auto-commits and pushes to GitHub on a 30-minute schedule.

---

## Required Obsidian Plugins

| Plugin | Purpose |
|---|---|
| Templater | Auto-fills template fields |
| Dataview | Query notes like a database |
| Obsidian Git | Auto-sync vault to GitHub |
| Calendar | Daily journal navigation |
| CodeMirror Options | Enhanced code block rendering |

---

## Skill Definition
Full YAML: [`obsidian_skill.yaml`](obsidian_skill.yaml)
Vault: [`obsidian/`](obsidian/)
Repo: https://github.com/maxwellcudjoe/maxsidian
