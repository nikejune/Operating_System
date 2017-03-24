#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
int main(int argc, char * argv[])
{
    int rc =fork();
    int* rcArr;
    int* wcArr;
    if(rc< 0){
        fprintf(stderr, "fork failed\n");
        exit(1);
    }
    else if(rc == 0) //child
    {
        char str[50];
        char* ptr;
        char* stmtArr[50];
        char* strArr[50];
        int idx=0;
        int numOfStmt;
        int i;

        fgets(str, sizeof(str), stdin);
        str[strlen(str)-1] = NULL;
  
        ptr = strtok(str,";");
        while(ptr !=NULL)
        {
            stmtArr[idx++]= ptr;
            ptr = strtok(NULL, ";");
        
        }
        numOfStmt = idx;

        for(i=0; i<numOfStmt; i++)
        {
            rcArr = (int*)malloc(sizeof(int)*numOfStmt);
            wcArr = (int*)malloc(sizeof(int)*numOfStmt);

            rcArr[i] = fork();
            if(rcArr[i]<0)
            {
                fprintf(stderr, "fork failed\n");
                exit(1);
            }
            else if(rcArr[i]==0)
            {
                idx = 0;
                ptr = strtok(stmtArr[i], " ");
        
                while(ptr !=NULL)
                {
                    strArr[idx++]= ptr;
                    ptr = strtok(NULL, " ");
                
                }
                strArr[idx] = NULL;
                execvp(strArr[0], strArr);
            }
            else
            {
                wcArr[i] = wait(NULL);    
            }

        }
//        char* str1[20]={"cd","..",NULL};
//        char* str2[20]={"pwd",NULL};
//        execvp(str1[0],str1);
    }else // parent
    {
        int wc = wait(NULL);
        printf("what\n");
    }

    return 0;

    
}
