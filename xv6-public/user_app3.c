#include "types.h"
#include "stat.h"
#include "user.h"
    
int
main(int argc, char *argv[])
{

    int i,j;
    int pid = fork();
    uint cur_time;
    uint start_time=uptime();

    if(pid<0)
    {
        printf(1,"error\n");
    }
    else if(pid==0)
    {
       for(i=0;i<30;i++){
        cur_time = uptime();
        printf(1,"child %d %d %d\n", cur_time - start_time, start_time, cur_time);
        yield();
       }
    }
    else
    {
        
        for(j=0;j<30;j++){
        printf(1,"parent\n");
        yield();
        }
        wait();

    }
    exit();
}
