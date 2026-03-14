# Домашнее задание к занятию 4 «Работа с roles»

## Задание

Нужно было вынести установку и настройку ClickHouse, Vector и LightHouse из playbook в отдельные роли, подключить внешнюю роль ClickHouse через `requirements.yml`, оформить README для ролей и итогового playbook, а также подготовить репозитории с ролями и playbook.

## Ответ

Подготовлены:

- роль `vector-role`;
- роль `lighthouse-role`;
- playbook-репозиторий `08-ansible-04-role`;
- файл `requirements.yml` с внешней ролью `clickhouse` и двумя собственными ролями.

### Ссылки на репозитории

- [vector-role](https://github.com/RomanDiskTop/vector-role)
- [lighthouse-role](https://github.com/RomanDiskTop/lighthouse-role)
- [08-ansible-04-role](https://github.com/RomanDiskTop/08-ansible-04-role)
