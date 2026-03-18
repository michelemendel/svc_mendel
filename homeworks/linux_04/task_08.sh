#!/bin/bash

# Task 8
# Write a script that pings 3 IPs:
# 8.8.8.8
# 1.1.1.1
# 192.168.1.1.
# For each one print if it responded or not. Use 1 ping only.

ips=("8.8.8.8" "1.1.1.1" "192.168.1.1" "192.0.2.1" "koko")

for ip in ${ips[@]}; do
  ping -c1 -W1 $ip > /dev/null 2>&1

  case $? in
    0) echo "$ip is reachable";;
    1) echo "$ip is not reachable";;
    68) echo "$ip is not a known host";;
    *) echo "$ip is not reachable";;
  esac

done