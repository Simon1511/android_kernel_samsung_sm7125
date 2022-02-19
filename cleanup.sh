
#!/bin/bash

full=$(grep "full" rise/build.info | sed 's/full=//g')

make clean
make mrproper

for i in `find rise/AIK/ -name "boot.img-zImage"`; do
    rm $i
done

for i in `find rise/AIK/ -name "boot.img-dtb"`; do
    rm $i
done

for i in `find rise/AIK/ -name "boot.img-board"`; do
    rm $i
done

if [[ `which git` == *"git"* ]]; then
    git checkout -- rise/AIK/*
    git checkout -- arch/arm64/configs/vendor/rise-*
fi

# Delete some other files
if [[ ! "$full" == "y" ]]; then
    rm rise/build.log
    rm rise/build.info
    rm arch/arm64/configs/vendor/tmp_defconfig
fi

# Always delete built DTBs/DTBOs
rm arch/arm64/boot/dts/*/*.dtb*
rm drivers/platform/msm/ipa/ipa_common
