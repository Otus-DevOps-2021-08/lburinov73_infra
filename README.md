# lburinov73_infra
lburinov73 Infra repository

## домашнее задание N3 (cloud-bastion)
Данные для подключения:
```
bastion_IP = 178.154.231.167
someinternalhost_IP = 10.128.0.8
```

WEB-интерфейс pritunl (с SSL от LE):
https://178.154.231.167.sslip.io

Для подключения в одну команду и используя алиасы добавляем в ~/.ssh/config:
```Host bastion
  HostName 178.154.231.167
  Port 22
  User appuser
  IdentityFile ~/.ssh/appuser

Host someinternalhost
  HostName 10.128.0.8
  ProxyJump bastion
  Port 22
  User appuser
  IdentityFile ~/.ssh/appuser
```
После чего можно использовать `ssh someinternalhost`.

## домашнее задание N4 (cloud-testapp)

Данные для подключения:
```
testapp_IP = 10.128.0.15
testapp_port = 9292
```

Для создания инстанса с автоматическим деплоем приложения был написан bootstrap-скрипт:
```
sh startup.sh
```
(создается инстанс, через user-data передается sh-скрипт (bootstrap.sh), который выполняется через cloud-init при первом запуске VM)
