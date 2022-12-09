#!/usr/bin/env bash

set -x

readonly INPUT_FILE='day7-input-sample.txt'

function sum_file_size_per_dir() {
  size=0
  prev_rest='cd ..'
  while read -r first rest
  do
    if [[ $first == '$' ]]
    then
#      if [[ $size -ne 0 ]]
#      then
#        echo "$size"
#      fi
      if [[ "$prev_rest" != 'cd ..' ]]
      then
        echo "$size"
      fi
      echo "$ $rest"
      size=0
    else
      size=$(( $size + $first ))
    fi
    prev_rest="${rest}"
  done
}

function create_physical_structure() {
  tmpdir="$( mktemp -d )"
  (
    cd "$tmpdir"
    size=0
    while read -r first second third
    do
      if [[ $first == '$' ]]
      then
        if [[ $size -ne 0 ]]
        then
          touch "$size"
        fi
        size=0
        if [[ "$third" == '..' ]]
        then
          cd ..
        else
          mkdir "$third"
          cd "$third"
        fi
      else
        size=$(( $size + $first ))
      fi
    done
  )
  echo "$tmpdir"
}

function next() {
  tmpdir="$( cat - )"
  find "$tmpdir" -type f
}

cat "$INPUT_FILE" | grep -v '$ ls' | grep -v 'dir ' | tail -n +2 \
  | create_physical_structure \
  | next
#  | sum_file_size_per_dir \
#  | flatten_dir_tree \
#  | move_rejected_files
#  | filter_out_subtrees_with_large_files
