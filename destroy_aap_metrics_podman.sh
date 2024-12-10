#!/bin/bash

# Destroy networks
echo "Destroying Podman networks..."
podman network delete aap
podman network delete service-mesh

# Destroy tools_prometheus_1 and tools_grafana_1
podman rm tools_prometheus_1 -f
podman rm tools_grafana_1 -f

