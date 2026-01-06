#!/bin/bash
# Test script to verify Rancher API token
# 
# SECURITY: Never commit tokens to git! Use environment variables.
# Usage: RANCHER_URL=https://your-server RANCHER_TOKEN=your-token ./test_token.sh

TOKEN="${RANCHER_TOKEN:-}"

if [ -z "$TOKEN" ]; then
  echo "Error: RANCHER_TOKEN environment variable is required"
  echo "Usage: RANCHER_URL=https://your-server RANCHER_TOKEN=your-token ./test_token.sh"
  exit 1
fi

# You'll need to set your Rancher URL
RANCHER_URL="${RANCHER_URL:-https://your-rancher-server}"

echo "Testing Rancher API token..."
echo "URL: $RANCHER_URL"
echo "Token: ${TOKEN:0:20}..."

# Test the token by making a request to the users endpoint
response=$(curl -s -w "\n%{http_code}" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  "$RANCHER_URL/apis/management.cattle.io/v3/users")

http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')

if [ "$http_code" = "200" ]; then
  echo "✓ Token is valid!"
  echo "Response preview:"
  echo "$body" | head -c 200
  echo "..."
else
  echo "✗ Token verification failed (HTTP $http_code)"
  echo "Response:"
  echo "$body"
  exit 1
fi
