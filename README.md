# pi-sandbox

A sandboxed environment for running [pi](https://pi.dev/), a coding agent harness, inside Docker.

## Contents

- `Dockerfile.pi` — Docker image definition for the pi sandbox
- `pi` — launcher script for the sandbox
- `build-image.sh` — helper script to rebuild the image
- `container-cli.sh` — shared finch/docker detection and startup helpers
- `entrypoint.sh` — container entrypoint; copies `agent-home/` into `~/.pi/agent`
- `agent-home/` — files copied into the Pi agent directory on every startup
- `sandbox-command` — command wrapper for the sandbox

## Getting started

Build the image:

```bash
./build-image.sh
```

Then run the sandbox using the `pi` launcher script.

## License

This project is licensed under the [MIT License](LICENSE).
