#!/bin/bash

# Constants
KERNEL_DIR="linux-6.10.2"
ROOTFS_IMG="rootfs_alpine.img"
KERNEL_IMAGE="${KERNEL_DIR}/arch/arm64/boot/Image"

# Functions
error_exit() {
    echo "Error: $1"
    exit 1
}

# Step 5: Run QEMU with GDB debugging enabled
echo "Running QEMU with GDB debugging enabled..."
qemu-system-aarch64 \
    -machine virt \
    -cpu cortex-a57 \
    -smp 2 \
    -m 2048 \
    -kernel ${KERNEL_IMAGE} \
    -append "root=/dev/vda console=ttyAMA0 init=/bin/sh nokaslr" \
    -drive if=none,file=${ROOTFS_IMG},format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 \
    -netdev user,id=net0 \
    -device virtio-net-device,netdev=net0 \
    -nographic \
    -s -S || error_exit "Failed to run QEMU"