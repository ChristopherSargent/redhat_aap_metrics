#!/bin/bash
# Christopher Sargent 12102024
set -x #echo on

# Create directories and set permissions for grafana
mkdir -p ./grafana_storage
chown -R 472:472 ./grafana_storage
chmod -R 755 ./grafana_storage

# Create directories and set permissions for prometheus
mkdir -p ./prometheus_storage
chown -R 65534:65534 ./prometheus_storage
chmod -R 775 ./prometheus_storage

# Bring up containers
docker compose up -d

