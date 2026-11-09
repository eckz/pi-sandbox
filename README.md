# pi-sandbox

A sandboxed environment for running [pi](https://pi.dev/), a coding agent harness, inside Docker.

## Contents

- `Dockerfile.pi` — Docker image definition for the pi sandbox
- `pi` — launcher script for the sandbox
- `rebuild.sh` — helper script to rebuild the image
- `sandbox-command` — command wrapper for the sandbox

## Getting started

Build the image:

```bash
./rebuild.sh
```

Then run the sandbox using the `pi` launcher script.

## License

This project is licensed under the [MIT License](LICENSE).
