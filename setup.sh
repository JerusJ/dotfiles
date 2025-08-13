#!/usr/bin/env bash

set -euo pipefail

if ! command -v mise &>/dev/null; then
  echo "--> Installing mise CLI..."
  curl -sSL https://mise.run | sh
fi

mise trust -y
mise install -g -y
