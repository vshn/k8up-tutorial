#!/usr/bin/env bash

# This script restores the contents of a backup to its rightful PVCs.
# After the pods that perform the restore operation are "Completed",
# execute the '5_restore_files.sh' script,
# and after that the '6_delete_restore_pods.sh' script.

source scripts/environment.sh

eval "$(crc oc-env)"

# Restore WordPress PVC
restic snapshots --json --last --path /data/wordpress-pvc | python scripts/customize.py wordpress | oc apply -f -

# Read SQL data from Restic into file
SNAPSHOT_ID=$(restic snapshots --json --last --path /default-mariadb | jq -r '.[0].id')
restic dump "${SNAPSHOT_ID}" /default-mariadb > backup.sql

# Restore MariaDB data
MARIADB_POD=$(kubectl get pods | grep mariadb | awk '{print $1}')
oc cp backup.sql "$MARIADB_POD":/
oc cp scripts/db_restore.sh "$MARIADB_POD":/
oc exec "$MARIADB_POD" -- /db_restore.sh
