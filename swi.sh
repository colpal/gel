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

drop() {
  tail -n +$(($1 + 1))
}

count() {
  cat - | wc -l | tr -d ' '
}

take() {
  head -n "$1"
}

take_while() {
  fn=$1
  shift
  item=
  while read -r item; do
    if $fn "$@" "$item"; then
      printf '%s\n' "$item"
    else
      return 0
    fi
  done
}

drop_while() {
  fn=$1
  shift
  item=
  while read -r item; do
    if $fn "$@" "$item"; then
      continue
    fi
    printf '%s\n' "$item"
  done
}

append() {
  cat -
  list "$@"
}

prepend() {
  list "$@"
  cat -
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
  item=
  while read -r item; do
    if $fn "$@" "$item"; then
      printf '%s\n' "$item"
    fi
  done
}

remove() {
  fn=$1
  shift
  item=
  while read -r item; do
    if ! $fn "$@" "$item"; then
      printf '%s\n' "$item"
    fi
  done
}

reduce() {
  fn=$1
  shift
  accumulation=
  read -r accumulation
  while read -r item; do
    accumulation=$($fn "$@" "$accumulation" "$item")
  done
  printf '%s' "$accumulation"
}

add() {
  printf '%s' "$(( $1 + $2))"
}

square() {
  printf '%s' "$(( $1 * $1))"
}

is_even() {
  is_divisible_by 2 "$1"
}

is_divisible_by() {
  test "$(( $2 % $1 ))" -eq 0
}

gt() {
  test "$1" -gt "$2"
}

str_eq() {
  test "$1" = "$2"
}

eq() {
  test "$1" -eq "$2"
}

not() {
  ! "$@"
}
