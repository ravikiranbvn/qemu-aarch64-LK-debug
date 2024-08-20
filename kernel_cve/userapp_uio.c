#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>

#define UIO_DEVICE "/dev/uio0"

// Function that handles interrupt in a separate thread
void* interrupt_handler(void* arg) {
    int uio_fd = *(int*)arg;
    unsigned int irq_count;

    while (1) {
        // Blocking read, waits for the interrupt
        if (read(uio_fd, &irq_count, sizeof(irq_count)) == sizeof(irq_count)) {
            printf("Interrupt received! Count: %u\n", irq_count);

            // Acknowledge the interrupt by writing back to the UIO device
            if (write(uio_fd, &irq_count, sizeof(irq_count)) < 0) {
                perror("Failed to acknowledge interrupt");
                close(uio_fd);
                pthread_exit(NULL);
            }
        } else {
            perror("Failed to read from UIO device");
            close(uio_fd);
            pthread_exit(NULL);
        }
    }
}

int main() {
    int uio_fd;
    pthread_t thread_id;

    // Open the UIO device
    uio_fd = open(UIO_DEVICE, O_RDWR);
    if (uio_fd < 0) {
        perror("Failed to open UIO device");
        return EXIT_FAILURE;
    }

    // Create a thread to handle interrupts
    if (pthread_create(&thread_id, NULL, interrupt_handler, &uio_fd) != 0) {
        perror("Failed to create thread");
        close(uio_fd);
        return EXIT_FAILURE;
    }

    printf("Main program continues execution while waiting for interrupts...\n");

    // Main program can perform other tasks here
    while (1) {
        // Simulate doing some other work in the main thread
        printf("Main program is working...\n");
        sleep(5);
    }

    // Wait for the interrupt thread to finish (it won't in this case)
    pthread_join(thread_id, NULL);

    close(uio_fd);
    return 0;
}
