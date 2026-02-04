#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
if [ ! -f .env ]; then
  echo ".env not found. Copy .env.example -> .env and fill values."
  echo "  cp .env.example .env"
  exit 1
fi
# load .env
set -a; source .env; set +a
missing=0
for v in SEPOLIA_RPC_URL PRIVATE_KEY ETHERSCAN_API_KEY; do
  if [ -z "${!v:-}" ]; then
    echo "Missing $v"
    missing=1
  fi
done
if [ "$missing" -eq 1 ]; then
  echo "Fill the missing variables in .env"
  exit 1
fi
echo "All required env vars present."
