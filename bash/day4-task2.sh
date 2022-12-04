#!/usr/bin/env bash

function all_sections_for_range() {
  seq -s ' ' "${1%%-*}" "${1#*-}"
}

function overlaps_with_other() {
  echo "${1%% }" | grep -E -w -o -q "${2// /|}"
}

count=0
while read -r line
do
  first="$( all_sections_for_range "${line%%,*}" )"
  second="$( all_sections_for_range "${line#*,}" )"
  if overlaps_with_other "$first" "${second%% }" || overlaps_with_other "$second" "${first%% }"
  then
    count=$(( count + 1 ))
  fi
done <'day4-input.txt'

echo "$count"

