#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/uaccess.h>

#define BUFFER_SIZE 64

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Example Author");
MODULE_DESCRIPTION("A simple example of a vulnerable kernel module");

static char kernel_buffer[BUFFER_SIZE];

static ssize_t vulnerable_function(const char *user_input, size_t len)
{
    char local_buffer[BUFFER_SIZE];
    // Vulnerability: No check on the length of the user input
    copy_from_user(local_buffer, user_input, len);
    printk(KERN_INFO "User input: %s\n", local_buffer);
    return len;
}

static int __init vulnerable_module_init(void)
{
    printk(KERN_INFO "Vulnerable module loaded.\n");
    return 0;
}

static void __exit vulnerable_module_exit(void)
{
    printk(KERN_INFO "Vulnerable module unloaded.\n");
}

module_init(vulnerable_module_init);
module_exit(vulnerable_module_exit);
