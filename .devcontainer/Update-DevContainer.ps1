$ErrorActionsPreference = 'Stop'

Write-Host "Installing Homebrew"
bash $PSScriptRoot/install-homebrew.sh
if (!$?) { throw "Failed to install Homebrew" }
