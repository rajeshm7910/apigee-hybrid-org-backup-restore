# apigee-hybrid-org-backup-restore

## How to Test

### Backup Steps
1. Spin up a apigee-cassandra client 
2. Go to the Cassandra Client
kubectl exec -it apigee-cassandra-client -n apigee -- bash
3. Take Schema backup 
./backup_schema.sh <<org-name>>

4. Go to apigee cassandra pod one after the other and take the backup snapshot

kubectl exec -it apigee-cassandra-default-0 -n apigee -- bash
./backup_data.sh <<orgname>>

5. Repeat Step 4 for other pods


### Restore Steps

1. Spin up a apigee-cassandra client 
2. Go to the Cassandra Client
kubectl exec -it apigee-cassandra-client -n apigee -- bash

3. Restore Org Schema
./restore_schema.sh <<backup_schema_file>>

4. Go to the cassandra pod default-0 and restore the data

kubectl exec -it apigee-cassandra-default-0 -n apigee -- bash
./restore_data.sh <<orgname>> <backup_file>> <<cassandra_data_dir>> <<backup_num>>

for example
./restore_data.sh anthos-vm-example1  /opt/apigee/backup/data/apigee-cassandra/data/ /opt/apigee/data/apigee-cassandra/data/  1661799377

5. Refresh the cassandra pods for new SSTables to take effect

Go to the Cassandra Client
./restore_refresh.sh <<orgname>> <<pod_ip>> <<cassandra_user>> <cassandra_password>>

for ex:
./restore_refresh.sh anthos-bm-example1 20.0.0.45 cassandra apigee123

