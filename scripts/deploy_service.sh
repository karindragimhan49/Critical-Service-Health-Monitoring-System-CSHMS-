#!/bin/bash
# Script to deploy the Critical application and handle graceful shutdown
echo "Starting the Critical application" #run the application here
#run he python app in the background and save its PID
nohup python3 ../app_service/app.py > /dev/null 2>&1 & #redirect output to null
APP_PID=$! #get the PID of the last background process
echo "Application Started with PID  $APP_PID"
# Function to handle termination signals