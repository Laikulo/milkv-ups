#!/usr/bin/env bash

patch_dir="$(dirname "$0")"

if [[ ! -d $patch_dir ]]; then
	echo >&2 "FATAL: Could not find patches"
	exit 2
fi

target_kernel_dir="$1"

if [[ ! -d $target_kernel_dir ]]; then
	echo >&2 "FATAL: Could not find kernel tree"
	exit 2
fi

echo >&2 "Adding dropins..."
cp -vr "$patch_dir"/adds/* "$target_kernel_dir"

echo >&2 "Applying patches"
for patch in "$patch_dir/patches/"*.diff; do
	echo >&2 "applying $patch"
	patch -p1 -d "$target_kernel_dir" <"$patch"
done
