#!/bin/bash

APP_DIR="../app_service"
LOG_FILE="../logs/app.log"
PID_FILE="../app.pid"

echo "Starting the critical application..."

# Start the application. 
# We explicitly call python3 and give the full path to the script for robustness.
# The '&' sends it to the background.
python3 "$APP_DIR/app.py" > "$LOG_FILE" 2>&1 &

# Get the PID of the last background process
APP_PID=$!

# Check if the process actually started by checking if the PID exists
if ps -p $APP_PID > /dev/null; then
    echo "Application started successfully with PID: $APP_PID."
    echo $APP_PID > "$PID_FILE"
else
    echo "Application FAILED to start. Check logs at $LOG_FILE"
    exit 1
fi