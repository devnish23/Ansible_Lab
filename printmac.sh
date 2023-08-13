#!/bin/bash

hostname=`uname -n`
printf '%10s %10s %25s %25s\n' hostname interface ipaddress macaddress
printf '%s\n' '----------------------------------------------------------------------------'
for each in $(ip address | grep -oP '(^[\d]+:\s)\K[\d\w]+'); do
  mac=$(ip address show ${each} | grep -oP '(?<=link/ether\s)\K[\da-f:]+|(?<=link/loopback\s)\K[\da-f:]+')
  for address in $(ip address show ${each} | grep -oP '(?<=inet\s)\K[\d.]+|(?<=inet6\s)\K[\da-f:]+'); do
    printf '%10s %10s %25s %25s\n' $hostname ${each} ${address} ${mac}
  done
done
