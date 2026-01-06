# Token Verification

**⚠️ SECURITY WARNING**: Never commit API tokens to git repositories! Always use environment variables or secure secret management.

To verify the Rancher API token, you can use either the Go tool or the shell script.

## Using the Go Tool

```bash
go run ./cmd/verify-token/main.go \
  --rancher-url https://your-rancher-server \
  --rancher-token YOUR_TOKEN_HERE
```

Or build it first:

```bash
go build -o bin/verify-token ./cmd/verify-token
./bin/verify-token \
  --rancher-url https://your-rancher-server \
  --rancher-token YOUR_TOKEN_HERE
```

## Using the Shell Script

```bash
export RANCHER_URL=https://your-rancher-server
export RANCHER_TOKEN=your-token-here
./test_token.sh
```

## Token Details

- **Format**: Bearer token for Rancher Manager API (format: `token-XXXXX:YYYYY`)
- **API Endpoint**: `/apis/management.cattle.io/v3/*`
- **Security**: Store tokens in environment variables or use a secrets manager

The token is verified by making a request to the `/apis/management.cattle.io/v3/users` endpoint. A successful response (HTTP 200) indicates the token is valid.
