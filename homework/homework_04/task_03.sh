#!/bin/bash

# Task 3
# Write a script that picks a secret number (set it to 7).
#Ask the user to guess.
# If wrong, print "Wrong, try again". If correct, print "You got it!" and stop.

secret=7

echo "Guess the number!"

while read nr; do
  if  [[ "$nr" -eq "$secret" ]]; then
  echo "You got it!"
  exit 1
else
  echo "Wrong, guess again!"
fi
done