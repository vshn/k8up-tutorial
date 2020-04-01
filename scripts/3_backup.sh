#!/usr/bin/env bash

# This script triggers a backup job

eval "$(crc oc-env)"

# Trigger backup
oc apply -f k8up/backup.yaml
