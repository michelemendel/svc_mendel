#!/bin/bash

# Task 10
# Create a file called servers.txt with 3 server names (one per line).
# Write a script that reads each line and prints "Checking server: NAME".

#  Hint: while read line; do ... done < servers.txt

# Creating the server.txt file
# Cleanup if exists
if [ -f "servers.txt" ]; then
  rm "servers.txt"
fi
touch "servers.txt"

# Adding three servers to server.txt
for i in {1..3}; do
  echo "server_$i" >> "servers.txt"
done

# Checking servers
while read line; do
  echo "Checking server: $line"
done < "servers.txt"
