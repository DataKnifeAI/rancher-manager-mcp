# Security Guidelines

## ⚠️ Important Security Notice

**If you committed a token to this repository, you must:**

1. **Revoke the exposed token immediately** in your Rancher instance
2. **Generate a new token** for use going forward
3. **Consider the token compromised** - anyone with access to the git history can see it

## Best Practices

### Never Commit Tokens

- ❌ **DON'T**: Commit tokens directly in code or documentation
- ✅ **DO**: Use environment variables
- ✅ **DO**: Use secret management systems (HashiCorp Vault, AWS Secrets Manager, etc.)
- ✅ **DO**: Use `.env` files (and add them to `.gitignore`)

### Using Environment Variables

```bash
# Set environment variables
export RANCHER_URL=https://your-rancher-server
export RANCHER_TOKEN=your-token-here

# Use in scripts
./test_token.sh

# Or pass to commands
./rancher-mcp --rancher-url $RANCHER_URL --rancher-token $RANCHER_TOKEN
```

### Using .env Files (Local Development)

Create a `.env` file (already in `.gitignore`):

```bash
RANCHER_URL=https://your-rancher-server
RANCHER_TOKEN=your-token-here
```

Then source it:

```bash
source .env
./test_token.sh
```

### Token Format

Rancher tokens follow the format: `token-XXXXX:YYYYY`

- The token ID (before the colon) identifies the token
- The secret (after the colon) must be kept secure

### Rotating Compromised Tokens

If a token was exposed:

1. Log into Rancher Manager
2. Go to Users & Authentication → API Keys
3. Find the exposed token and delete it
4. Create a new token
5. Update all systems using the old token

## Reporting Security Issues

If you discover a security vulnerability, please report it responsibly rather than opening a public issue.
