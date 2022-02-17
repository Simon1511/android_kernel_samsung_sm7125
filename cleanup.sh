#!/bin/bash

make clean
make mrproper

# Always delete built DTBs/DTBOs
rm arch/arm64/boot/dts/*/*.dtb*

rm arch/arm64/crypto/sha256-core.S
rm arch/arm64/kernel/vdso/vdso.lds
rm arch/arm64/kernel/vdso/vdso.so
rm arch/arm64/kernel/vdso/vdso.so.dbg
rm arch/arm64/kernel/vmlinux.lds
rm block/.tmp_ioprio.ver
rm certs/signing_key.pem
rm certs/signing_key.x509
rm certs/x509.genkey
rm drivers/base/.tmp_platform.ver
rm drivers/clk/.tmp_clkdev.ver
rm kernel/bpf/.tmp_verifier.ver
rm kernel/locking/.tmp_rtmutex.ver
rm kernel/power/.tmp_qos.ver
rm net/core/.tmp_skbuff.ver
