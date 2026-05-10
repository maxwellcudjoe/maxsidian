# setup_vault.ps1
# Obsidian Superpower — Vault Setup Script (Windows)
# Run this once in any repo to create the obsidian/ folder structure.
# Usage: .\setup_vault.ps1

$vault = "obsidian"
$folders = @("Projects", "Snippets", "Bug_Fixes", "Knowledge", "Prompts", "Daily_Journal")
$remote = "https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/obsidian"

Write-Host ""
Write-Host "🧠 obsidian_superpower — Vault Setup" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Create folders
foreach ($folder in $folders) {
    $path = "$vault/$folder"
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Host "  ✅ Created $path" -ForegroundColor Green
    } else {
        Write-Host "  ⏩ Already exists: $path" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "📥 Downloading templates from maxsidian..." -ForegroundColor Cyan
Write-Host ""

# Template map: folder => filename
$templates = @{
    "Projects"     = "Project_Template.md"
    "Snippets"     = "Snippet_Template.md"
    "Bug_Fixes"    = "Bug_Fix_Template.md"
    "Prompts"      = "Prompt_Template.md"
    "Daily_Journal"= "Daily_Journal_Template.md"
    "Knowledge"    = "README.md"
}

foreach ($folder in $templates.Keys) {
    $file     = $templates[$folder]
    $dest     = "$vault/$folder/$file"
    $url      = "$remote/$folder/$file"

    if (-not (Test-Path $dest)) {
        try {
            Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
            Write-Host "  ✅ Downloaded $dest" -ForegroundColor Green
        } catch {
            Write-Host "  ⚠️  Could not download $file — create it manually from:" -ForegroundColor Red
            Write-Host "      $url" -ForegroundColor Gray
        }
    } else {
        Write-Host "  ⏩ Template already exists: $dest" -ForegroundColor Yellow
    }
}

# Download root README
$readmeDest = "$vault/README.md"
$readmeUrl  = "$remote/README.md"
if (-not (Test-Path $readmeDest)) {
    try {
        Invoke-WebRequest -Uri $readmeUrl -OutFile $readmeDest -UseBasicParsing
        Write-Host "  ✅ Downloaded $readmeDest" -ForegroundColor Green
    } catch {
        Write-Host "  ⚠️  Could not download obsidian/README.md" -ForegroundColor Red
    }
}

# Install copilot-instructions.md so Claude auto-invokes the skill immediately
Write-Host ""
Write-Host "🤖 Installing Claude skill (copilot-instructions.md)..." -ForegroundColor Cyan
$githubDir  = ".github"
$instrDest  = "$githubDir/copilot-instructions.md"
$instrUrl   = "https://raw.githubusercontent.com/maxwellcudjoe/maxsidian/master/.github/copilot-instructions.md"
if (-not (Test-Path $githubDir)) {
    New-Item -ItemType Directory -Path $githubDir -Force | Out-Null
}
if (-not (Test-Path $instrDest)) {
    try {
        Invoke-WebRequest -Uri $instrUrl -OutFile $instrDest -UseBasicParsing
        Write-Host "  ✅ Installed $instrDest" -ForegroundColor Green
        Write-Host "  ℹ️  Claude will now auto-invoke obsidian_superpower in this repo" -ForegroundColor Cyan
    } catch {
        Write-Host "  ⚠️  Could not download copilot-instructions.md" -ForegroundColor Red
    }
} else {
    Write-Host "  ⏩ copilot-instructions.md already present" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📄 Adding obsidian/ to .gitignore exceptions..." -ForegroundColor Cyan
$gitignorePath = ".gitignore"
$ignoreEntries = @(
    "",
    "# Obsidian vault",
    ".obsidian/workspace.json",
    ".obsidian/workspace-mobile.json",
    ".trash/",
    "*.canvas"
)
foreach ($entry in $ignoreEntries) {
    $existing = Get-Content $gitignorePath -ErrorAction SilentlyContinue
    if (-not ($existing -contains $entry)) {
        Add-Content $gitignorePath $entry
    }
}
Write-Host "  ✅ .gitignore updated" -ForegroundColor Green

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "✅ Vault setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "  1. Open this repo folder as your Obsidian vault" -ForegroundColor Gray
Write-Host "  2. Install plugins: Templater, Dataview, Obsidian Git, Calendar" -ForegroundColor Gray
Write-Host "  3. Claude will auto-invoke obsidian_superpower on every task — no setup needed" -ForegroundColor Gray
Write-Host ""
