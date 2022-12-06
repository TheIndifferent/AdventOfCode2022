#!/usr/bin/env bash

readonly INPUT_FILE='day6-input.txt'

input="$( cat "$INPUT_FILE" )"
index=0

while [[ $(( $index + 14 )) -lt ${#input} ]]
do
  section="${input:$index:14}"
  if [[ ${#section} -eq $( echo $section | fold -w 1 | sort | uniq | wc -l ) ]]
  then
    echo "$(( $index + 14 ))"
    exit 0
  fi
  index=$(( $index + 1 ))
done
