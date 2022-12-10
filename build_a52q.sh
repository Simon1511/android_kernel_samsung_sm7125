#!/bin/bash

PATH="/home/simon/lineage-19.1/prebuilts/clang/host/linux-x86/clang-r383902/bin:/home/simon/lineage-19.1/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:/home/simon/lineage-19.1/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:${PATH}"

export ARCH=arm64

make ARCH=arm64 vendor/a52q_eur_open_defconfig

make ARCH=arm64 -j16 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi-
