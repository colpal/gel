#!/usr/bin/env sh
set -eu

map() {
  fn=$1
  shift
  output=''
  for item in "$@"; do
    if [ -z "$output" ]; then
      output=$($fn "$item")
    else
output="$output
$($fn "$item")"
    fi
  done
  printf '%s' "$output"
}

filter() {
  fn=$1
  shift
  output=''
  for item in "$@"; do
    if ! $fn "$item"; then
      continue
    fi

    if [ -z "$output" ]; then
      output="$item"
    else
output="$output
$item"
    fi
  done
  printf '%s' "$output"
}

reduce() {
  fn=$1
  accumulation=$2
  shift 2
  for item in "$@"; do
    accumulation=$($fn "$accumulation" "$item")
  done
  printf '%s' "$accumulation"
}

identity() {
  printf '%s' "$1"
}

add() {
  printf '%s' "$(( $1 + $2))"
}

square() {
  printf '%s' "$(( $1 * $1))"
}

is_even() {
  test "$(( $1 % 2 ))" -eq 0
}

filter is_even 1 2 3 4 5
printf '\n===\n'
map square 1 2 3 4 5
printf '\n===\n'
reduce add 1 2 3 4 5
