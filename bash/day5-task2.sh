#!/usr/bin/env bash

readonly INPUT_FILE='day5-input.txt'

stacks=()

function create_stacks() {
  for s in 0 $@
  do
    stacks+=('')
  done
}

function build_initial_stacks() {
  while IFS= read -r line
  do
    local stack_index=1
    local crates="$( echo "$line" | sed -e 's/    /_ /g' -e 's/\[//g' -e 's/\]//g' -e 's/ //g' )"
    for crate in $( echo "$crates" | fold -w 1 )
    do
      if [[ "$crate" != '_' ]]
      then
        local stack="${stacks[$stack_index]}${crate}"
        stacks[$stack_index]="$stack"
      fi
      stack_index=$(( $stack_index + 1 ))
    done
  done
}

function process_move_operations() {
  while read -r move_number from to
  do
    from_stack="${stacks[$from]}"
    crates_to_move="${from_stack:0:$move_number}"
    stacks[$from]="${from_stack#$crates_to_move}"
    to_stack="${stacks[$to]}"
    stacks[$to]="${crates_to_move}${to_stack}"
  done
}

function print_top_crates() {
  for n in $1
  do
    stack="${stacks[$n]}"
    echo -n "${stack:0:1}"
  done
}

readonly stack_numbers="$( grep '^ 1' "$INPUT_FILE" )"
create_stacks "$stack_numbers"
build_initial_stacks < <( grep '\[' "$INPUT_FILE" )
process_move_operations < <( grep 'move' "$INPUT_FILE" | sed -e 's/move //g' -e 's/from //g' -e 's/to //g' )
result="$( print_top_crates "$stack_numbers" )"
echo "$result"
