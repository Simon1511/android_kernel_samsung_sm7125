#!/bin/bash

PATH="../toolchains/clang/clang-r383902/bin:../toolchains/gcc/aarch64/bin:../toolchains/gcc/arm/bin:${PATH}"

export ARCH=arm64

make ARCH=arm64 vendor/a52q_eur_open_defconfig

make ARCH=arm64 -j16 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi-
