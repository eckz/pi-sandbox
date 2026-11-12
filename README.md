# pi-sandbox

A sandboxed environment for running [pi](https://pi.dev/), a coding agent harness, inside Docker.

## Contents

- `Dockerfile.pi` — Docker image definition for the pi sandbox
- `pi` — launcher script for the sandbox
- `build-image.sh` — helper script to rebuild the image
- `container-cli.sh` — shared finch/docker detection and startup helpers
- `entrypoint.sh` — container entrypoint; copies `agent-home/` into `~/.pi/agent`
- `agent-home/` — files copied into the Pi agent directory on every startup
- `global.gitignore` — global gitignore installed for every repository in the sandbox
- `sandbox-command` — command wrapper for the sandbox

## Getting started

Build the image:

```bash
./build-image.sh
```

Then run the sandbox using the `pi` launcher script.

## Agent skills

The image installs these [Agent Skills](https://agentskills.io) during the
build into `~/.agents/skills`, where Pi discovers user-level skills:

| Skill | Source |
|---|---|
| `resolve-merge-conflicts` | [warpdotdev/common-skills](https://github.com/warpdotdev/common-skills) |
| `tdd` | [mattpocock/skills](https://github.com/mattpocock/skills) |

They are installed with the `skills` CLI from the `Dockerfile.pi`; add another
`skills add` line there and rebuild the image to install more. The upstream
`resolve-merge-conflicts` instructions use repo-relative `.agents/skills/...`
paths, so the build rewrites those to the global `~/.agents/skills/...` copy.

## Global gitignore

The image installs `global.gitignore` as `~/.config/git/ignore` and sets
`core.excludesFile` to it, so common macOS, Windows, Linux, editor, and
temporary files are ignored in every repository inside the sandbox. Project
`.gitignore` files still take precedence and can re-include specific paths.

## License

This project is licensed under the [MIT License](LICENSE).
