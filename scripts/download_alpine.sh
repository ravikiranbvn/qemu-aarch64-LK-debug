#!/bin/bash

# Constants
ALPINE_VERSION="3.20.0"
ALPINE_URL="https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/aarch64/alpine-minirootfs-${ALPINE_VERSION}-aarch64.tar.gz"
ROOTFS_DIR="rootfs_alpine"

# Functions
error_exit() {
    echo "Error: $1"
    exit 1
}

# Step 3: Download and extract Alpine minirootfs
echo "Downloading Alpine minirootfs ${ALPINE_VERSION}..."
wget ${ALPINE_URL} || error_exit "Failed to download Alpine minirootfs"
mkdir -p ${ROOTFS_DIR} || error_exit "Failed to create rootfs directory"
tar -xzf alpine-minirootfs-${ALPINE_VERSION}-aarch64.tar.gz -C ${ROOTFS_DIR} || error_exit "Failed to extract Alpine minirootfs"
