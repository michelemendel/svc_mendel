#!/bin/bash

read -p "Enter your password: " pw

if [[ "$pw" == "1234" ]]; then
  echo "Password is correct"
else
  echo "Thou shalt not pass!"
fi