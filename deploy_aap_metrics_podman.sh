#!/bin/bash

# Create networks if they don't already exist
echo "Creating Podman networks..."
podman network create aap
podman network create service-mesh

# Create volumes directories and set permissions
echo "Setting up directories for volumes..."
mkdir -p ./prometheus_config ./prometheus_storage ./grafana_config ./grafana_storage
chmod -R 775 ./prometheus_storage ./grafana_storage
chown -R 65534:65534 ./prometheus_storage
chmod -R 775 ./prometheus_storage
chown -R 472:472 ./grafana_storage
chmod -R 755 ./grafana_storage

# Deploy Prometheus
echo "Deploying Prometheus..."
podman run -d \
  --name tools_prometheus_1 \
  --hostname prometheus \
  --restart always \
  --network aap \
  -p 9090:9090 \
  -v "$(pwd)/prometheus_config/prometheus.yml:/etc/prometheus/prometheus.yml:Z" \
  -v "$(pwd)/prometheus_storage:/prometheus:Z" \
  prom/prometheus:latest

# Deploy Grafana
echo "Deploying Grafana..."
podman run -d \
  --name tools_grafana_1 \
  --hostname grafana \
  --restart always \
  --network aap \
  -p 3001:3000 \
  -v "$(pwd)/grafana_config:/etc/grafana/provisioning:Z" \
  -v "$(pwd)/grafana_storage:/var/lib/grafana:Z" \
  grafana/grafana-enterprise:latest

# Check deployments
echo "Checking deployments..."
podman ps

# Reset Grafana admin
echo "Reset Grafana admin"
podman exec -it tools_grafana_1 grafana cli admin reset-admin-password admin


