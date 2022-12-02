#!/bin/bash

max=0
current=0

while read -r line
do
  if [[ -n $line ]]
  then
    current=$(( current + line))
  else
    if [[ $current -gt $max ]]
    then
      max=$current
    fi
    current=0
  fi
done <'day1-input.txt'

echo "$max"
