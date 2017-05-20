#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

struct spinlock nplock;

static struct proc *initproc;

//additional variable
int totaltick;              // Timer interrupt or sys_yield increase this value
int mlfq_stride =0;         // Stride of mlfq scheduler like a process  
int mlfq_cpu_share=100;     // CPU_share of mlfq scheduler like a process
int mlfq_pass=0;            // Pass value of mlfq scheduler like a process

int szcheck = 0;
int szcheck2 =1;


int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  if(p->pid>10000)
  {
      nextpid = 1;

  }

  //additional init 
  p->level = 0;
  p->tick = 0;
  p->cpu_share = 0;
  p->stride = 0;
  p->pass = 0;
  p->thread_id = -1;
  p->numofthread = 0;
  p->numofthread2 = 0;
  p->th_stack =0;
  p-> retval = 0;

  
  release(&ptable.lock);
  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();

  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;

  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);

  safestrcpy(np->name, proc->name, sizeof(proc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  szcheck2 = 1;
  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
     havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        //addition restoration
        p->tick = 0;
        p->level = 0;
        mlfq_cpu_share += p->cpu_share;
        mlfq_stride = (int)(10000 / mlfq_cpu_share);
        p->cpu_share = 0;
        p->stride = 0;
        p->pass =0;
        p->thread_id = -1;
        p->numofthread = 0;
        p->numofthread2 = 0;
        p->th_stack = 0;
        p->retval = 0;
        //
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}

// If totaltick exceed to 100,
// It reset to 0 and all prcocess->tick and process->level reset to 0.    
void
priorityboost (void)
{
  struct proc * p; 
  if(totaltick >= 100)
  {
      totaltick = 0;
  //    cprintf("boost!\n");
      totaltick =0;
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
      {
              p->tick = 0;
              p->level = 0;
      }
  }
}

// This function(statement) was originally located at scheduler function.
// Only priorityboost function was added. 
void
swtchp(struct proc * p, int idx)
{
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, p->context);
      switchkvm();
      // Process is done running for now.
      // It should have changed its p->state before coming back.
     
      // idx ==3 means it called from stride scheduling , so it don't need priorityboost.
      if(idx != 3)
      {
          priorityboost();
      }
      proc = 0;
    
}

// Stride Scheduler judged that it was mlfq turn,  this function called.
// It looks like mlfq function is a process for Stride Scheduler.
void
mlfq (void)
{
    struct proc * p;
    // If qcheck is 0, MLFQ scheduler continue to check
    // which process is suitable for selection at the following level.
    // If qcheck is 1, it doesn't check next level. 
    int qcheck = 0;        

    // Priority down
    // If level 0 , level1, and level2 are each 5 ticks, 10 ticks, and 20 ticks,
    // its level goes down. (But level2 is the lowest level, so keep it.)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->level == 0 && p->tick >= 5)
        {
            p->tick = 0;
            p->level= 1;
        }
        if(p->level == 1 && p->tick >= 10)
        {
            p->tick = 0;
            p->level= 2;
        }
        if(p->level == 2 && p->tick >= 20)
        {
          p->tick = 0;
        }
    } 

    //process state RUNNABLE && process level 0 && process in MLFQ, choice process by RR.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state != RUNNABLE || p->level != 0 || p->cpu_share != 0)
           continue;
        swtchp(p,0);
        qcheck = 1;  // It don't need to check level 1, 2
      }

    //process state RUNNABLE && process level 1 && process in MLFQ, choice process by RR.
    if(!qcheck){
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state != RUNNABLE || p->level != 1 || p->cpu_share != 0)
           continue;
        swtchp(p,1);
        qcheck = 1;  // It don't need to check level 2
      }
    }
    //process state RUNNABLE && process level 2 && process in MLFQ, choice process by RR.
    if(!qcheck){
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        
        if(p->state != RUNNABLE || p->level !=2 || p->cpu_share != 0)
           continue;
        swtchp(p,2);
      }
    }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.

// scheduler function handles processes by Stride Scheduling.
// 1. Find the minimum pass of process.
// 2. Compare it with MLFQ pass.
// 3. If it is smaller than MLFQ pass, execute it.
// 4. Otherwise execute MLFQ function (like a process)
void
scheduler(void)
{
  struct proc *p;
  struct proc *minp;
  int min_pass;
  int check;
  // If check is 0, Stride scheduler go to MLFQ scheduler( like a process).
  // If check is 1, Stride scheduler execute minimum pass value process.(not process in MLFQ)
  
  for(;;)
  {
      sti();
      check = 0;
 
      min_pass = 200000;
      minp = 0;             // NULL

      acquire(&ptable.lock);
   
      // If mlfq_pass exceed to 100000, all pass value reset 0 to prevent overflow.
      if(mlfq_pass >= 100000){ 
          mlfq_pass = 0;
          for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
              if(p->pass != 0)
                  p->pass = 0;
          }
      }
  
      // Find the mininum pass value
      // Condition : cpu_share > 0 (has stride) && process state RUNNABLE
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
          if(p->cpu_share >0 &&  p->state == RUNNABLE && (min_pass > p->pass)){
            min_pass = p->pass;
            minp = p;
          }
      }
   
      // Comparing min_pass to mlfq_pass, If min_pass is smaller than mlfq_pass and minp is not NULL,
      // check value turns 0 to 1.
      if(minp != 0 && (min_pass < mlfq_pass))
          check = 1;
     
      // check == 1 , execute process in SS
      if(check){
          minp->pass += minp->stride;
          swtchp(minp,3);
      }
      // check == 0 , execute process in MLFQ
      else{
          mlfq_pass +=mlfq_stride;
          mlfq();
      }
      release(&ptable.lock);
  }
}
// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  proc->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
  proc->state = SLEEPING;
  sched();

  // Tidy up.
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

