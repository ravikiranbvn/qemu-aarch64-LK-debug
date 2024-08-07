.PHONY: all download_kernel build_kernel download_alpine create_rootfs_image run_qemu clean

all: download_kernel build_kernel download_alpine create_rootfs_image run_qemu

download_kernel:
	@echo "Step 1: Download and extract Linux kernel"
	./scripts/download_kernel.sh

build_kernel:
	@echo "Step 2: Build kernel with debug symbols"
	./scripts/build_kernel.sh

download_alpine:
	@echo "Step 3: Download and extract Alpine minirootfs"
	./scripts/download_alpine.sh

create_rootfs_image:
	@echo "Step 4: Create and format root filesystem image"
	./scripts/create_rootfs_image.sh

run_qemu:
	@echo "Step 5: Run QEMU with GDB debugging enabled"
	./scripts/run_qemu.sh

clean:
	@echo "Cleaning up..."
	rm -rf linux-6.10.2 rootfs rootfs_alpine.img mnt alpine-minirootfs-*.tar.gz linux-*.tar.xz
