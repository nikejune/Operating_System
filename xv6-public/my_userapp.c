#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    char* buf = "hello xv6!";
    int ret_val;
    ret_val = my_syscall(buf);
    printf(1,"Return value : 0x%x\n", ret_val);
    ret_val = getpid();
    printf(1, "my pid : %d\n", ret_val);
    ret_val = getppid();
    printf(1, "my ppid : %d\n", ret_val);
    
    exit();

}
