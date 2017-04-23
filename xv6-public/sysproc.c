#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

// When user process called yield function, eventually called sys_yield.
// But, kernel process called yield function, it is not been through system call, so sys_yield is not called.
// Calling yield function in user process might cause a problem for gaming scheduling.
// Static variable yieldcheck manages to increase proc->tick and totaltick.
// I designed current process portion in Stride scheduling is the scale to decide whether to do yield.
int
sys_yield(void)
{
    static int yieldcheck = 0;
    int ss_cpu_share = 100 -mlfq_cpu_share;
    yieldcheck += ss_cpu_share;
    if(yieldcheck>100)
    {
        yieldcheck -= 100;
        proc->tick++;
        totaltick++;
    }
    yield();
    return 0;
}

int
sys_getlev(void)
{
    return proc->level;
}
int
sys_set_cpu_share(void)
{
    int stride;
    argint(0, &stride);
    return set_cpu_share(stride);
}
