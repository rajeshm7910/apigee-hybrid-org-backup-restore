#!/bin/bash

ORG_NAME=$1
ORG_NAME=${ORG_NAME//[-]/_}
POD_IP=$2
CASS_USER=$3
CASS_PASSWORD=$4


all_keyspaces=$(cqlsh ${CASSANDRA_SEEDS} -u ${APIGEE_DML_USER} -p ${APIGEE_DML_PASSWORD} --ssl  -e 'DESCRIBE KEYSPACES')

for KEYSPACE in $all_keyspaces
do
        if [[ $KEYSPACE == *$ORG_NAME* ]]; then
                  echo $KEYSPACE
                  TABLE_LIST=$(cqlsh ${CASSANDRA_SEEDS} -u ${APIGEE_DML_USER} -p ${APIGEE_DML_PASSWORD} --ssl -e "DESCRIBE KEYSPACE ${KEYSPACE}" | grep "CREATE TABLE" | sed -e 's+CREATE TABLE++' @
                  for table in $TABLE_LIST; do

                           table=${table//$KEYSPACE./}
                           echo "Refreshing " $table
                           nodetool -h $POD_IP -u ${CASS_USER} -pw ${CASS_PASSWORD}  refresh -- ${KEYSPACE} ${table}

                  done
        fi
done
echo "All Keyspaces Refreshed"