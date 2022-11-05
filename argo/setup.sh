#!/bin/bash
set -e

# Taken from https://argo-cd.readthedocs.io/en/stable/#getting-started
echo "Creating Argo CD namespace"
kubectl create namespace argocd || true

echo "Installing Argo CD"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

password=$(
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  echo
)
echo "ArgoCD password: $password"

# Run Argo CD using port forwarding
echo "Running Argo CD using port forwarding"
kubectl port-forward svc/argocd-server -n argocd 8080:443 &

# Wait for the port to forward
sleep 3

# Login via CLI
echo "Logging in via CLI"
argocd login 'localhost:8080' --username admin --password $password --insecure

# Open Argo CD UI
echo "Open Argo CD UI by navigating to http://localhost:8080 in your browser"
