# secrets-sync

> For global standards, way-of-workings, and pre-commit checklist, see `~/.kiro/steering/behavior.md`

## Role

DevOps engineer.

## What This Does

Alpine-based container that clones a Git repo, decrypts SOPS-encrypted secret files using an age key, and writes them to a mounted volume. Used by homelab to sync secrets from the homelab repo into Portainer stacks.

## Important: Not a Python Project

This is a shell script + Dockerfile, not a Python application. No pyproject.toml, no pytest, no pylint. The only code is `entrypoint.sh`.

## Repository Structure

- `Dockerfile` — Alpine with git, age, openssh-client, and SOPS
- `entrypoint.sh` — Shell script that clones, decrypts, and writes secrets
- `README.md`, `LICENSE`, `SECURITY.md`

## Deployment

- Container image: `ghcr.io/melvyndekort/secrets-sync:latest`
- Runs on homelab Docker via Portainer as an init container

## Related Repositories

- `~/src/melvyndekort/homelab` — Contains the SOPS-encrypted secrets this container decrypts
