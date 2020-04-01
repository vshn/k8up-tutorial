export KUBECONFIG=""
export RESTIC_REPOSITORY=s3:$(oc get route | grep minio | awk '{print $2}')/backups/
export RESTIC_PASSWORD=p@ssw0rd
export AWS_ACCESS_KEY_ID=minio
export AWS_SECRET_ACCESS_KEY=minio123
