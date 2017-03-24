#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
int main(int argc, char * argv[])
{
    //interactive mode
    if(argc ==1){
        int* rcArr;
        int* wcArr;
        int rc =fork();
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
            int idx;
            int numOfStmt;
            int i;

            while(1){
                idx =0;
        
                printf("prompt> ");
                fgets(str, sizeof(str), stdin);
                str[strlen(str)-1] = NULL;
          
                if(!strcmp(str, "quit"))
                { 
         //           printf("bye");
                    break;
                }
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
                       printf("%dth fork dead\n", i+1);

                    }
        
                }
            }
        }else // parent
        {
            int wc = wait(NULL);
 //          printf("endend\n");
        }
    }
    //batch mode
    else if(argc==2) 
    {
        FILE * fp = fopen(argv[1], "r");
        if(fp == NULL)
        {
            fprintf(stderr, "file open fail");
            exit(1);
        
        }




    }
    return 0;

    
}
