#!/bin/bash

# Constants
KERNEL_DIR="linux-6.10.2"

# Functions
error_exit() {
    echo "Error: $1"
    exit 1
}

# Step 2: Configure and compile Linux kernel with debugging symbols
echo "Configuring and compiling Linux kernel..."
cd ${KERNEL_DIR} || error_exit "Failed to change directory to ${KERNEL_DIR}"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- clean || error_exit "Failed to clean kernel build"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig || error_exit "Failed to configure kernel"
scripts/config --enable DEBUG_INFO || error_exit "Failed to enable debug info"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc) DEBUG=y || error_exit "Failed to compile kernel"
if [ ! -f vmlinux ]; then
    error_exit "vmlinux was not generated"
fi
cd .. || error_exit "Failed to return to initial directory"