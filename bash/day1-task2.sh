#!/bin/bash

tempfile="$( mktemp )"
current=0

while read -r line
do
  if [[ -n $line ]]
  then
    current=$(( current + line ))
  else
    echo "$current">>"$tempfile"
    current=0
  fi
done < 'day1-input.txt'

cat "$tempfile" | sort -r | head -3 | awk '{s+=$1} END {printf "%.0f\n", s}'
rm "$tempfile"
