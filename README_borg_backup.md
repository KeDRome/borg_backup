# Borg Backup Tool
Этот скрипт позволяет выполнять **резервное инкрементальное копирование конкретных каталогов** или **всей системы**. Доставьте его на бэкап клиента.
>sh ./borg_backup.sh [hostname|borgsrv] [target_dir|d]

**Пример: ./borg_backup.sh borgsrv /mnt**

В результате будет создана резервная копия каталога **/mnt** и отправлена на бэкап сервер **borgsrv**

# Зависимости
## Имя бэкап сервера
### **[hostname|borgsrv]**
Здесь, вы должны убедится, что указываете **НЕ IP адрес бэкап сервера, а 'Host'** из SSH-конфига!

Если вы выполняли подготовку описаную [здесь](./README.md), то во время подготовки **хоста бэкап клиента**, вы создавали **/root/.ssh/config**. 

## Цель бэкапа
### **[target_dir|d]**
Укажите в этом пункте **полный путь к каталогу**, который подвергнется бэкапу. Или укажите **'d'**, для копирования всей системы.
