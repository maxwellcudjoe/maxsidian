---
title: "LLM Wiki Pattern — Personal Knowledge Base with LLMs"
date: "2026-05-11"
language: "general"
status: "in-progress"
tags: [llm, obsidian, knowledge-management, rag, wiki, architecture]
---

# LLM Wiki Pattern — Personal Knowledge Base with LLMs

## 🧠 Core Idea

Instead of RAG (re-deriving answers from raw documents every query), the LLM **incrementally builds and maintains a persistent wiki** — a structured, interlinked collection of markdown files. Knowledge is compiled once and kept current, not re-derived on every question.

**Key difference from RAG:**
- RAG: LLM reads raw docs → generates answer → forgets
- LLM Wiki: LLM reads raw docs → updates wiki → wiki compounds over time

---

## 🏗️ Three-Layer Architecture

| Layer | Description | Who owns it |
|---|---|---|
| **Raw Sources** | Your active **project/work folder** — the files you're actually working in or on. Immutable source of truth; LLM reads from it but never modifies it. | You |
| **The Wiki** | LLM-generated markdown: summaries, entity pages, concept pages, synthesis | LLM |
| **The Schema** | `CLAUDE.md` / `AGENTS.md` — tells the LLM conventions and workflows | You + LLM co-evolve |

---

## ⚙️ Three Core Operations

### 1. Ingest
- Drop source into raw collection
- LLM reads it, discusses key takeaways
- LLM writes summary page, updates index, updates entity/concept pages, appends to log
- One source may touch 10–15 wiki pages

### 2. Query
- Ask questions → LLM reads index → drills into relevant pages → synthesizes answer with citations
- **Good answers get filed back** into the wiki as new pages (explorations compound)

### 3. Lint
- Periodic health-check: contradictions, stale claims, orphan pages, missing cross-references, data gaps
- LLM suggests new questions and sources to investigate

---

## 📋 Two Special Files

| File | Purpose |
|---|---|
| `index.md` | Content catalog — every page with a one-line summary, organized by category. LLM reads this first on every query. |
| `log.md` | Append-only chronological record of ingests, queries, lint passes. Parseable with grep. |

**Log entry format:** `## [YYYY-MM-DD] ingest | Article Title`

---

## 🔗 How MAXSIDIAN Already Implements This

Your vault **is** the wiki layer. The current structure maps directly:

```
obsidian/
├── Knowledge/       → Concept pages, research, topic summaries
├── Projects/        → Project entity pages
├── Snippets/        → Code/tool references
├── Bug_Fixes/       → Problem/solution pages
├── Daily_Journal/   → Log (chronological record)
└── Prompts/         → Schema snippets / LLM instructions
```

**What's already working:**
- Obsidian is the IDE (graph view, backlinks, Dataview)
- GitHub Copilot / this agent is the LLM programmer
- The `obsidian-logging` skill enforces the "file everything" discipline
- Templates enforce consistent frontmatter (Dataview-queryable)

**Raw sources = your project/work folder:**
No separate `raw/` directory needed. Whichever folder or project you're actively working in *is* the raw sources layer. The LLM reads from it (files, code, docs, configs) but treats everything there as immutable source of truth — it never edits those files. The `obsidian/` vault is the compiled knowledge layer built on top.

**What was added to complete the pattern:**
- ✅ `obsidian/index.md` — master catalog the LLM reads first on every query
- ✅ `obsidian/log.md` — append-only timeline of ingests, queries, lint passes

---

## 🛠️ Optional Tooling

| Tool | Purpose |
|---|---|
| **Obsidian Web Clipper** | Browser extension — converts web articles to markdown |
| **qmd** | Local hybrid BM25/vector search for markdown, has CLI + MCP server |
| **Marp** | Markdown slide decks from wiki content (Obsidian plugin) |
| **Dataview** | Query YAML frontmatter dynamically across pages |

---

## 💡 Why It Works (vs. RAG)

The bottleneck in personal knowledge management is **bookkeeping** — updating cross-references, flagging contradictions, keeping summaries current. Humans abandon wikis because maintenance cost > perceived value. LLMs don't get bored and can touch 15 files in one pass. Maintenance cost → near zero.

**Human role:** curate sources, ask good questions, think about meaning
**LLM role:** summarize, cross-reference, file, flag contradictions, maintain consistency

---

## 🤖 AI Output

### Does MAXSIDIAN already work like this?

**Yes — partially, and well-structured to go all the way.**

| LLM Wiki Component | MAXSIDIAN Status |
|---|---|
| Persistent wiki (markdown files) | ✅ `obsidian/` folder |
| LLM writes/maintains pages | ✅ `obsidian-logging` skill enforces this |
| Structured templates | ✅ Templates in every folder |
| Version history | ✅ Obsidian Git → GitHub auto-push |
| IDE (browse, graph, links) | ✅ Obsidian |
| LLM = programmer, wiki = codebase | ✅ This agent writes; you browse |
| Raw sources (immutable) | ✅ Active project/work folder = raw layer |
| `index.md` (master catalog) | ✅ `obsidian/index.md` created |
| `log.md` (append-only timeline) | ✅ `obsidian/log.md` created |
| Schema doc (LLM conventions) | ✅ `SKILL.md` + `skills/obsidian-logging/SKILL.md` |

**The three things missing** to fully match the LLM Wiki pattern have all been resolved:
- ✅ Raw sources = the active project/work folder (no separate directory needed)
- ✅ `obsidian/index.md` created — master catalog the LLM reads first on every query
- ✅ `obsidian/log.md` created — append-only timeline of what's been done

**The pattern is now fully implemented.** The `obsidian-logging` skill also enforces updating both index and log on every task.

---

## 🔗 Related Notes
- [[GitHub_Auto_Push_Obsidian_Git]]
- [[README]]
