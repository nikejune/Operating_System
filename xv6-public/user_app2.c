#include "types.h"
#include "stat.h"
#include "user.h"
    
int
main(int argc, char *argv[])
{

    int i,j;
    int pid = fork();
    if(pid<0)
    {
        printf(1,"error\n");
    }
    else if(pid==0)
    {
       for(i=0;i<30;i++){
        printf(1,"child\n");
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
