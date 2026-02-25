#!/bin/bash

# Task 7
# Write a script that shows this menu and keeps running until the user picks 3:

RES=""

say_hello() {
  RES="Hello"
}

show_date() {
  RES="Date: $(date)"
}

exit_program() {
  echo "Bye"
  exit 0
}

show_result() {
  if [  -n "$RES" ]; then
    echo -e "$RES"
  fi
}

while true; do
  clear

  echo "Select an option:"
  echo "1. Say Hello"
  echo "2. Show Date"
  echo "3. Exit"
  echo "-----------------"

  show_result
  read choice

  case $choice in
    1) say_hello ;;
    2) show_date ;;
    3) exit_program ;;
    *) RES="Invalid choice";;
  esac

done