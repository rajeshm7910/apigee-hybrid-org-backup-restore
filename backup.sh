#!/bin/bash

orgname=$1
backup_num=$(date +%s)
orgname=${orgname//[-]/_}


nodetool -h $POD_IP -u cassandra -pw ${CASS_PASSWORD} snapshot -t kms_${orgname}_hybrid_${backup_num}  kms_${orgname}_hybrid
nodetool -h $POD_IP -u cassandra -pw ${CASS_PASSWORD} snapshot -t kvm_${orgname}_hybrid_${backup_num}  kvm_${orgname}_hybrid
nodetool -h $POD_IP -u cassandra -pw ${CASS_PASSWORD} snapshot -t cache_${orgname}_hybrid_${backup_num}  cache_${orgname}_hybrid
nodetool -h $POD_IP -u cassandra -pw ${CASS_PASSWORD} snapshot -t rtc_${orgname}_hybrid_${backup_num}  rtc_${orgname}_hybrid
nodetool -h $POD_IP -u cassandra -pw ${CASS_PASSWORD} snapshot -t quota_${orgname}_hybrid_${backup_num}  quota_${orgname}_hybrid


tar czf ${orgname}_hybrid_${backup_num}.tar.gz  data/apigee-cassandra/data/kms_${orgname}_hybrid/*/snapshots/kms_${orgname}_hybrid_${backup_num} \
data/apigee-cassandra/data/kvm_${orgname}_hybrid/*/snapshots/kvm_${orgname}_hybrid_${backup_num} \
data/apigee-cassandra/data/cache_${orgname}_hybrid/*/snapshots/cache_${orgname}_hybrid_${backup_num} \
data/apigee-cassandra/data/rtc_${orgname}_hybrid/*/snapshots/rtc_${orgname}_hybrid_${backup_num}  \
data/apigee-cassandra/data/quota_${orgname}_hybrid/*/snapshots/quota_${orgname}_hybrid_${backup_num}
