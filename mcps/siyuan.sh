#!/bin/bash

uvx mcpo \
  --host=0.0.0.0 \
  --port=7801 \
  --api-key="siyuan-wayenvan" \
  -- \
  npx -y @porkll/siyuan-mcp stdio \
  --token "$SIYUAN_TOKEN" \
  --baseUrl "http://127.0.0.1:6806"
