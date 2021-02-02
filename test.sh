#!/usr/bin/env sh
set -eu

. gel.sh

success() {
  printf '[GOOD] %s\n' "$1" >&2
}

fail() {
  printf '[FAIL] %s\n' "$1" >&2
}

assert_equal() {
  expected=$1
  actual=$2
  tag=$3
  if [ "$actual" != "$expected" ]; then
    fail "$tag"
    printf 'EXPECTED:\n%s\nACTUAL:\n%s' "$expected" "$actual"
    return 1
  else
    success "$tag"
    return 0
  fi
}

test_list() {
  expected=$(printf '1\n3')
  actual=$(list 1 3)
  tag=test_list
  assert_equal "$expected" "$actual" "$tag"
}
test_list

test_unlist() {
  expected=$(printf '1 2 3 4 5')
  actual=$(seq 5 | unlist)
  tag=test_unlist
  assert_equal "$expected" "$actual" "$tag"
}
test_unlist
