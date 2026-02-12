# secrets-sync

Container to sync and decrypt SOPS-encrypted secrets from Git to local filesystem.

## Usage

```yaml
services:
  secrets-sync:
    image: ghcr.io/melvyndekort/secrets-sync:latest
    restart: "no"
    volumes:
      - /path/to/secrets:/secrets:rw
      - /path/to/age-key.txt:/age-key.txt:ro
      - /path/to/ssh-key:/ssh-key:ro
    environment:
      REPO_URL: git@github.com:user/repo.git
      BRANCH: main
      NODE: compute-1
```

## Environment Variables

- `REPO_URL`: Git repository URL (required)
- `NODE`: Node name to filter secrets files (required)
- `BRANCH`: Git branch (default: main)

## Volumes

- `/secrets`: Output directory for decrypted secrets
- `/age-key.txt`: Age private key for SOPS decryption
- `/ssh-key`: SSH private key for Git authentication (optional)
