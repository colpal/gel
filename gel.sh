#!/usr/bin/env sh
set -eu

list() {
  for item in "$@"; do
    printf '%s\n' "$item"
  done
}

unlist() {
  cat - | xargs
}

map() {
  fn=$1
  shift
  item=
  while read -r item; do
    printf '%s\n' "$($fn "$@" "$item")"
  done
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

is_divisible_by() {
  test "$(( $2 % $1 ))" -eq 0
}
