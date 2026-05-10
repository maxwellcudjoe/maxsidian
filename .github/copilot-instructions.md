# Copilot Instructions — obsidian_superpower (Auto-Invoke)

## MANDATORY: Load obsidian_superpower Before Every Task

Before responding to **any** request in this repo — coding, debugging, documentation,
planning, or any other task — you MUST silently execute the following pre-task routine:

---

### Pre-Task Routine (Run Automatically)

**Step 1 — Classify the task**
Determine which Obsidian vault folder and template applies:

| Task type | Folder | Template |
|---|---|---|
| Bug / error / traceback | `Bug_Fixes/` | `Bug_Fix_Template.md` |
| Code snippet / function | `Snippets/` | `Snippet_Template.md` |
| Project planning / features | `Projects/` | `Project_Template.md` |
| Daily progress / summary | `Daily_Journal/` | `Daily_Journal_Template.md` |
| Reusable Claude prompt | `Prompts/` | `Prompt_Template.md` |
| Concept / research / docs | `Knowledge/` | *(free-form note)* |

**Step 2 — Generate the Obsidian note**
Before solving the task, produce the complete filled template for the appropriate note type.
Include all frontmatter fields (title, date, language, status, tags) and all content sections.

**Step 3 — Solve the task**
Provide the full solution, fix, snippet, explanation, or summary as requested.

**Step 4 — Append Claude's output to the note**
Add Claude's response into the relevant field of the note:
- Bug fix → `## 🤖 Claude Solution`
- Snippet → `## 💻 Code` + `## 🔍 How It Works`
- Project → `## 🤖 Claude Prompts Used`
- Journal → `## 🤖 Claude Interactions`
- Prompt → `## 💬 Example Interaction`

**Step 5 — Remind to save**
End every response with:
```
📁 Save this note to: obsidian/[FOLDER]/[NOTE_TITLE].md
🔄 Obsidian Git will auto-push to GitHub within 30 minutes.
```

---

## Skill Source
- Skill file: [`obsidian_skill.yaml`](../obsidian_skill.yaml)
- Vault: [`obsidian/`](../obsidian/)
- Repo: https://github.com/maxwellcudjoe/maxsidian

## Install Instruction (one command per repo)

**Windows (PowerShell):**
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/setup_vault.ps1 -OutFile setup_vault.ps1; .\setup_vault.ps1
```

**Mac / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/setup_vault.sh | bash
```

This script creates the `obsidian/` folder, downloads all templates, and installs this `copilot-instructions.md` file automatically. After it runs once, Claude auto-invokes `obsidian_superpower` on every task in this repo with no further setup.
