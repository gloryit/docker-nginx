#!/bin/bash

# Start the redis
/usr/sbin/redis -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start redis: $status"
  exit $status
fi

# Start the php-fpm
/usr/sbin/php-fpm -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start php-fpm: $status"
  exit $status
fi

# Start the second httpd
/usr/sbin/httpd -D FOREGROUND
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start httpd: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container will exit with an error
# if it detects that either of the processes has exited.
# Otherwise it will loop forever, waking up every 60 seconds

# while /bin/true; do
#   ps aux | grep php-fpm | grep -v grep
#   PROCESS_1_STATUS=$?
#   ps aux | grep httpd | grep -v grep
#   PROCESS_2_STATUS=$?
#   # If the greps above find anything, they will exit with 0 status
#   # If they are not both 0, then something is wrong
#   if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
#     echo "One of the processes has already exited."
#     exit -1
#   fi
#   sleep 60
# done