#!/bin/sh
set -eu

# Copy sandbox-managed files into Pi's agent directory on every startup.
agent_home=/run/pi-sandbox/agent-home
agent_dir=${PI_CODING_AGENT_DIR:-"$HOME/.pi/agent"}

if [ -d "$agent_home" ]; then
  mkdir -p "$agent_dir"
  cp -Rf "$agent_home"/. "$agent_dir"/
fi

exec mise exec -- "$@"
