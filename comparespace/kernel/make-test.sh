#!/usr/bin/env bash

if [[ ! -d stock ]]; then
	echo >&2 "FATAL: Stock tree missing"
	exit 1
fi

if [[ ! -d milky ]]; then
	echo >&2 "FATAL: Vendor tree missing"
	exit 1
fi

if [[ -d test-tree ]]; then
	rm -rf test-tree
fi

cp -r stock test-tree
cp -r adds/* test-tree

for patchfile in patches/*.diff; do
	echo "$patchfile"
	patch -p1 -d test-tree <"$patchfile"	
done

# Remove the following form the tree, because they polute the diffs
# probably should exclude instead

diff -qr --no-dereference -X diffgen.ignore test-tree milky > summary.txt
diff -urpN --no-dereference -X diffgen.ignore test-tree milky > remaining.diff

