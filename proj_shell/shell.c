#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
int main(int argc, char * argv[])
{
    int* rcArr;
    int* wcArr;
    char str[50];
    char* ptr;
    char* stmtArr[50];
    char* strArr[50];
    int idx;
    int numOfStmt;
    int i;
    //interactive mode
    if(argc ==1){

        while(1){
            idx =0;
    
            printf("prompt> ");
            fgets(str, sizeof(str), stdin);
            str[strlen(str)-1] = '\0';
      
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
            rcArr = (int*)malloc(sizeof(int)*numOfStmt);
            wcArr = (int*)malloc(sizeof(int)*numOfStmt);
    
            for(i=0; i<numOfStmt; i++)
            {
    
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
                    break;
                }
                else
                {
                    wcArr[i] = wait(NULL);
                   printf("%dth fork dead, pid ; %d, ppid : %d\n", i+1,rcArr[i],getpid());

                }
    
            }
            free(rcArr);
            free(wcArr);

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
        while(fgets(str, sizeof(str), fp))
        {
            idx =0;
            str[strlen(str)-1] = '\0';
            puts(str);
            
            ptr = strtok(str,";");
            while(ptr !=NULL)
            {
                stmtArr[idx++]= ptr;
                ptr = strtok(NULL, ";");
            
            }
            numOfStmt = idx;
            rcArr = (int*)malloc(sizeof(int)*numOfStmt);
            wcArr = (int*)malloc(sizeof(int)*numOfStmt);
    
            for(i=0; i<numOfStmt; i++)
            {
    
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
                    break;
                }
                else
                {
                    wcArr[i] = wait(NULL);
                   printf("%dth fork dead, pid ; %d, ppid : %d\n", i+1,rcArr[i],getpid());
    
                }
    
            }
            free(rcArr);
            free(wcArr);
        }
    }
    return 0;

    
}
