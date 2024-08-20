#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/uio_driver.h>
#include <linux/interrupt.h>
#include <linux/timer.h>

#define IRQ_PERIOD_MS 1000 // Timer period for generating interrupts

static struct uio_info dummy_uio_info;
static struct timer_list dummy_timer;

static void dummy_timer_callback(struct timer_list *t)
{
    /* Trigger an interrupt (notify userspace) */
    printk(KERN_INFO "Dummy UIO: Triggering interrupt\n");
    uio_event_notify(&dummy_uio_info);

    /* Re-arm the timer */
    mod_timer(&dummy_timer, jiffies + msecs_to_jiffies(IRQ_PERIOD_MS));
}

static int __init dummy_uio_init(void)
{
    printk(KERN_INFO "Dummy UIO: Initializing module\n");

    /* Initialize the uio_info structure */
    dummy_uio_info.name = "dummy_uio";
    dummy_uio_info.version = "0.1";
    dummy_uio_info.irq = UIO_IRQ_CUSTOM;
    dummy_uio_info.irq_flags = 0;

    /* Register the UIO device */
    if (uio_register_device(NULL, &dummy_uio_info)) {
        printk(KERN_ERR "Dummy UIO: Failed to register device\n");
        return -1;
    }

    /* Initialize the timer */
    timer_setup(&dummy_timer, dummy_timer_callback, 0);
    mod_timer(&dummy_timer, jiffies + msecs_to_jiffies(IRQ_PERIOD_MS));

    printk(KERN_INFO "Dummy UIO: Module loaded\n");
    return 0;
}

static void __exit dummy_uio_exit(void)
{
    printk(KERN_INFO "Dummy UIO: Exiting module\n");

    /* Remove the timer */
    del_timer(&dummy_timer);

    /* Unregister the UIO device */
    uio_unregister_device(&dummy_uio_info);

    printk(KERN_INFO "Dummy UIO: Module unloaded\n");
}

module_init(dummy_uio_init);
module_exit(dummy_uio_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your Name");
MODULE_DESCRIPTION("Dummy UIO Driver for Testing");
MODULE_VERSION("0.1");
