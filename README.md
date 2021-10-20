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
testapp_IP = 130.193.49.28
testapp_port = 9292
```

Для создания инстанса с автоматическим деплоем приложения был написан bootstrap-скрипт:
```
sh startup.sh
```
(создается инстанс, через user-data передается sh-скрипт (bootstrap.sh), который выполняется через cloud-init при первом запуске VM)

## домашнее задание N5 (reddit-base)

Было сделано:
Создан сервисный аккаунт
Создан конфиг packer - ubuntu16.json
Создан образ reddit-base
Создана VM из образа reddit-base
Параметризирован конфиг packer
Создан конфиг packer - immutable.json
Создан скрипт (create-reddit-vm.sh) для создания VM из образа reddit-full

Для проверки:
Запустить packer build -var-file=variables.json ubuntu16.json
Запустить packer build -var-file=variables.json immutable.json
Запустить sh create-reddit-vm.sh

## домашнее задание N6 (terraform-1)

Было сделано:
Выполнено основное задание.
Выполнены дополнительные задания:
- создана переменная с путем до приватного ключа
- создана переменная с зоной для ресурса "app"
- отформатированы *.tf файлы
- создан файл terraform.tfvars.example
Выполнено задание со **:
- добавлена переменная для указания кол-ва создаваемых инстансов (используя count)
- создана target group балансировщика и сам балансировщик (lb.tf)
- в output переменные добавлен вывод IP адреса балансировщика

## домашнее задание N7 (terraform-2)

Было сделано:
Выполнено основное задание.
(дополнительно параметризированы параметры ресурсов VM: cores, memory, core_fraction)
Выполнено задание со *:
- конфигурация бэкенда в backend.tf
- проверена работа без локальных файлов tfstate и блокировок
Задание с * *:
- добавлены provisioners в модуль app для деплоя приложения

## домашнее задание N8 (ansible-1)
Было сделано:
Выполнено основное задание.
Выполнено задание со *
Написан скрипт для генерации динамического inventory (yc-inventory.py)
(используется yandex python sdk)
Пример работы скрипта в inventory.json

## домашнее задание N9 (ansible-2)
Было сделано:
Выполнено основное задание.
Выполнено задание со *: в рамках ДЗ N8 (ansible-1) уже был написан скрипт для динамического инвентаря YandexCloud.
