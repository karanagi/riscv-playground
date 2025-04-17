#!/bin/bash

count_test() {
	prog="$1"
	expected="$2"
	shift 2

	qemu-riscv64 ./"$prog" "$@"
	if [[ "$expected" -ne "$?" ]]; then
		echo "[-] Count test failed"
		echo "expected: $expected"
		echo "actual: $?"
		exit 1
	fi
}

do_count_tests() {
	count_test "count_args" 1 
	count_test "count_args" 6 hello friend i am here

	echo "[+] Count test pass"
}

do_count_tests

echo "[+] Success"
