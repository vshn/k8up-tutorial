#!/usr/bin/env bash

eval "$(crc oc-env)"

echo "WordPress: http://$(oc get route | grep wordpress | awk '{print $2}')"
echo "Minio: http://$(oc get route | grep minio | awk '{print $2}')"
