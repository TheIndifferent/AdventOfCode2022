#!/usr/bin/env bash

readonly INPUT_FILE='day7-input.txt'

function input_into_bash_command() {
  cat - \
  | grep -v '$ ls' \
  | grep -v 'dir ' \
  | tail -n +2 \
  | sed \
  -e 's/^\$ cd \.\.$/cd ../g' \
  -e 's/^\$ cd \(.*\)/mkdir "\1"\ncd "\1"/g' \
  -e 's/^\([0-9]*\) \(.*\)$/touch "\1_\2"/g'
}

function create_physical_structure() {
  tmpdir="$( mktemp -d )"
  command="$( cat - )"
  (
    cd "$tmpdir"
    bash -c "$command"
  )
  echo "$tmpdir"
}

function folder_size() {
  find "$1" -type f \
    | sed -e 's;^.*/;;g' -e 's/_.*$//g' \
    | tr '\n' '+' \
    | sed 's/+$/\n/' \
    | bc
}
export -f folder_size

function all_folder_sizes() {
  tmpdir="$( cat - )"
  find "$tmpdir" -type d -exec bash -c 'folder_size "{}"' ';'
}

function numbers_below_limit() {
  grep -E '100000|^[0-9]{1,5}$'
}

function sum_of_lines() {
  tr '\n' '+' \
  | sed 's/+$/\n/' \
  | bc
}

cat "$INPUT_FILE" \
  | input_into_bash_command \
  | create_physical_structure \
  | all_folder_sizes \
  | numbers_below_limit \
  | sum_of_lines
