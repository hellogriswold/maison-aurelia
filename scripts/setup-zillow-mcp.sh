#!/usr/bin/env bash
#
# Sets up the Zillow MCP server (https://github.com/sap156/zillow-mcp-server)
# for use with the project-scoped .mcp.json configuration.
#
# It clones the upstream server into mcp/zillow-mcp-server (gitignored),
# creates an isolated virtualenv, and installs its dependencies. The
# resulting interpreter path matches the "command" in .mcp.json.
#
# Usage:
#   ./scripts/setup-zillow-mcp.sh
#
# Requirements: git, python3 (3.8+). Network access to github.com.
set -euo pipefail

REPO_URL="https://github.com/sap156/zillow-mcp-server.git"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST_DIR="$ROOT_DIR/mcp/zillow-mcp-server"
VENV_DIR="$DEST_DIR/.venv"

echo "==> Setting up Zillow MCP server in $DEST_DIR"

if [ -d "$DEST_DIR/.git" ]; then
  echo "==> Repo already present; pulling latest"
  git -C "$DEST_DIR" pull --ff-only
else
  mkdir -p "$ROOT_DIR/mcp"
  echo "==> Cloning $REPO_URL"
  git clone --depth 1 "$REPO_URL" "$DEST_DIR"
fi

echo "==> Creating virtualenv"
python3 -m venv "$VENV_DIR"

echo "==> Installing dependencies"
"$VENV_DIR/bin/pip" install --upgrade pip >/dev/null
"$VENV_DIR/bin/pip" install -r "$DEST_DIR/requirements.txt"

echo
echo "==> Done."
echo "    Set your Zillow Bridge API key before starting Claude Code, e.g.:"
echo "      export ZILLOW_API_KEY=your_key_here"
echo
echo "    The server is wired up in .mcp.json and will be available as the"
echo "    'zillow' MCP server. Verify with: claude mcp list"
