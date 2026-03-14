# lighthouse-role

Роль устанавливает LightHouse и настраивает nginx для публикации веб-интерфейса.

## Требования

- Ansible 2.14+
- Debian/Ubuntu

## Переменные по умолчанию

```yaml
lighthouse_root_dir: /var/www/lighthouse
lighthouse_repo: https://github.com/VKCOM/lighthouse.git
lighthouse_version: master
lighthouse_listen_port: 80
lighthouse_server_name: _
```

## Пример использования

```yaml
- hosts: lighthouse
  become: true
  roles:
    - role: lighthouse-role
```

## Что делает роль

- устанавливает `git` и `nginx`;
- скачивает LightHouse из GitHub;
- создаёт nginx-конфиг из шаблона;
- активирует сайт и отключает дефолтный nginx site;
- запускает nginx.
