$ErrorActionsPreference = 'Stop'

Write-Host "Installing Homebrew"
bash $PSScriptRoot/install-homebrew.sh
if (!$?) { throw "Failed to install Homebrew" }

Write-Host "Installing tools"
bash $PSScriptRoot/install-tools.sh
if (!$?) { throw "Failed to install tools" }

helm repo add datadog https://helm.datadoghq.com
helm repo update
