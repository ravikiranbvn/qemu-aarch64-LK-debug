#!/bin/bash

# Constants
KERNEL_VERSION="6.10.2"
KERNEL_URL="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${KERNEL_VERSION}.tar.xz"
KERNEL_DIR="linux-${KERNEL_VERSION}"

# Functions
error_exit() {
    echo "Error: $1"
    exit 1
}

# Step 1: Download and extract Linux kernel
echo "Downloading Linux kernel ${KERNEL_VERSION}..."
wget ${KERNEL_URL} || error_exit "Failed to download kernel"
tar -xf linux-${KERNEL_VERSION}.tar.xz || error_exit "Failed to extract kernel"
