#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char * argv[])
{
    int rc =fork();
    if(rc< 0){
        fprintf(atderr, "fork failed\n");
        exit(1);
    }
    else if(rc == 0) //child
    {
        char * myargs[3];

    }else // parent
    {
        int wc = wait(NULL);
        
    }

    return 0;

    
}
