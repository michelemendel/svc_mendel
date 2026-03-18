#!/bin/bash

# Task 9
# Write a script that checks disk usage of /.
# If it's above 80%, print "WARNING: disk almost full". Otherwise print "Disk OK".

function check_disk_usage() {
  echo $(df -Ph / | tail -1 | awk '{print $5}' | tr -d '%')
}

function display_status() {
  echo "Disk usage: $1%"

  if [ $1 -gt 80 ]; then
    echo "WARNING: disk almost full"
  else
    echo "Disk OK"
  fi
}

display_status $(check_disk_usage)
