#!/bin/bash
set -e

# Argo CD
echo "Installing Argo CD"
brew install argocd

echo "Installing xdg-utils"
sudo apt-get update -y
sudo apt-get install -y xdg-utils
