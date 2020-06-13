#!/bin/bash

DB=traveler
# the 
BACKUP_DIR=/backup
DATE=`date +"%F-%k-%M-%S"`

if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p $BACKUP_DIR
fi

mongodump -u traveler -p travelerpassword --authenticationDatabase admin --db $DB --out /tmp/${DB}db-$DATE
tar czf $BACKUP_DIR/${DB}db-$DATE.tgz -C /tmp ${DB}db-$DATE
rm -rf /tmp/${DB}db-$DATE

find $BACKUP_DIR -mtime +7 -exec rm {} \;
