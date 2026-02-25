#!/bin/bash

# Task 6
# Write a script that renames all .txt files in the current directory to .bak. Print what you renamed.

for file in *.txt; do
  mv "$file" "${file%.txt}.bak"
  echo "Renamed $file to ${file%.txt}.bak"
done