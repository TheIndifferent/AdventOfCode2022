#!/bin/bash

cat 'day2-input.txt' \
  | sed -e 's/A/Rock/g' -e 's/B/Paper/g' -e 's/C/Scissors/g' -e 's/X/Rock/g' -e 's/Y/Paper/g' -e 's/Z/Scissors/g' \
  | sed \
  -e 's/Rock Rock/4/g' \
  -e 's/Rock Paper/8/g' \
  -e 's/Rock Scissors/3/g' \
  -e 's/Paper Rock/1/g' \
  -e 's/Paper Paper/5/g' \
  -e 's/Paper Scissors/9/g' \
  -e 's/Scissors Rock/7/g' \
  -e 's/Scissors Paper/2/g' \
  -e 's/Scissors Scissors/6/g' \
  | awk '{s+=$1} END {printf "%.0f\n", s}'
