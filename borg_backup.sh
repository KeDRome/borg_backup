#!/bin/bash
USER=$1
HOST=$2
CWDir=$(pwd)
CDate=$(date +%A-%T)

BORG_SERVER="$USER@$HOST"

TARGET_DIRS=${3}
REPOSITORY="$BORG_SERVER:$(hostname)"
LOG_PATH="/home/borg/logg+$CDate.log"

init_repo (){
	borg init -e none $REPOSITORY
}
create_backup (){
	borg create --critical --exclude-from /home/borg/list \
	--stats $REPOSITORY::"$CDate" \
	$(echo $TARGET_DIRS | tr ',' ' ') > $LOG_PATH 2>&1 && \
        cat $LOG_PATH > /home/borg/log_for_zabbix && \	
}

# Пытается инициализировать репозиторий, на случай если репо отсутсвует
init_repo && create_backup || \
	create_backup