# qemu-aarch64-LK-debug

# Linux Kernel Debugging with QEMU

This repository provides scripts and Makefile targets to configure, build, and run the Linux kernel using QEMU for debugging purposes.
The setup includes support for kernel debugging with GDB.

## Repository Structure

- `linux-6.10.2/`: Directory containing the Linux kernel source code.
- `rootfs_alpine.img`: Root filesystem image (Alpine Linux).

## Prerequisites

- QEMU
- GDB (multiarch)
- Cross-compiler for ARM64 (`aarch64-linux-gnu-`)
- Make

## Makefile Targets
### `make debug_kernel`

Starts GDB, connects to the QEMU instance, and prepares for debugging.

### `make build_kernel`

Builds the Linux kernel with the specified architecture and cross-compiler.

### `make all`

Builds all steps and run qemu for debug

### `make create_rootfs_image`

Create rootfs image using Alpine Linux (aarch64)

### `make run_qemu`

Starts QEMU with the built Linux kernel and the provided root filesystem image, enabling GDB server on port 1234.

### `make clean`

Clean all

## steps for debugging

- use `make run_qemu` to launch in debug mode (in one terminal)
- Debug in VScode: press debug and select 'Attach to QEMU' configuration
- Debug the code as required
- GDB in terminal (refer gdb_commands.txt)