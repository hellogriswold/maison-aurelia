# MCP servers

This directory holds local Model Context Protocol (MCP) servers wired into the
project via the root [`.mcp.json`](../.mcp.json). When you open this repo with
Claude Code, the configured servers are offered automatically.

## Zillow

Source: <https://github.com/sap156/zillow-mcp-server> — a Python/FastMCP server
exposing Zillow Bridge API data (property search, details, etc.).

### One-time setup

The server's source is **not vendored** into this repo; it is fetched on demand
into `mcp/zillow-mcp-server/` (gitignored). Run the setup script:

```bash
./scripts/setup-zillow-mcp.sh
```

This clones the upstream repo, creates a virtualenv at
`mcp/zillow-mcp-server/.venv`, and installs its dependencies. The interpreter
path it produces matches the `command` declared in `.mcp.json`.

### API key

The server needs a Zillow Bridge API key (request one from
`api@bridgeinteractive.com`). Export it before launching Claude Code so the
`${ZILLOW_API_KEY}` placeholder in `.mcp.json` resolves:

```bash
export ZILLOW_API_KEY=your_key_here
```

### Verify

```bash
claude mcp list
```

You should see `zillow` listed. The first time Claude Code loads it, approve the
project-scoped server when prompted.

### Notes

- Paths in `.mcp.json` are relative to the project root; launch Claude Code from
  the repository root so they resolve.
- Windows: the venv interpreter is at `mcp/zillow-mcp-server/.venv/Scripts/python.exe`;
  adjust the `command` in `.mcp.json` accordingly.
