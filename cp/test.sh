#!/bin/bash

qemu="qemu-riscv64"

check_hash() {
	original="$1"
	new="$2"

	n=$(md5sum "$original" "$new" | \
		awk '{print $1}' | \
		sort | uniq | wc -l)

	if [[ "$n" -ne 1 ]]; then
		echo "[-] hashes of \"$original\" and \"$new\" do not match"
		exit 1
	fi
}

"$qemu" cp cp.s "test.s"
check_hash cp.s "test.s"

echo "[+] Pass"
rm "test.s"