// when user process request to set CPU share, sys_set_cpu_share is called,
// and sys_set_cpu_share called this function with argument 'share'.
// It change mlfq_stride, mlfq_cpu_share, proc->stride, and proc->cpu_share.
// If 'share' is exceed to 80%, return -1 (error), else return 'share'.
int
set_cpu_share(int share)
{
    struct proc *p;
    int total = 0;      // CPU share of process in Stride Scheduling.
  
    // No negative share.
    if(share <= 0)
        cprintf("share value cannot be negative\n");

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        total += p->cpu_share;
    }
    release(&ptable.lock);

    // Process in Stride Scheduling cannot exceed to 80% of cpu time.
    if(total + share > 80){
        cprintf(" CPU share of stride value cannot exceed to 80 percents of cpu time!\n");
        return -1;
    }
    else{
        mlfq_cpu_share = 100 - total - share;
        mlfq_stride = (int)(10000 / mlfq_cpu_share);
        proc->cpu_share = share;
        proc->stride = (int)(10000 / share);
        return share;
    }
}


int
thread_create(thread_t* thread, void*(*start_routine)(void*), void* arg)
{
  int i, pid;
  struct proc *np;
  uint sp, ustack[2];

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }


  //PGROUNDUP
  proc->sz = PGROUNDUP(proc->sz);
    if((proc->sz = allocuvm(proc->pgdir, proc->sz, proc->sz + 2* PGSIZE)) == 0)
      return -1;

  np->th_stack = proc->sz;
  // Copy process state from p.
  np->pgdir = proc->pgdir;

  // np additional setup 
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;
  acquire(&nplock);
  np->parent->numofthread++;
  np->parent->numofthread2++;
  release(&nplock);
  np->thread_id = (thread_t)np->pid;
  *thread = np->thread_id;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);

  safestrcpy(np->name, proc->name, sizeof(proc->name));

  pid = np->pid;

  sp = np->th_stack;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = (uint)arg;

  sp -= 8;
  //thread additional operation
  if(copyout(np->pgdir, sp, ustack, (2)*4) < 0)
  {
      cprintf("copy stack failed\n");
      return -1;
  }
  
  np->tf->eip = (uint)start_routine; // eip change
  np->tf->esp = sp;


  // Commit to the user image.
  switchuvm(proc);

  acquire(&ptable.lock);
  np->state = RUNNABLE;
    release(&ptable.lock);
 
 //   cprintf("threadid : %d, stack address :%d\n", np->thread_id, np->th_stack);
 //   cprintf("current numofthread : %d \n", np->parent->numofthread);
 
  return pid;
}

void
thread_exit (void* retval)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  proc->retval = retval;
  sched();
  panic("zombie exit");


}

int
thread_join(thread_t thread, void** retval)
{
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
     havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc || p->thread_id != thread)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one
        *retval = p->retval;
        p->parent->numofthread--;

      if(p->parent->numofthread == 0 ){
          if((p->parent->sz=deallocuvm(p->parent->pgdir, p->parent->sz, p->parent->sz-2*(p->parent->numofthread2)*PGSIZE)) == 0)
           return -1;
          p->parent->numofthread2 =0;
      }
       

     /*   if(p->parent->numofthread == 0 )
        {  
                  p->parent->sz = p->parent->oldsz;
    
        }*/
//        if((deallocuvm(p->parent->pgdir, (uint)p->parent->sz, (uint)p->parent->sz -2* PGSIZE)) == 0)
//            return -1;
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        //addition restoration
        p->tick = 0;
        p->level = 0;
        mlfq_cpu_share += p->cpu_share;
        mlfq_stride = (int)(10000 / mlfq_cpu_share);
        p->cpu_share = 0;
        p->stride = 0;
        p->pass =0;
        p->thread_id= -1;
        p->numofthread = 0;
        p->th_stack = 0;
        p->retval =0;


      //  kfree((char*)p->th_stack);
        //
        p->state = UNUSED;
        release(&ptable.lock);


        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
