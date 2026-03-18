#!/bin/bash

secret=7

echo "Guess the number!"

while read nr; do
  if  [[ "$nr" -eq "$secret" ]]; then
  echo "GOOD GUESS!"
  exit 1
else
  echo "Nope, guess again!"
fi
done