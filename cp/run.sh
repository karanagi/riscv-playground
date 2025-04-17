#!/bin/bash

qemu="qemu-riscv64"
gdb="riscv64-linux-gnu-gdb"
debug_port="1234"
debug_flag=0

while getopts "d" opt; do
	case "$opt" in 
		d)
			debug_flag=1
			;;
		*)
			break
			;;
	esac
done

shift $((OPTIND -1))
prog="$1"
shift 1

if [[ "$debug_flag" -eq 1 ]]; then
	"$qemu" -g "$debug_port" "$prog" "$@" & 
	"$gdb" "$prog"
else
	"$qemu" "$prog" "$@"
fi
