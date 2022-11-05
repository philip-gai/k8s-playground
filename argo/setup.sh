#!/bin/bash
set -e

# Taken from https://argo-cd.readthedocs.io/en/stable/#getting-started
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
