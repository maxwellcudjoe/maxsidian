#!/usr/bin/env bash
# setup_vault.sh
# Obsidian Superpower — Vault Setup Script (Mac / Linux)
# Run this once in any repo to create the obsidian/ folder structure.
# Usage: bash setup_vault.sh

VAULT="obsidian"
REMOTE="https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/obsidian"
FOLDERS=("Projects" "Snippets" "Bug_Fixes" "Knowledge" "Prompts" "Daily_Journal")

echo ""
echo "🧠 obsidian_superpower — Vault Setup"
echo "======================================"
echo ""

# Create folders
for folder in "${FOLDERS[@]}"; do
    path="$VAULT/$folder"
    if [ ! -d "$path" ]; then
        mkdir -p "$path"
        echo "  ✅ Created $path"
    else
        echo "  ⏩ Already exists: $path"
    fi
done

echo ""
echo "📥 Downloading templates from maxsidian..."
echo ""

# Template map: folder:filename
declare -A TEMPLATES=(
    ["Projects"]="Project_Template.md"
    ["Snippets"]="Snippet_Template.md"
    ["Bug_Fixes"]="Bug_Fix_Template.md"
    ["Prompts"]="Prompt_Template.md"
    ["Daily_Journal"]="Daily_Journal_Template.md"
    ["Knowledge"]="README.md"
)

for folder in "${!TEMPLATES[@]}"; do
    file="${TEMPLATES[$folder]}"
    dest="$VAULT/$folder/$file"
    url="$REMOTE/$folder/$file"

    if [ ! -f "$dest" ]; then
        if curl -fsSL "$url" -o "$dest" 2>/dev/null; then
            echo "  ✅ Downloaded $dest"
        else
            echo "  ⚠️  Could not download $file — get it manually from:"
            echo "      $url"
        fi
    else
        echo "  ⏩ Template already exists: $dest"
    fi
done

# Download root README
readme_dest="$VAULT/README.md"
readme_url="$REMOTE/README.md"
if [ ! -f "$readme_dest" ]; then
    if curl -fsSL "$readme_url" -o "$readme_dest" 2>/dev/null; then
        echo "  ✅ Downloaded $readme_dest"
    else
        echo "  ⚠️  Could not download obsidian/README.md"
    fi
fi

# Install skills/obsidian-logging/SKILL.md (obra/superpowers-style skill file)
echo ""
echo "🧩 Installing skills/obsidian-logging/SKILL.md..."
mkdir -p "skills/obsidian-logging"
SKILL_DEST="skills/obsidian-logging/SKILL.md"
SKILL_URL="https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/skills/obsidian-logging/SKILL.md"
if [ ! -f "$SKILL_DEST" ]; then
    if curl -fsSL "$SKILL_URL" -o "$SKILL_DEST" 2>/dev/null; then
        echo "  ✅ Installed $SKILL_DEST"
    else
        echo "  ⚠️  Could not download SKILL.md — get it manually from:"
        echo "      $SKILL_URL"
    fi
else
    echo "  ⏩ SKILL.md already present"
fi

# Install IDE-specific instruction files so skill auto-triggers in every AI tool
echo ""
echo "🤖 Installing IDE instruction files..."
BASE_URL="https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master"

IDE_FILES=(
    ".github/copilot-instructions.md"
    "CLAUDE.md"
    "AGENTS.md"
    ".cursorrules"
    ".windsurfrules"
)

for dest in "${IDE_FILES[@]}"; do
    dir=$(dirname "$dest")
    [ "$dir" != "." ] && mkdir -p "$dir"
    if [ ! -f "$dest" ]; then
        if curl -fsSL "$BASE_URL/$dest" -o "$dest" 2>/dev/null; then
            echo "  ✅ Installed $dest"
        else
            echo "  ⚠️  Could not download $dest"
        fi
    else
        echo "  ⏩ Already present: $dest"
    fi
done

# Bootstrap obsidian/index.md and obsidian/log.md
echo ""
echo "🗂️  Bootstrapping index.md and log.md..."
TODAY=$(date +%Y-%m-%d)

INDEX_DEST="$VAULT/index.md"
if [ ! -f "$INDEX_DEST" ]; then
    cat > "$INDEX_DEST" << EOF
---
title: "Wiki Index"
date: "$TODAY"
tags: [index, meta]
---

# Wiki Index

Master catalog of all pages in this vault.
The LLM reads this first on every query to locate relevant pages before drilling in.
Updated automatically on every ingest, query result saved, or new note created.

> **Raw Sources:** The active project/work folder is the immutable source layer. The LLM reads from it but never modifies it.

---

## 📚 Knowledge

| Page | Summary |
|---|---|

## 🗂️ Projects

| Page | Summary |
|---|---|

## 🐛 Bug Fixes

| Page | Summary |
|---|---|

## 💻 Snippets

| Page | Summary |
|---|---|

## 💬 Prompts

| Page | Summary |
|---|---|

## 📓 Daily Journal

| Page | Summary |
|---|---|
EOF
    echo "  ✅ Created $INDEX_DEST"
else
    echo "  ⏩ Already exists: $INDEX_DEST"
fi

LOG_DEST="$VAULT/log.md"
if [ ! -f "$LOG_DEST" ]; then
    cat > "$LOG_DEST" << EOF
# Wiki Log

Append-only chronological record of all operations performed on this vault.
Each entry format: \`## [YYYY-MM-DD] <operation> | <title>\`

Operations: \`ingest\` · \`query\` · \`lint\` · \`setup\`

---

## [$TODAY] setup | Vault bootstrapped

- Created obsidian/ folder structure and templates
- Installed IDE instruction files (copilot-instructions.md, CLAUDE.md, AGENTS.md, .cursorrules, .windsurfrules)
- Created obsidian/index.md and obsidian/log.md
EOF
    echo "  ✅ Created $LOG_DEST"
else
    echo "  ⏩ Already exists: $LOG_DEST"
fi

echo ""
echo "📄 Adding obsidian/ entries to .gitignore..."
GITIGNORE=".gitignore"
IGNORE_ENTRIES=(
    ""
    "# Obsidian vault"
    ".obsidian/workspace.json"
    ".obsidian/workspace-mobile.json"
    ".trash/"
    "*.canvas"
)
for entry in "${IGNORE_ENTRIES[@]}"; do
    if ! grep -qxF "$entry" "$GITIGNORE" 2>/dev/null; then
        echo "$entry" >> "$GITIGNORE"
    fi
done
echo "  ✅ .gitignore updated"

echo ""
echo "======================================"
echo "✅ Vault setup complete!"
echo ""
echo "Next steps:"
echo "  1. Open this repo folder as your Obsidian vault"
echo "  2. Install Obsidian plugins: Templater, Dataview, Calendar"
echo "  3. The LLM will auto-invoke obsidian_superpower on every task:"
echo "     VS Code       -> .github/copilot-instructions.md"
echo "     Claude Code   -> CLAUDE.md"
echo "     Codex/ChatGPT -> AGENTS.md"
echo "     Cursor        -> .cursorrules"
echo "     Windsurf      -> .windsurfrules"
echo ""
