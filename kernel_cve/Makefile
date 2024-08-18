obj-m = vul_km_so.o

# Define the kernel source directory and architecture
KERNELDIR ?= ../linux-6.10.2
ARCH = arm64
CROSS_COMPILE = aarch64-linux-gnu-

# Get the current directory
PWD := $(shell pwd)

all:
	@make -C $(KERNELDIR) M=$(PWD) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) modules

clean:
	@make -C $(KERNELDIR) M=$(PWD) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) clean

