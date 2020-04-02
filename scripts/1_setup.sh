#!/usr/bin/env bash

# This script rebuilds the complete minikube cluster in one shot,
# creating a ready-to-use WordPress + MariaDB + Minio environment.

echo ""
echo "••• Launching Code Ready Containers •••"
crc start --nameserver 1.1.1.1 --memory 12288
eval "$(crc oc-env)"

echo ""
echo "••• Login as 'kubeadmin' (copy the password shown in the output of `crc start`) •••"
oc login -u kubeadmin https://api.crc.testing:6443
oc new-project k8up-tutorial

echo ""
echo "••• Installing Secrets •••"
oc apply -f secrets

echo ""
echo "••• Installing Minio •••"
oc apply -f minio

echo ""
echo "••• Installing MariaDB •••"
oc apply -f mariadb

echo ""
echo "••• Installing WordPress •••"
oc apply -f wordpress

echo ""
echo "••• Installing K8up •••"
helm repo add appuio https://charts.appuio.ch
helm repo update
helm install appuio/k8up --generate-name --set k8up.backupImage.tag=v0.1.8-root

echo ""
echo "••• Watch pods •••"
k9s
