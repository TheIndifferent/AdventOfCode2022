#!/usr/bin/env bash

function unique_items() {
  fold -w 1 | sort | uniq
}

function common_items_between_rucksacks() {
  common_items_first_second="$( comm -12 <( echo "$1" | unique_items ) <( echo "$2" | unique_items ) )"
  comm -12 <( echo "$3" | unique_items ) <( echo "$common_items_first_second" | unique_items )
}

export -f common_items_between_rucksacks
export -f unique_items

function item_priorities() {
  declare -A priorities
  number=0
  for item in $( echo {a..z} {A..Z} )
  do
    number=$(( number + 1 ))
    priorities[$item]=$number
  done

  while read -r line
  do
    echo ${priorities[$line]}
  done
}

cat 'day3-input.txt' \
  | xargs -L3 bash -c 'common_items_between_rucksacks $0 $1 $2' \
  | item_priorities \
  | tr '\n' '+' \
  | sed 's/+$/\n/' \
  | bc
