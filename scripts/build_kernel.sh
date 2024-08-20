#!/bin/bash

# Constants
KERNEL_DIR="linux-6.10.2"
CROSS_COMPILE="aarch64-linux-gnu-"

# Functions
error_exit() {
    echo "Error: $1"
    exit 1
}

# Step 2: Configure and compile Linux kernel with debugging symbols
echo "Configuring and compiling Linux kernel..."
cd ${KERNEL_DIR} || error_exit "Failed to change directory to ${KERNEL_DIR}"
make ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE clean || error_exit "Failed to clean kernel build"
make ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE defconfig || error_exit "Failed to configure kernel"

# debug
scripts/config --enable DEBUG_KERNEL || error_exit "Failed to enable debug info"
scripts/config --enable DEBUG_INFO || error_exit "Failed to enable debug info"

# uio
scripts/config --enable UIO || error_exit "Failed to enable UIO support"
scripts/config --enable UIO_CIF || error_exit "Failed to enable UIO_CIF support"
scripts/config --enable UIO_PDRV_GENIRQ || error_exit "Failed to enable UIO_PDRV_GENIRQ"
scripts/config --enable UIO_PCI_GENERIC || error_exit "Failed to enable UIO_PCI_GENERIC support"

make ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE modules_prepare || error_exit "Failed to prepare modules"
make ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE -j$(nproc) || error_exit "Failed to compile kernel"
if [ ! -f "vmlinux" ]; then
    error_exit "vmlinux was not generated"
fi
cd .. || error_exit "Failed to return to initial directory"
