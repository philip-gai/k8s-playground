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
echo "Changing Argo CD API Server type to LoadBalancer"
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Wait for the port to forward
sleep 3

ipAddress=$(kubectl -n argocd get service argocd-server -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
echo "ArgoCD IP Address: $ipAddress"

# Login via CLI
echo "Logging in via CLI"
argocd login $ipAddress --username admin --password $password --insecure

# Open Argo CD UI
echo "Open Argo CD UI by navigating to http://$ipAddress in your browser"
