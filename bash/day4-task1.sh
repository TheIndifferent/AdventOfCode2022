#!/usr/bin/env bash

function all_sections_for_range() {
  seq -s ' ' "${1%%-*}" "${1#*-}"
}

function fully_contains_other() {
  echo "${1%% }" | grep -w -o -q "${2%% }"
}

count=0
while read -r line
do
  first="$( all_sections_for_range "${line%%,*}" )"
  second="$( all_sections_for_range "${line#*,}" )"
  if fully_contains_other "$first" "$second" || fully_contains_other "$second" "$first"
  then
    count=$(( count + 1 ))
  fi
done <'day4-input.txt'

echo "$count"
