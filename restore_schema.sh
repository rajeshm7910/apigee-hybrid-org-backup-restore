#!/bin/bash

backup_schema_file=$1
cqlsh ${CASSANDRA_SEEDS} -u ${APIGEE_DML_USER} -p ${APIGEE_DML_PASSWORD} --ssl  -f ${backup_schema_file} 
