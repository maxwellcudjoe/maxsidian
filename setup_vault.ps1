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
Write-Host "  3. Tell Claude: 'Install skill from https://github.com/maxwellcudjoe/maxsidian/tree/master/obsidian'" -ForegroundColor Gray
Write-Host "  4. Claude will now log every task into obsidian/ automatically" -ForegroundColor Gray
Write-Host ""
