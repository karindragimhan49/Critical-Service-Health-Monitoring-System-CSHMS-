#!/bin/bash
echo "Starting the Critical application"
#run he python app in the background and save its PID
nohup python3 ../app_service/app.py > /dev/null 2>&1 &
APP_PID=$!
echo "Application Started with PID  $APP_PID"