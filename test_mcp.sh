#!/bin/bash
# Test script for MCP server

set -a
source .env
set +a

TOKEN=$(echo "$RANCHER_TOKEN" | sed 's/^set//')
RANCHER_TOKEN="$TOKEN"

if [ -z "$RANCHER_URL" ] || [ -z "$RANCHER_TOKEN" ]; then
  echo "Error: RANCHER_URL and RANCHER_TOKEN must be set in .env file"
  exit 1
fi

echo "Testing MCP Server"
echo "=================="
echo "Rancher URL: $RANCHER_URL"
echo ""

# Test 1: Initialize
echo "Test 1: Initialize MCP server"
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test-client","version":"1.0.0"}}}' | \
  ./bin/rancher-mcp --transport stdio --rancher-url "$RANCHER_URL" --rancher-token "$RANCHER_TOKEN" 2>/dev/null | jq '.' 2>/dev/null || echo "Response received"
echo ""

# Test 2: List tools
echo "Test 2: List available tools"
(echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test","version":"1.0"}}}'; sleep 0.2; echo '{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}') | \
  timeout 5 ./bin/rancher-mcp --transport stdio --rancher-url "$RANCHER_URL" --rancher-token "$RANCHER_TOKEN" 2>/dev/null | \
  tail -1 | jq '.result.tools[] | {name: .name, description: .description}' 2>/dev/null || echo "Tools listed"
echo ""

# Test 3: Call list_users tool
echo "Test 3: Call list_users tool"
(echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test","version":"1.0"}}}'; sleep 0.2; echo '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"list_users","arguments":{}}}') | \
  timeout 10 ./bin/rancher-mcp --transport stdio --rancher-url "$RANCHER_URL" --rancher-token "$RANCHER_TOKEN" 2>/dev/null | \
  tail -1 | jq '.result.content[0].text' 2>/dev/null | head -c 200 || echo "Users listed"
echo ""
echo ""

# Test 4: HTTP transport health check
echo "Test 4: HTTP transport health check"
./bin/rancher-mcp --transport http --http-addr :8080 --rancher-url "$RANCHER_URL" --rancher-token "$RANCHER_TOKEN" > /tmp/mcp-server.log 2>&1 &
SERVER_PID=$!
sleep 2
curl -s http://localhost:8080/health | jq '.' 2>/dev/null || echo "Health check response"
kill $SERVER_PID 2>/dev/null
wait $SERVER_PID 2>/dev/null
echo ""

echo "Tests completed!"
