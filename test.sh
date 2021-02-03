set -eu

. ./swi.sh

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

test_flip() {
  expected=$(list 1 2 3 4 5)
  actual=$(seq 5 | map printf '%s.txt' | map flip basename .txt)
  tag=test_flip
  assert_equal "$expected" "$actual" "$tag"
}
test_flip

test_list() {
  expected=$(printf '1\n3')
  actual=$(list 1 3)
  tag=test_list
  assert_equal "$expected" "$actual" "$tag"
}
test_list

test_list_empty() {
  expected=''
  actual=$(list '' | map printf ':%s')
  tag=test_list_empty
  assert_equal "$expected" "$actual" "$tag"
}
test_list_empty

test_unlist() {
  expected=$(printf '1 2 3 4 5')
  actual=$(seq 5 | unlist)
  tag=test_unlist
  assert_equal "$expected" "$actual" "$tag"
}
test_unlist

test_map() {
  expected=$(list 3 4 5 6 7)
  actual=$(seq 5 | map add 2)
  tag=test_map
  assert_equal "$expected" "$actual" "$tag"
}
test_map

test_filter() {
  expected=$(list 3 6 9)
  actual=$(seq 10 | filter is_divisible_by 3)
  tag=test_filter
  assert_equal "$expected" "$actual" "$tag"
}
test_filter

test_remove() {
  expected=$(list 1 2 4 5 7 8 10)
  actual=$(seq 10 | remove is_divisible_by 3)
  tag=test_remove
  assert_equal "$expected" "$actual" "$tag"
}
test_remove

test_reduce() {
  expected=15
  actual=$(seq 5 | reduce add)
  tag=test_reduce
  assert_equal "$expected" "$actual" "$tag"
}
test_reduce

test_drop() {
  expected=$(list 3 4 5)
  actual=$(seq 5 | drop 2)
  tag=test_drop
  assert_equal "$expected" "$actual" "$tag"
}
test_drop

test_drop_while() {
  expected=$(list 4 5)
  actual=$(seq 5 | drop_while gt 4)
  tag=test_drop_while
  assert_equal "$expected" "$actual" "$tag"
}
test_drop_while

test_take() {
  expected=$(list 1 2 3)
  actual=$(seq 5 | take 3)
  tag=test_take
  assert_equal "$expected" "$actual" "$tag"
}
test_take

test_append() {
  expected=$(list 1 2 3 a b c)
  actual=$(seq 3 | append a b c)
  tag=test_append
  assert_equal "$expected" "$actual" "$tag"
}
test_append

test_prepend() {
  expected=$(list a b c 1 2 3)
  actual=$(seq 3 | prepend a b c)
  tag=test_prepend
  assert_equal "$expected" "$actual" "$tag"
}
test_prepend

test_count() {
  expected=10
  actual=$(seq 10 | count)
  tag=test_count
  assert_equal "$expected" "$actual" "$tag"
}
test_count

test_take_while() {
  expected=$(list 1 2 3)
  actual=$(seq 5 | take_while gt 4)
  tag=test_take_while
  assert_equal "$expected" "$actual" "$tag"
}
test_take_while
