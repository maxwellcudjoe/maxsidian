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

# Install .github/copilot-instructions.md so AI auto-discovers the skill
echo ""
echo "🤖 Installing .github/copilot-instructions.md..."
mkdir -p .github
INSTR_DEST=".github/copilot-instructions.md"
INSTR_URL="https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/.github/copilot-instructions.md"
if [ ! -f "$INSTR_DEST" ]; then
    if curl -fsSL "$INSTR_URL" -o "$INSTR_DEST" 2>/dev/null; then
        echo "  ✅ Installed $INSTR_DEST"
        echo "  ℹ️  AI will now load obsidian-logging skill before every task"
    else
        echo "  ⚠️  Could not download copilot-instructions.md"
    fi
else
    echo "  ⏩ copilot-instructions.md already present"
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
echo "  2. Install plugins: Templater, Dataview, Obsidian Git, Calendar"
echo "  3. Claude will auto-invoke obsidian_superpower on every task — no setup needed"
echo ""
