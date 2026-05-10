# 🧠 Obsidian Knowledge Base — Coding Projects

> A structured, Claude-powered knowledge system for managing coding projects, bugs, snippets, prompts, and daily progress — synced with GitHub.

---

## 📁 Vault Structure

```
obsidian/
├── README.md                        ← You are here
├── Projects/
│   └── Project_Template.md          ← One note per project
├── Snippets/
│   └── Snippet_Template.md          ← Reusable code blocks
├── Bug_Fixes/
│   └── Bug_Fix_Template.md          ← Error → solution log
├── Knowledge/
│   └── README.md                    ← Concepts, docs, research
├── Prompts/
│   └── Prompt_Template.md           ← Claude prompt library
└── Daily_Journal/
    └── Daily_Journal_Template.md    ← Daily coding log
```

---

## 🔧 How to Use These Templates with Obsidian

### 1. Install Required Plugins
Open **Settings → Community Plugins** and install:

| Plugin | Purpose |
|---|---|
| **Templater** | Auto-fills template fields using `<% ... %>` syntax |
| **Dataview** | Queries notes like a database using `dataview` code blocks |
| **Calendar** | Daily journal navigation |
| **Tag Wrangler** | Manage and rename tags across vault |

### 2. Configure Templater
- Go to **Settings → Templater**
- Set **Template folder** to `obsidian/` (or your vault subfolder)
- Enable **Trigger Templater on new file creation**
- Enable **Enable system commands** if using `tp.system.exec`

### 3. Create a Note from a Template
- Press `Ctrl+P` → type **"Templater: Create new note from template"**
- Select the template (e.g., `Bug_Fix_Template.md`)
- Templater will prompt you to fill each `tp.system.prompt()` field interactively

### 4. Folder-Specific Templating (Auto-Apply)
- In Templater settings, map each folder to its template:
  - `Bug_Fixes/` → `Bug_Fix_Template.md`
  - `Projects/` → `Project_Template.md`
  - `Daily_Journal/` → `Daily_Journal_Template.md`
- Now, creating any new note in that folder auto-applies the template.

---

## 🤖 How Claude Integrates as a Reasoning Engine

Claude acts as your **AI pair programmer and knowledge curator** inside this vault:

### Workflow
```
You hit a bug
  → Log it in Bug_Fixes/ using the template
  → Paste the error into Claude
  → Claude provides a solution
  → You paste the solution back into the note
  → Tag it, mark Status: Resolved
  → Dataview surfaces it next time the bug recurs
```

### Prompt Strategy (stored in Prompts/)
Each `Prompt_Template.md` stores a reusable Claude prompt so you never write the same instruction twice.

**Example prompts to store:**
- `"Debug this Python traceback and explain the root cause: [ERROR]"`
- `"Refactor this function for readability. Language: [LANG]. Code: [CODE]"`
- `"Explain this concept as if I'm a junior dev: [CONCEPT]"`

### Claude Field in Templates
Every template includes a **Claude Solution** or **Claude Prompts** field — paste Claude's exact response there. This creates a searchable history of AI-assisted work.

---

## 🔄 GitHub Sync — Version Control Your Knowledge

### Initial Setup
```bash
# Inside your obsidian/ folder (or vault root)
git init
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git add .
git commit -m "init: obsidian knowledge base"
git push -u origin main
```

### Daily Sync Routine
```bash
git add .
git commit -m "journal: $(date +%Y-%m-%d) daily notes"
git push
```

### Recommended `.gitignore` for Obsidian Vaults
```gitignore
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.trash/
*.canvas
```

> **Tip:** Use the **Obsidian Git** plugin to auto-commit and push on a schedule directly from inside Obsidian without touching a terminal.

### Obsidian Git Plugin Setup
1. Install **Obsidian Git** from Community Plugins
2. Go to **Settings → Obsidian Git**
3. Set **Auto-commit interval** (e.g., every 30 minutes)
4. Set commit message format: `vault backup: {{date}}`

---

## 🔍 Querying Notes with Dataview

Dataview lets you treat your notes like a database. Add these blocks anywhere in your vault.

### List All Open Bugs
````markdown
```dataview
TABLE error, language, status
FROM "Bug_Fixes"
WHERE status != "Resolved"
SORT file.mtime DESC
```
````

### All Active Projects
````markdown
```dataview
TABLE goals, status
FROM "Projects"
WHERE status = "Active"
```
````

### Today's Journal Entry
````markdown
```dataview
LIST
FROM "Daily_Journal"
WHERE file.day = date(today)
```
````

### Snippets by Language
````markdown
```dataview
TABLE language, use_case
FROM "Snippets"
WHERE language = "Python"
SORT file.ctime DESC
```
````

### All Claude Prompts Tagged #reusable
````markdown
```dataview
LIST
FROM "Prompts"
WHERE contains(tags, "reusable")
```
````

---

## 🏷️ Tagging Convention

Use consistent tags across all notes for powerful filtering:

| Tag | Usage |
|---|---|
| `#bug` | Bug fix notes |
| `#snippet` | Code snippets |
| `#project` | Project notes |
| `#claude` | Claude-assisted content |
| `#resolved` | Closed bugs / completed tasks |
| `#active` | In-progress work |
| `#python` / `#js` / `#ts` | Language-specific |
| `#reusable` | Prompts or snippets worth reusing |
| `#review` | Notes that need follow-up |

---

## 📌 Quick Reference

| Action | Shortcut / Command |
|---|---|
| New note from template | `Ctrl+P` → Templater: Create new note |
| Open daily journal | `Ctrl+P` → Calendar: Open today |
| Search vault | `Ctrl+Shift+F` |
| Graph view | `Ctrl+G` |
| Toggle Dataview block | Render in Reading View |

---

*Built for developers. Powered by Claude. Synced with GitHub.*
