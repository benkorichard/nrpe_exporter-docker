# NRPE exporter 

The NRPE exporter exposes metrics on commands sent to a running NRPE daemon.

## Running with docker
```shell
docker run -d -p 9275:9275 --name nrpe_exporter liferay/lfrit-hu:nrpe_exporter
```
You can also use the compose file:

```shell
docker-compose up -d
```

## Prometheus Configuration

Example config, how to add this target:
```yml
global:
  scrape_interval: 10s
scrape_configs:
  - job_name: nrpe
    metrics_path: /export
    params:
      command: [check_load] # Run the check_load command.
    static_configs:
      - targets: # Targets to run the specified command against.
        - '127.0.0.1:5666'
        - 'example.com:5666'
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9275 # Nrpe exporter.

```