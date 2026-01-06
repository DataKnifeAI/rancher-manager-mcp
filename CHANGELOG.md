# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-01-06

### Added
- Initial release of Rancher Manager MCP Server
- Support for stdio and HTTP transports
- Cluster management tools:
  - `list_clusters` - List all Rancher clusters
  - `get_cluster` - Get cluster details
- User management tools:
  - `list_users` - List all Rancher users
  - `get_user` - Get user details
- Project management tools:
  - `list_projects` - List all Rancher projects
  - `get_project` - Get project details
- Environment variable configuration support
- SSL verification control (configurable via env or flag)
- Token verification tool
- Comprehensive documentation:
  - README with setup instructions
  - Cursor IDE integration guide
  - Tools reference documentation
  - Quick reference guide
- Test scripts for token and MCP server validation
- Example configuration files

### Security
- Removed hardcoded tokens from repository
- Added `.env` file support for secure credential management
- SSL verification enabled by default

[Unreleased]: https://github.com/surrealwolf/rancher-manager-mcp/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/surrealwolf/rancher-manager-mcp/releases/tag/v1.0.0
