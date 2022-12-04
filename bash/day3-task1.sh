#!/usr/bin/env bash

function unique_items() {
  fold -w 1 | sort | uniq
}

function unique_items_first_compartment() {
  echo "${1:0:${#1}/2}" | unique_items
}

function unqiue_items_second_compartment() {
  echo "${1:${#1}/2}" | unique_items
}

function common_items_between_compartments() {
  comm -12 \
  <( unique_items_first_compartment "$1" )\
  <( unqiue_items_second_compartment "$1" )
}

function common_items_per_rucksack() {
  while read -r line
  do
    common_items_between_compartments "${line}"
  done
}

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

function sum_lines() {
  tr '\n' '+' \
  | sed 's/+$/\n/' \
  | bc
}

cat 'day3-input.txt' \
  | common_items_per_rucksack \
  | item_priorities \
  | sum_lines
