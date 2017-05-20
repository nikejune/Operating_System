#include "types.h"
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "x86.h"


#define PGSIZE		4096

int thread_create(thread_t* thread, void*(*start_routine)(void*), void* arg){
   void *stack = (void*)1234;

   if ((uint)stack == 0)
   {
       return -1;
   }
   if((uint)stack % PGSIZE){
   stack += PGSIZE - (uint)stack % PGSIZE;
   }
   
   *thread =  th_create(thread, start_routine, arg,(uint)stack);
  
   if(thread<0)
       return -1;
   else
       return 0;
}
void thread_exit(void* retval)
{
    th_exit(retval);
    exit();

}
int thread_join(thread_t thread, void** retval){
 
  void * stack;
  int ret;

  ret = th_join(thread, retval, (uint*)&stack);

 
  if(ret<=0)
  {
      return -1;
  }
  else
  {
   //free(stack);
   return 0;
  }
}
