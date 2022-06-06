#!/bin/bash
echo "####################################"
echo "#	Borg Backup Tool	   #"
echo "####################################"


HOST=$1

CWDir=$(pwd)
CDate=$(date +%A-%T)

BORG_SERVER="$HOST"

TARGET_DIRS=${2}
TARGET_DIRS_by_default='/'
REPOSITORY="$BORG_SERVER:$(hostname)"
LOG_PATH="/root/backup-$CDate.log"

make_exclude_list (){
	touch $CWDir/list
	echo "/sys" >> list
	echo "/proc" >> list
}
make_exclude_list

init_repo (){
	borg init -e none $REPOSITORY
}
create_backup (){
	borg create --critical --exclude-from=$CWDir/list \
	--stats $REPOSITORY::"$CDate" \
	$(echo $TARGET_DIRS | tr ',' ' ') > $LOG_PATH 2>&1
	if [ $? -eq 0 ]; then
		echo "[2.+] Копирование успешно завершено!"
		echo "Имя резервной копии: $CDate"
	else
		echo "[2.-] Во время копирования произошли ошибки! Проверьте лог: $LOG_PATH"
	fi
}


echo "[0.0] Проверка пользователя"
if [[ $HOST == "borgsrv" ]]; then
	echo "[0.1.+] Выбран хост по умолчанию: $HOST"
else
	echo "[0.1.-] Выбран ваш хост: $HOST"
fi
echo "[0.2] Проверка каталогов выбранных для бэкапа"
if [[ $TARGET_DIRS == "d" || $TARGET_DIRS == $TARGET_DIRS_by_default ]]; then
	TARGET_DIRS=$TARGET_DIRS_by_default
	echo "[0.2.+] Выбран каталог по умолчанию.. $TARGET_DIRS"
else 
	echo "[0.2.+] Выбран ваш каталог.. $TARGET_DIRS"
fi
# Пытается инициализировать репозиторий, на случай если репо отсутсвует
echo "[1.0] Инициализация репозитория"
echo "[1.1] Выполняем инициализацию репозитория $( hostname)"
init_repo
if [ $? -eq 0 ]; then
	echo "[1.1.+] Репозиторий успешно инициализирован!"
	echo "[2.0] Копирование данных"
	create_backup
else
	echo "[1.1.~] Репозиторий уже существует!"
	echo "[2.0] Копирование данных"
	create_backup
fi
rm $CWDir/list