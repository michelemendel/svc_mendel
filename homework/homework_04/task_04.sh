#!/bin/bash

# Task 4
# Write a script that has a list of 3 names.
# For each name, print "Creating user: NAME".

names=("John" "Jane" "Jim")

for name in "${names[@]}"; do
  echo "Creating user: $name"
done