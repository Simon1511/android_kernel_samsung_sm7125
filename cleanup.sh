#!/bin/bash

make clean
make mrproper

# Always delete built DTBs/DTBOs
rm arch/arm64/boot/dts/*/*.dtb*
rm drivers/platform/msm/ipa/ipa_common
