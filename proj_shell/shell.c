#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char * argv[])
{
    int rc =fork();
    if(rc< 0){
        fprintf(stderr, "fork failed\n");
        exit(1);
    }
    else if(rc == 0) //child
    {
 //       char* str[20]={"ls","-al",NULL};
        
        char* str1[20]={"cd","..",NULL};
        char* str2[20]={"pwd",NULL};
 //       char * myargs;
        execvp(str1[0],str1);


    }else // parent
    {
        int wc = wait(NULL);
        printf("what\n");
    }

    return 0;

    
}
