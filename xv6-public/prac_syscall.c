#include "types.h"
#include "defs.h"
#include "x86.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"


int 
my_syscall (char *str) 
{

    cprintf("%s\n", str);
    return 0xABCDABCD;
}

//wrapper for my syscall
int 
sys_my_syscall (void)
{
    char *str;
    //Decode argument using argstr
    if(argstr(0, &str) <0)
        return -1;
    return my_syscall(str);
}

int
getppid (void)
{
   return proc->parent->pid;
}

int
sys_getppid (void)
{
    return getppid();
    
}
