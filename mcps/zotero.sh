#!/bin/bash

uvx \
  --with 'mcp>=1.17,<2' \
  --refresh \
  mcpo \
  --host=0.0.0.0 \
  --port=7800 \
  --api-key="zotero-wayenvan" \
  -- \
  zotero-mcp
