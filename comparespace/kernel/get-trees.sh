#!/usr/bin/env bash
if [[ ! -d stock ]]; then
	mkdir stock
	curl -# "https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.4.tar.xz" | tar -xJ -C stock --strip-components 1
fi

if [[ ! -d milky ]]; then
	mkdir milky
	curl -L\# "https://github.com/milkv-duo/duo-buildroot-sdk/archive/refs/heads/develop.tar.gz" | tar -xz -C milky --strip-components 2 duo-buildroot-sdk-develop/linux_5.10
fi
