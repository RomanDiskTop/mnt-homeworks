# vector-role

Роль устанавливает и настраивает Vector на Debian/Ubuntu-хостах.

## Требования

- Ansible 2.14+
- Debian/Ubuntu

## Переменные по умолчанию

```yaml
vector_package_state: present
vector_config_dir: /etc/vector
vector_config_file: /etc/vector/vector.yaml
vector_service_enabled: true
vector_service_state: started
```

## Пример конфигурации

```yaml
vector_sources:
  demo_logs:
    type: file
    include:
      - /var/log/*.log
    read_from: beginning

vector_sinks:
  console:
    type: console
    inputs:
      - demo_logs
    encoding:
      codec: json
```

## Пример использования

```yaml
- hosts: vector
  become: true
  roles:
    - role: vector-role
```

## Что делает роль

- устанавливает зависимости для APT-репозитория Vector;
- подключает официальный репозиторий Vector;
- устанавливает пакет `vector`;
- выкладывает конфигурацию из шаблона;
- запускает и включает сервис `vector`.
