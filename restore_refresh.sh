#!/bin/bash

ORG_NAME=$1
ORG_NAME=${orgname//[-]/_}

all_keyspaces=$(cqlsh ${CASSANDRA_SEEDS} -u ${APIGEE_DML_USER} -p ${APIGEE_DML_PASSWORD} --ssl  -e 'DESCRIBE KEYSPACES')
for KEYSPACE in $all_keyspaces
do
        if [[ $KEYSPACE == *$ORG_NAME* ]]; then
          	echo $KEYSPACE
          	TABLE_LIST=`cqlsh -e "DESCRIBE KEYSPACE ${KEYSPACE}" | grep "CREATE TABLE" | sed -e 's+CREATE TABLE++' | sed -e 's+(++'`
          	for table in $TABLE_LIST; do
          		echo $table
          		#nodetool refresh -- ${KEYSPACE} ${table}
          	done
        fi
done