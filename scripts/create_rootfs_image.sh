#!/bin/bash

# Constants
ROOTFS_IMG="rootfs_alpine.img"
MNT_DIR="mnt"
ROOTFS_DIR="rootfs_alpine"

# Functions
error_exit() {
    echo "Error: $1"
    exit 1
}

# Step 4: Create and format root filesystem image
echo "Creating and formatting root filesystem image..."
dd if=/dev/zero of=${ROOTFS_IMG} bs=1M count=512 || error_exit "Failed to create root filesystem image"
mkfs.ext4 ${ROOTFS_IMG} || error_exit "Failed to format root filesystem image"
mkdir -p ${MNT_DIR} || error_exit "Failed to create mount directory"
sudo mount -o loop ${ROOTFS_IMG} ${MNT_DIR} || error_exit "Failed to mount root filesystem image"
sudo cp -r ${ROOTFS_DIR}/* ${MNT_DIR}/ || error_exit "Failed to copy files to root filesystem image"
sudo umount ${MNT_DIR} || error_exit "Failed to unmount root filesystem image"
