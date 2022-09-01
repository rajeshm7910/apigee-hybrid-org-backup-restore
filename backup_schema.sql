#!/bin/bash

orgname=$1
orgname=${orgname//[-]/_}

all_keyspaces=$(cqlsh ${CASSANDRA_SEEDS} -u ${APIGEE_DML_USER} -p ${APIGEE_DML_PASSWORD} --ssl  -e 'DESCRIBE KEYSPACES')
for keyspace in $all_keyspaces
do
        if [[ $keyspace == *$orgname* ]]; then
          echo $keyspace
          cqlsh ${CASSANDRA_SEEDS} -u ${APIGEE_DML_USER} -p ${APIGEE_DML_PASSWORD} --ssl  -e "DESCRIBE KEYSPACE  ${keyspace}"  >> backup_schema.sql
        fi
done