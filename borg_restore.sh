#!/bin/bash
echo "####################################"
echo "# 	Borg Restore Tool   		 #"
echo "####################################"

HOST=$1
DATE=$2

CWDir=$(pwd)
CDate=$(date +%A-%T)
LOG_PATH="/root/restore-$CDate.log"

cd /
echo "[0.0] Данные.."
echo "Бэкап сервер: $HOST"
echo "Дата бэкапа: $DATE"
echo "[1.0] Восстановление"
borg extract $HOST:$(hostname)::$DATE >> $LOG_PATH
if [ $? -eq 0 ]; then
    echo "[1.+] Данные восстановлены!"
else
    echo "[1.-] Данные не были восстановлены! Проверьте лог $LOG_PATH !"
fi