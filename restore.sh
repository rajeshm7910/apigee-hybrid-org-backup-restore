#!/bin/bash

ORG_NAME=$1
BACKUP_DIR=$2
CASS_DIR=$3
CASS_BACKUP_NUM=$4

cd $BACKUP_DIR
for d in * ; do
  echo $d
  mkdir -p $CASS_DIR/$d/
  cp -fr $d/snapshots/$CASS_BACKUP_NAME/* $CASS_DIR/$d/
  chown -R apigee:apigee $CASS_DIR/$d/
  cd -
done
#Refresh all keyspaces and their tables 
