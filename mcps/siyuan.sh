#!/bin/bash

# uvx mcpo \
#   --host=0.0.0.0 \
#   --port=7801 \
#   --api-key="siyuan-wayenvan" \
#   -- \
#   npx -y @porkll/siyuan-mcp stdio \
#   --token "$SIYUAN_TOKEN" \
#   --baseUrl "http://127.0.0.1:6806"

# uvx mcpo \
#   --port 7801 \
#   --server-type streamable-http \
#   --header "{\"Authorization\":\"Bearer $SIYUAN_MCP_TOKEN\"}" \
#   -- http://127.0.0.1:36806/mcp

SIYUAN_API_URL=http://127.0.0.1:6806 \
  uvx mcpo \
  --host=0.0.0.0 \
  --port=7801 \
  --api-key="siyuan-wayenvan" \
  -- \
  node "$SIYUAN_WORKSPACE/data/plugins/siyuan-plugins-mcp-sisyphus/mcp-server.cjs"
