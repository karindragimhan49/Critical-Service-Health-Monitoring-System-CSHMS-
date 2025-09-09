#!/bin/bash

LOG_FILE="../logs/system_logs.log"

echo "--- Starting Monitoring Loop ---" | tee -a $LOG_FILE

while true; do
  # Run the health check script
  ./health_check.sh
  
  # Check the exit code of the health_check.sh script
  if [ $? -ne 0 ]; then
    # Health check failed
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] CRITICAL: Application is down! Attempting to restart..." | tee -a $LOG_FILE
    
    # Kill the old process if it exists
    if [ -f ../app.pid ]; then
        kill $(cat ../app.pid)
        rm ../app.pid
    fi
    
    # Restart the application
    ./deploy_service.sh | tee -a $LOG_FILE
    
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] INFO: Application restart command issued." | tee -a $LOG_FILE

    # --- මෙන්න අලුත් කොටස ---
    # Give the application a few seconds to start up before checking again
    echo "Waiting for application to initialize..."
    sleep 5 
    # -------------------------

  else
    # Health check passed
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] INFO: Application is running healthy."
  fi
  
  # Wait for 10 seconds before checking again
  echo "Waiting for 10 seconds..."
  sleep 10
done