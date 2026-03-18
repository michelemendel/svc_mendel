#!/bin/bash

read -p "Enter your age: " age

if [[ "$age" -gt "18" ]]; then
  echo "You can enter"
else
  echo "Thou shalt not pass!"
fi