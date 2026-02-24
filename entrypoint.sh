#!/bin/sh
set -e

echo "=== Secrets Sync Started ==="

# Validate required environment variables
if [ -z "$REPO_URL" ]; then
    echo "Error: REPO_URL not set" >&2
    exit 1
fi

BRANCH="${BRANCH:-main}"

# Validate age key exists
if [ ! -f /age-key.txt ]; then
    echo "Error: Age key not found at /age-key.txt" >&2
    exit 1
fi

# Setup SSH for git
if [ -f /ssh-key ]; then
    mkdir -p ~/.ssh
    cp /ssh-key ~/.ssh/id_ed25519
    chmod 600 ~/.ssh/id_ed25519
    ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null
fi

# Clone repository
echo "Cloning repository..."
cd /tmp
rm -rf repo
git clone --depth 1 --branch "$BRANCH" "$REPO_URL" repo

# Export age key for SOPS
export SOPS_AGE_KEY=$(cat /age-key.txt)

# Decrypt secrets
echo "Decrypting secrets..."
count=0

for file in repo/secrets/*.enc.env; do
    if [ -f "$file" ]; then
        filename=$(basename "$file" .enc.env)
        echo "  Decrypting ${filename}.env..."
        
        sops -d "$file" > "/secrets/${filename}.env"
        chmod 600 "/secrets/${filename}.env"
        
        count=$((count + 1))
        echo "  ✓ ${filename}.env"
    fi
done

echo "=== Secrets Sync Complete ==="
echo "Decrypted $count secret files"
