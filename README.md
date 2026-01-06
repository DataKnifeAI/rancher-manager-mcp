# Rancher Manager MCP Server

MCP server for Rancher Manager API with stdio and HTTP transport support.

## Setup

```bash
# Copy example env file
cp .env.example .env
# Edit .env with your Rancher URL and token

# Build
go build -o rancher-mcp ./cmd
```

## Usage

The server reads credentials from environment variables or command-line flags:

```bash
# Using environment variables (recommended)
export RANCHER_URL=https://your-rancher-server
export RANCHER_TOKEN=your-token
./rancher-mcp

# Or via command-line flags
./rancher-mcp --rancher-url https://your-rancher-server --rancher-token your-token

# HTTP transport
./rancher-mcp --transport http --http-addr :8080
```

## Available Tools

- `list_clusters` - List all Rancher clusters
- `get_cluster` - Get cluster details (requires `name`)
- `list_users` - List all Rancher users
- `get_user` - Get user details (requires `name`)
- `list_projects` - List all Rancher projects
- `get_project` - Get project details (requires `name`, optional `namespace`)

## API Reference

Uses Rancher Manager Kubernetes API: `/apis/management.cattle.io/v3/`
See: https://ranchermanager.docs.rancher.com/api/api-reference
