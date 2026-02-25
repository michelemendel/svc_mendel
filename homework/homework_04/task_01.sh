#!/bin/bash

# Task 1
# Write a script that takes a filename as an argument. If the file exists, print "File found". If not, print "File not found".

read -p "Enter a filename: " filename

if [ -f "$filename" ]; then
  echo "File found"
else
  echo "File not found"
fi