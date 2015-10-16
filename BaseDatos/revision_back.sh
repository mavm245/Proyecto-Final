#!/bin/bash

#Used programs

RM=/bin/rm
CAT=/bin/cat
ECHO=/bin/echo
MKDIR=/bin/mkdir
MD5=/usr/bin/md5sum
SHA1=/usr/bin/sha1sum
PG_DUMP=/usr/bin/pg_dump

DATE=`date +%F_%R`
PG_STATUS=''

#Connections Parameters
IP_DB='192.168.7.2'
IP_PORT='5432'
IP_BACK='localhost'
DATABASE='revisiones_drupal'
PG_USER='postgres'

BACKUP_DIR=$HOME/pg_dump/$IP_DB/$DATABASE
if [ ! -d $BACKUP_DIR ]
then
	$MKDIR -p $BACKUP_DIR
fi

#Files
PG_DUMP_STATUS=''
LOG_FILE=$BACKUP_DIR/$DATABASE.$DATE.pg_backup.log
DUMP_FILE=$BACKUP_DIR/$DATABASE.$DATE.pg_dump

function backup
{
	$PG_DUMP \
	-i \
	--verbose \
	-U $PG_USER \
	--host=$IP_DB \
	--port=$PORT_DB \
	$DATABASE \
	--file $DUMP_FILE \
	2>>$LOG_FILE 1>>$LOG_FILE

	PG_STATUS=$?

	if [ ! -s $DUMP_FILE ]
	then
		$ECHO " pg_dump died with status $PG_STATUS."
	fi
}	

backup	

exit 0;
