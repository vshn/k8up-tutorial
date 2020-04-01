#!/usr/bin/env bash

source scripts/environment.sh

eval "$(crc oc-env)"

# Set the schedule
oc apply -f k8up/schedule.yaml

# Watch how the number of snapshots grow
watch restic snapshots
