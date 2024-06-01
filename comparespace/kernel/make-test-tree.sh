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
	echo >&2 "--- Cleaning existing tree"
	rm -rf test-tree
fi

echo >&2 "--- Creating stock tree"
cp -r stock test-tree
echo >&2 "--- Applying overlay"
cp -r adds/* test-tree

echo >&2 "--- Applying patches"
for patchfile in patches/*.diff; do
	echo "- $patchfile"
	patch -p1 -d test-tree <"$patchfile"	
done

# Remove the following form the tree, because they polute the diffs
# probably should exclude instead

echo >&2 "--- Generating diffs"
diff -qwr --no-dereference -X diffgen.ignore test-tree milky > summary.txt
diff -wurpN --no-dereference -X diffgen.ignore test-tree milky > remaining.diff

