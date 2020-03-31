#!/usr/bin/env bash

# This script restarts mariadb so it will load the restored database.

source scripts/environment.sh

# Set Minikube context
kubectl config use-context minikube

# Restart mariadb
kubectl delete pod "$(kubectl get pods | grep mariadb | awk '{print $1}')"
