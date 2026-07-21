# Milkv UPS

## Synopsis
Buildroot setup for running NUT on a milkv duo.

## Quick Start
```
dev@box$ git clone https://github.com/Laikulo/milkv-ups.git --recurse-submodules
dev@box$ cd milkv-ups
dev@box$ ./space
ubuntu@asdf123$ ./confload
ubuntu@asdf123$ make -C buildroot
ubuntu@asdf123$ exit
dev@box$ dd if=buildroot/output/images/sd.img of=/path/to/sdcard/this/is/fake/to/avoid/disaster bs=4M status=progress oflag=direct
```

If disk usage is a concern, add `--filter=blob:none --also-filter-submodules` to the initial clone

To run package builds with less concurrency than the default (processors+1), add `BR2_JLEVEL=n` to the final make invocation. (where n is the desired number of concurrent jobs)

Note that buildroot does not (by default) build packages concurrently. This option controls the individual package build systems (e.g. make, ninja). Nothing in this tree should break top-level concurrency, but it is still an experimental feature.

## Layout
```
.
├── boot-files.txt  <- Notes about the bootup process of the milkv, and what is contained in the two bundles
├── br-milkv        <- Submodule containing a buildroot external tree
├── buildroot       <- Submodule containing buildroot itself
├── buildspace      <- Container definition for build workspace
├── comparespace    <- Working area for comparing vendored 'sdk' versions of things to their upstreams
├── configs         <- Config snippets and similar
└── space           <- Helper script to build and enter the build workspace
└── confload        <- Helper script to merge buildroot configs
```

## Components

### Buildroot

Buildroot is an existing project for building small linux environments for embedded devices.

It's homepage is at https://buildroot.org/, and canonical repo is at https://gitlab.com/buildroot.org/buildroot.

This project expects to track LTS versions of buildroot, which are released bi-annually. As of this writing 2025.02.X is the current LTS. The next LTS release is expected early 2027.

### milkv unofficial buildroot external tree

This is an [External Tree](https://buildroot.org/downloads/manual/manual.html#outside-br-custom) that extends buildroot to work on the milkv duo.

There are artifacts there for other cv1800x boards, but only the duo+sdcard portions are complete.

This tree currently brings in vendor-provided toolchains and firmware blobs. In the future, the project would like to use a buildroot-provided toolchain, and build the loaders from source.
The vendor has published the source of the all blobs that are needed to boot the device, though documentation is a bit sparse.

### buildspace / space script

This is a container and helper script used to build the environment.

The versions of software in LTS buildroot do not often compile on recent GCC, mostly due to changes in GCC's default C standard.
This is true even for some of the host software, which buildroot does not typically include a toolchain for.

The space script builds this container if it is not present, and then launches it such that:
- The repo checkout is at /mnt/work (and the container starts with that working directory)
- The user's ~/.br2dl is at /mnt/br2dl (and buildroot is configured to use it)
- A persistent volume is mounted at /mnt/ccache (and buildroot is configured to use it)
- The running user's UID is mapped to the 'ubuntu' user, so that strangeness with ownership is avoided.
- Buildroot is configured to pick up the external tree automatically.
- The container is cleaned up after the shell exists

Note that the container does include other users, so the running user will need subuids/subgids

### configs / confload
This contains a config snippet that enables the NUT package, and may contain more as time grows.

This allows us to separate the 'milkv' and 'ups' parts of this project cleanly, and __may__ allow us to use multiple similar upstream defconfigs together.

`confload` is a helper script that merges the config snippets, and places them where buildroot expects. It must be run within the buildspace.
