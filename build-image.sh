#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
# shellcheck source=container-cli.sh
source ./container-cli.sh

select_container_cli
ensure_container_vm

# `finch build` (nerdctl) has no --pull flag, so refresh the base image explicitly.
if [[ $CONTAINER_CLI == docker ]]; then
  pull_args=(--pull)
else
  "$CONTAINER_CLI" pull debian:bookworm-slim
  pull_args=()
fi

# Host UID/GID only matter on Linux, where bind mounts keep host ownership.
# On macOS the VM maps file ownership itself, so use the Dockerfile defaults (1000:1000).
uid_args=()
if [[ "$(uname -s)" == Linux ]]; then
  uid_args=(--build-arg HOST_UID="$(id -u)" --build-arg HOST_GID="$(id -g)")
fi

"$CONTAINER_CLI" build ${pull_args[@]+"${pull_args[@]}"} \
    ${uid_args[@]+"${uid_args[@]}"} \
    -t pi-sandbox:latest \
    -f Dockerfile.pi .

"$CONTAINER_CLI" image prune -f