#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
docker build --pull \
    --build-arg HOST_UID="$(id -u)" \
    --build-arg HOST_GID="$(id -g)" \
    -t pi-sandbox:latest \
    -f Dockerfile.pi .

docker image prune -f