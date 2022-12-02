#!/bin/bash

cat 'day2-input.txt' \
  | sed -e 's/A/Rock/g' -e 's/B/Paper/g' -e 's/C/Scissors/g' -e 's/X/Lose/g' -e 's/Y/Draw/g' -e 's/Z/Win/g' \
  | sed \
  -e 's/Rock Win/Rock Paper/g' \
  -e 's/Rock Draw/Rock Rock/g' \
  -e 's/Rock Lose/Rock Scissors/g' \
  -e 's/Paper Win/Paper Scissors/g' \
  -e 's/Paper Draw/Paper Paper/g' \
  -e 's/Paper Lose/Paper Rock/g' \
  -e 's/Scissors Win/Scissors Rock/g' \
  -e 's/Scissors Draw/Scissors Scissors/g' \
  -e 's/Scissors Lose/Scissors Paper/g' \
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
  | tr '\n' '+' \
  | sed 's/+$/\n/' \
  | bc
