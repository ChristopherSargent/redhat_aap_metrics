#!/bin/bash

# Destroy networks
echo "Destroying Podman networks..."
podman network rm aap
podman network rm service-mesh

# Destroy tools_prometheus_1 and tools_grafana_1
podman rm tools_prometheus_1 -f
podman rm tools_grafana_1 -f

