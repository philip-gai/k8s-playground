#!/bin/bash
set -e

# Taken from https://argo-cd.readthedocs.io/en/stable/#getting-started
kubectl create namespace argocd || true
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

brew install argocd
password=$(
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  echo
)
echo "ArgoCD password: $password"

# Run Argo CD using port forwarding
kubectl port-forward svc/argocd-server -n argocd 8080:443 &

# Wait for the port to forward
sleep 3

# Login via CLI
argocd login 'localhost:8080' --username admin --password $password

# Open Argo CD UI
sudo apt-get update -y
sudo apt-get install -y xdg-utils
xdg-open http://localhost:8080 & # Open in browser
