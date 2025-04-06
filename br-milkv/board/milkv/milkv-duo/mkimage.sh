#!/usr/bin/env bash

IMAGES_DIR="$1"

FW_DIR="$IMAGES_DIR/duo-firmware"
## Create output in images for work area
[[ -d $FW_DIR ]] || install -d "$FW_DIR"

VENDOR_FW_DIR="$HOST_DIR/share/firmware/cvi"


# Not quite sure why the RTOS below is required. IIUC, it should be optional
"$HOST_DIR/bin/cvi-fiptool" \
  --fsbl "$VENDOR_FW_DIR/fsbl/cv180x.bin" \
  --ddr_param "$VENDOR_FW_DIR/ddr_param.bin" \
  --rtos "$VENDOR_FW_DIR/cvirtos.bin" \
  --opensbi "/dev/null" \
  --uboot "/dev/null" \
  "$FW_DIR/fip.bin"

## TODO: UBOOT
## TODO: opensbi

## TODO: genimage
