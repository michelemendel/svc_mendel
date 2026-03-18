#!/bin/bash

# Task 5
# Write a script that asks for a test score (0-100).
#
# 90-100: "A"
# 80-89: "B"
# 70-79: "C"
# Below 70: "F"


read -p "Enter your test score: " score

if [[ "$score" -lt "0" || "$score" -gt "100" || ! "$score" =~ ^[0-9]+$ ]]; then
  echo "$score is not a valid score."
elif [[ "$score" -ge "90" ]]; then
  echo "A"
elif [[ "$score" -ge "80" ]]; then
  echo "B"
elif [[ "$score" -ge "70" ]]; then
  echo "C"
else
  echo "F"
fi