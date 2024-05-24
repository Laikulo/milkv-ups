#!/usr/bin/env bash

set -x

if [ -d test-tree ]; then
	rm -rf test-tree
fi

cp -r stock test-tree
cp -r adds/* test-tree

for patchfile in patches/*.diff; do
	patch -p1 -d test-tree <"$patchfile"	
done
