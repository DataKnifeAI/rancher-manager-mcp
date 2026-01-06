# Contributing to Rancher Manager MCP

Thank you for your interest in contributing to the Rancher Manager MCP server! This document provides guidelines and instructions for contributing.

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- A clear, descriptive title
- Steps to reproduce the bug
- Expected vs. actual behavior
- Environment details (OS, Go version, Rancher version)
- Relevant logs or error messages

### Suggesting Features

Feature suggestions are welcome! Please open an issue with:
- A clear description of the feature
- Use case and motivation
- Proposed implementation approach (if you have one)

### Pull Requests

1. **Fork the repository** and create a feature branch
2. **Make your changes** following the coding standards below
3. **Add tests** if applicable
4. **Update documentation** for any new features or changes
5. **Ensure all tests pass** and code is properly formatted
6. **Submit a pull request** with a clear description

## Development Setup

### Prerequisites

- Go 1.23 or later
- Access to a Rancher Manager instance (for testing)
- Git

### Getting Started

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/rancher-manager-mcp.git
cd rancher-manager-mcp

# Create a branch for your changes
git checkout -b feature/your-feature-name

# Set up environment
cp .env.example .env
# Edit .env with your test credentials

# Build
go build -o bin/rancher-mcp ./cmd

# Run tests
go test ./...
```

## Coding Standards

### Go Code Style

- Follow standard Go formatting (`go fmt`)
- Use `gofmt` and `go vet` before committing
- Keep functions focused and small
- Add comments for exported functions and types
- Use meaningful variable and function names

### Code Organization

- Keep MCP protocol code in `internal/mcp/`
- Keep Rancher API client code in `internal/server/`
- Add new tools in `internal/server/server.go` `registerTools()` method
- Follow existing patterns for consistency

### Error Handling

- Always handle errors explicitly
- Return descriptive error messages
- Use `fmt.Errorf` with `%w` for error wrapping
- Log errors appropriately using logrus

### Testing

- Add unit tests for new functionality
- Test error cases as well as success cases
- Use table-driven tests where appropriate
- Run `go test -v ./...` before submitting

## Adding New Tools

To add a new MCP tool:

1. **Add the Rancher API method** in `internal/server/rancher_client.go`:
```go
func (c *RancherClient) YourNewMethod(ctx context.Context, params...) (interface{}, error) {
    // Implementation
}
```

2. **Add the tool handler** in `internal/server/server.go`:
```go
func (s *Server) yourNewTool(ctx context.Context, args map[string]interface{}) (interface{}, error) {
    // Extract parameters from args
    // Call Rancher client method
    // Return result
}
```

3. **Register the tool** in `registerTools()`:
```go
s.mcpServer.RegisterTool("your_new_tool", "Description of what it does", s.yourNewTool)
```

4. **Update documentation**:
   - Add to `docs/TOOLS_REFERENCE.md`
   - Update `docs/QUICK_REFERENCE.md` tool table
   - Update README.md if needed

5. **Test the tool**:
   - Test with real Rancher instance
   - Test error cases
   - Verify MCP protocol compliance

## Commit Messages

Use clear, descriptive commit messages:

```
Add list_namespaces tool for cluster namespace management

- Implement Rancher API client method
- Add MCP tool handler
- Update documentation
- Add tests
```

## Documentation

- Update README.md for user-facing changes
- Update relevant docs/ files for tool additions
- Keep examples up to date
- Add comments to complex code sections

## Security

- **Never commit** tokens, passwords, or secrets
- Use environment variables for sensitive data
- Review security implications of new features
- Follow secure coding practices

## Questions?

If you have questions about contributing:
- Open an issue with the `question` label
- Check existing issues and discussions
- Review the documentation in `docs/`

Thank you for contributing! 🎉
