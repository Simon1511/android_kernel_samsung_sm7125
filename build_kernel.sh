#!/bin/bash

ARCH=arm64

# Toolchain paths
PATH="/media/simon/sata_ext4/clang/clang-r383902/bin:/home/simon/lineage-20/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:/home/simon/lineage-19.1/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:${PATH}"

if [[ "$1" == "a52q" ]]; then
    make -j$(nproc --all) ARCH=$ARCH O=out CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi- vendor/a52q_eur_open_defconfig
elif [[ "$1" == "a72q" ]]; then
    make -j$(nproc --all) ARCH=$ARCH O=out CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi- vendor/a72q_eur_open_defconfig
fi

make -j$(nproc --all) O=out ARCH=$ARCH CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi-

tools/mkdtimg create out/arch/arm64/boot/dtbo.img --page_size=4096 $(find out/arch -name "*.dtbo")
