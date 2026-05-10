# obsidian_superpower — Skills System

## The Rule

**Before responding to ANY request, check whether a skill applies and invoke it.**
Even a 1% chance a skill might apply means you MUST read and follow it.
Skills are mandatory workflows, not suggestions.

## How to Use Skills

Skills live in `skills/[skill-name]/SKILL.md`.
To invoke a skill, read its file and follow the instructions exactly:

```
read_file("skills/[skill-name]/SKILL.md")
```

Announce before invoking: `Using [skill-name] to [purpose].`

## Available Skills

| Skill | File | When to invoke |
|---|---|---|
| `obsidian-logging` | `skills/obsidian-logging/SKILL.md` | **Every task** — coding, debugging, planning, documentation, explanation, or any other request |

## Skill Priority

`obsidian-logging` applies to **every** request in this repo. There are no exceptions.
Read the skill file before producing any response.

---

## Install Instruction (one command per repo)

**Windows (PowerShell):**
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/setup_vault.ps1 -OutFile setup_vault.ps1; .\setup_vault.ps1
```

**Mac / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/setup_vault.sh | bash
```
