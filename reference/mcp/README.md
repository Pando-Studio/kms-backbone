# MCP configuration

**Status:** `spec`

Agents reach external tools through MCP (Model Context Protocol) servers, or through direct APIs wrapped in skills. MCP is the preferred transport when the agent runtime supports it: each tool integration is a declared server, so an operator's tool surface is explicit and inspectable.

## Example configuration

A generic `.mcp.json` declaring two servers — a project-management tool and a cloud-storage tool:

```json
{
  "mcpServers": {
    "pm-tool": {
      "command": "npx",
      "args": ["-y", "@example/pm-mcp-server"],
      "env": {
        "PM_API_KEY": "${PM_API_KEY}",
        "PM_WORKSPACE": "${PM_WORKSPACE}"
      }
    },
    "storage": {
      "command": "npx",
      "args": ["-y", "@example/storage-mcp-server"],
      "env": {
        "STORAGE_CREDENTIALS_FILE": "${STORAGE_CREDENTIALS_FILE}"
      }
    }
  }
}
```

The config file (without secrets) can be committed; the values behind `${...}` placeholders come from each operator's local environment.

## Governance rule

- **Credentials are scoped per operator and never committed.** Each member holds their own API keys locally (env vars, local secret store). The repo contains placeholders only.
- **An agent's tool access follows its operator's scope.** An agent session inherits the credentials of the person running it — nothing more. There is no shared service account granting agents broader reach than their operator; the same principle as read scope in [../../docs/02-governance.md](../../docs/02-governance.md), applied to external tools.
- CI jobs that run connectors use dedicated, minimally-scoped identities, so their syncs are attributable in the same way (see [../../docs/05-connections.md](../../docs/05-connections.md)).
