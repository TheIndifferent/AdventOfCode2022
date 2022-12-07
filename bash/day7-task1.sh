#!/usr/bin/env bash

#set -x

readonly INPUT_FILE='day7-input.txt'

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

function flatten_dir_tree() {
  path=''
  while read -r first command dirname
  do
    if [[ $first == '$' ]]
    then
      if [[ $dirname == '..' ]]
      then
        path="${path%_*}"
      else
        path="${path}_${dirname}"
      fi
    else
      echo "${path} ${first}"
    fi
  done
}

#function filter_out_subtrees_with_large_files() {
#  buffer="$( cat - )"
#  while read -r dir size
#  do
#    if [[ $size -ge 100000 ]]
#    then
#      dir_to_remove="$dir"
#      while [[ -n "$dir_to_remove" ]]
#      do
#        buffer="$( echo "$buffer" | grep -v "$dir_to_remove " )"
#        dir_to_remove="${dir_to_remove%/*}"
#      done
#    fi
#  done < <( echo "$buffer" )
#  echo "$buffer"
#}

function create_physical_structure() {
  tmpdir="$( mktemp -d )"
  while read -r dir size
  do
    touch "${tmpdir}/${dir}-${size}"
  done
  echo "$tmpdir"
}

readonly rejected_dir_name='rejected'

function move_rejected_files() {
  tmpdir="$( cat - )"
  (
    cd "$tmpdir"
    mkdir "$rejected_dir_name"
    for file in *
    do
      if [[ "${file##*-}" -gt 100000 ]]
      then
        mv "${file}" "${rejected_dir_name}/"
      fi
    done
  )
  ls -lR "$tmpdir"
}

cat "$INPUT_FILE" | grep -v '$ ls' | grep -v 'dir ' | tail -n +2 \
  | sum_file_size_per_dir \
  | flatten_dir_tree \
  | create_physical_structure \
  | move_rejected_files
#  | cat -
#  | filter_out_subtrees_with_large_files
