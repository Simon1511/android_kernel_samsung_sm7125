#!/bin/bash

imagepath=arch/arm64/boot/Image.gz-dtb
aikpath=rise/AIK

buildDate=$(date '+%Y%m%d')

riseVer=v1.0

deviceArray=(a52 a72)

# Colors
RED='\033[0;31m'
NC='\033[0m'

# Toolchain paths
PATH="/home/simon/lineage-19.0/prebuilts/clang/host/linux-x86/clang-r383902/bin:/home/simon/lineage-19.0/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:/home/simon/lineage-19.0/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:${PATH}"

# Set ARCH
ARCH=arm64
export $ARCH
export SUBARCH=$ARCH

# Set localversion
SET_LOCALVERSION() {
    sed -i 's|CONFIG_LOCALVERSION=""|CONFIG_LOCALVERSION="-riseKernel-'$1'.0-'$riseVer'"|g' arch/arm64/configs/vendor/lineage-$2q_defconfig
}

BUILD_BOOT() {
    variant=$1
    dev=$2
    full=$3
    
    if [ -f rise/build.log ]; then
        rm rise/build.log
    fi
    
    if [ -f rise/build.info ]; then
        rm rise/build.info
    fi

    if [ -f arch/arm64/configs/vendor/tmp_defconfig ]; then
        rm arch/arm64/configs/vendor/tmp_defconfig
    fi

    if [[ "$full" == "y" ]]; then
        echo "full=y" > rise/build.info
    else
        echo "full=n" > rise/build.info
    fi

    echo "variant=$variant" >> rise/build.info
    echo "device=$dev" >> rise/build.info

    # Set android version shown in localversion
    if echo "$variant" | grep -q "12"; then
       androidVer="12"
    fi

    SET_LOCALVERSION $androidVer $dev

    if [[ "$variant" == "AOSP "$androidVer".0" ]] || [[ "$variant" == "OneUI "$androidVer".0" ]]; then
        cat arch/arm64/configs/lineage-"$dev"q_defconfig >> arch/arm64/configs/vendor/tmp_defconfig

        if [[ "$variant" == "AOSP "$androidVer".0" ]]; then
            cat arch/arm64/configs/vendor/lineage_defconfig >> arch/arm64/configs/vendor/tmp_defconfig
        elif [[ "$variant" == "OneUI "$androidVer".0" ]]; then
            cat arch/arm64/configs/vendor/oneui_defconfig >> arch/arm64/configs/vendor/tmp_defconfig
        fi
    fi

    make $ARCH vendor/tmp_defconfig &> rise/build.log

    clear
    echo "Target: $variant for $dev"
    echo "Building..."

    make -j$(nproc --all) ARCH=arm64 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- CROSS_COMPILE_ARM32=arm-linux-androideabi- &> rise/build.log

    # Show error when the build failed
    if [ ! -f arch/arm64/boot/Image ]; then
        clear
        printf "${RED}ERROR${NC} encountered during build!\nSee rise/build.log for more information\n"
        exit
    fi

    rm arch/arm64/configs/vendor/tmp_defconfig
}

BUILD_ALL() {
    if [ -f rise/build.log ]; then
        rm rise/build.log
    fi
    
    if [ -f rise/build.info ]; then
        rm rise/build.info
    fi

    if [ -f arch/arm64/configs/vendor/tmp_defconfig ]; then
        rm arch/arm64/configs/vendor/tmp_defconfig
    fi

    echo "Building..."

    for i in ${deviceArray[@]}; do
        BUILD_BOOT "AOSP 12.0" "$i" "y"
        ./cleanup.sh > /dev/null 2>&1

        BUILD_BOOT "OneUI 12.0" "$i" "y"
        ./cleanup.sh > /dev/null 2>&1

    done

    clear

    ./rise/zip/zip.sh $riseVer $buildDate
}

clear
echo "Select build variant: [1-7] "

select opt in "AOSP 12.0" "OneUI 12.0" "Installation zip"
do

    clear
    echo "Selected: $opt"

    case $opt in
    "AOSP 12.0")
	read -p "Enter device: [A52/A72] " device
	if [[ "$device" == "A52" || "$device" == "a52" ]]; then
	    BUILD_BOOT "AOSP 12.0" "a52"
	elif [[ "$device" == "A72" || "$device" == "a72" ]]; then
	    BUILD_BOOT "AOSP 12.0" "a72"
	else
	    echo "Unknown device: $device"
	fi
	break ;;

    "OneUI 12.0")
	read -p "Enter device: [A52/A72] " device
	if [[ "$device" == "A52" || "$device" == "a52" ]]; then
	    BUILD_BOOT "OneUI 12.0" "a52"
	elif [[ "$device" == "A72" || "$device" == "a72" ]]; then
	    BUILD_BOOT "OneUI 12.0" "a72"
	else
	    echo "Unknown device: $device"
	fi
	break ;;

    "Installation zip")
        BUILD_ALL
	break
    esac
done
