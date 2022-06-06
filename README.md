# Borg Backup
## Подготовка места: **Бэкап клиент**
### Установка borg
1. Скачайте пакет с оффициального репозитория:
> wget https://github.com/borgbackup/borg/releases/download/1.2.1/borg-linux64 -O /usr/local/bin/borg && 
chmod +x /usr/local/bin/borg
### Дать доступ к бэкап клиенту
2. Сгенерируйте SSH-ключ, для пользователя, который имеет полный доступ к тем каталогам, которые подвергнутся бэкапу  
(В нашем примере пользователь - **root**): 
> su root -c ssh-keygen
3. Просмотрите 
> cat /root/.ssh/id_rsa.pub
4. Создайте config:
> vim /root/.ssh/config \
**_________________________________**\
Host **borgsrv**    \
    HostName **[ip_address_of_Borg_server]** \
    Port **[Ваш_SSH_port]** #По умолчанию, 22 \
    User **borg**   \
    IdentityFile /root/.ssh/id_rsa   
**_________________________________**
5. Добавьте разрешающее правило в Firewall:
> ufw allow 22/tcp
## Подготовка места: **Бэкап сервер**
### Установка borg
1. Скачайте пакет с оффициального репозитория:
> wget https://github.com/borgbackup/borg/releases/download/1.2.1/borg-linux64 -O /usr/local/bin/borg && \
chmod +x /usr/local/bin/borg
### Получить доступ к бэкап клиенту 
2. Создайте пользователя для выполнения бэкапов:
> useradd -m borg
3. Добавьте каталог, для хранения SSH-ключей:
> mkdir ~borg/.ssh
4. Добавьте пользователю borg , ключ который мы недавно создавали: 
> echo 'command="/usr/local/bin/borg serve" [МЕСТО_ДЛЯ_ВАШЕГО_КЛЮЧА,_БЕЗ_СКОБОК]' >> ~borg/.ssh/authorized_keys
5. Меняем владельца каталога на borg
> chown -R borg:borg ~borg/.ssh
6. Добавьте разрешающее правило в Firewall:
> ufw allow 22/tcp
## Места подготовлены!
### [**Создание резервных копий:** Использование скрипта borg_backup.sh](./README_borg_backup.md)
### [**Восстановление данных:** Использование скрипта borg_restore.sh](./README_borg_restore.md)
