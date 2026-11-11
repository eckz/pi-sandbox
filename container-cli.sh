# Sourced by `pi` and `build-image.sh` (not meant to be executed directly).
#
# Provides:
#   select_container_cli   sets CONTAINER_CLI to finch or docker
#   ensure_container_vm    starts the finch / docker VM when it is not running
#
# Override the choice with CONTAINER_CLI=docker (or finch).
# Kept compatible with bash 3.2, which is what macOS ships.

select_container_cli() {
  if [[ -n ${CONTAINER_CLI:-} ]]; then
    if ! command -v "$CONTAINER_CLI" >/dev/null 2>&1; then
      echo "error: CONTAINER_CLI='$CONTAINER_CLI' not found in PATH" >&2
      return 1
    fi
  elif command -v finch >/dev/null 2>&1; then
    CONTAINER_CLI=finch
  elif command -v docker >/dev/null 2>&1; then
    CONTAINER_CLI=docker
  else
    echo "error: neither finch nor docker was found in PATH" >&2
    return 1
  fi
}

_ensure_finch_vm() {
  # On Linux, finch runs natively and has no VM.
  [[ "$(uname -s)" == Linux ]] && return 0

  local status
  status="$(finch vm status 2>&1 | tr '[:upper:]' '[:lower:]' || true)"

  case $status in
    *running*) return 0 ;;
    *nonexistent*)
      echo "finch VM does not exist, initializing it (first run takes a while)..." >&2
      finch vm init >&2
      ;;
    *)
      echo "finch VM is not running, starting it..." >&2
      finch vm start >&2
      ;;
  esac
}

_ensure_docker_daemon() {
  docker info >/dev/null 2>&1 && return 0

  if command -v colima >/dev/null 2>&1; then
    echo "docker daemon is not reachable, starting colima..." >&2
    colima start >&2
  elif [[ "$(uname -s)" == Darwin && -d /Applications/Docker.app ]]; then
    echo "docker daemon is not reachable, starting Docker Desktop..." >&2
    open -a Docker
    local i
    for i in $(seq 1 60); do
      docker info >/dev/null 2>&1 && return 0
      sleep 2
    done
  else
    echo "error: docker daemon is not reachable and I don't know how to start it here" >&2
    return 1
  fi

  docker info >/dev/null 2>&1 || {
    echo "error: docker daemon is still not reachable" >&2
    return 1
  }
}

ensure_container_vm() {
  case $CONTAINER_CLI in
    finch) _ensure_finch_vm ;;
    docker) _ensure_docker_daemon ;;
    *) ;; # unknown CLI (e.g. podman): assume the user manages it
  esac
}