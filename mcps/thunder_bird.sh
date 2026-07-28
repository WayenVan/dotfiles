#!/bin/bash

uvx \
  --with 'mcp>=1.17,<2' \
  --refresh \
  mcpo \
  --host=0.0.0.0 \
  --port=7805 \
  --api-key="thunder-bird-wayenvan" \
  -- \
  node "$THUNDER_BIRD_MCP_REPO/mcp-bridge.cjs"
