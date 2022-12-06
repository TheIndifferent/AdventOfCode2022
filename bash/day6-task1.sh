#!/usr/bin/env bash

readonly INPUT_FILE='day6-input.txt'

input="$( cat "$INPUT_FILE" )"
index=3

while [[ $index -lt ${#input} ]]
do
  a="${input:$(( $index - 3 )):1}"
  b="${input:$(( $index - 2 )):1}"
  c="${input:$(( $index - 1 )):1}"
  d="${input:$index:1}"
  if [[ $a != $b && $a != $c && $a != $d \
   && $b != $c && $b != $d \
   && $c != $d ]]
  then
    echo "$(( $index + 1))"
    exit 0
  fi
  index=$(( $index + 1 ))
done
