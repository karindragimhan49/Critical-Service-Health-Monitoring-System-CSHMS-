#!/bin/bash

# Use curl to check the /health endpoint
RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health) # 

if [ "$RESPONSE_CODE" -eq 200 ]; then
  # If response code is 200 (OK), service is healthy
  echo "Health check PASSED with status code $RESPONSE_CODE."
  exit 0
else
  # Any other code means there is a problem
  echo "Health check FAILED with status code $RESPONSE_CODE."
  exit 1
fi