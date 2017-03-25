#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char * argv[])
{
    int* pidArr; // An array of process id's
    char str[256]; // A string that user types commands to the prompt
    char* stmtArr[256]; // An array of statements separated by ;
    char* strArr[256]; // An array of string separated by " "
    char* ptr; 
    int idx;
    int numOfStmt;
    int i;
    
    //interactive mode
    if(argc ==1){

        while(1){
            idx =0;
    
            printf("prompt> ");
            // user types commands
            fgets(str, sizeof(str), stdin);
            // change '\n' into '\0'
            str[strlen(str)-1] = '\0';
            // if input string is "quit" , shell shutdown
            if(!strcmp(str, "quit"))
            { 
                break;
            }
      
            //separate by ;
            ptr = strtok(str,";");
            while(ptr !=NULL)
            {
                stmtArr[idx++]= ptr;
                ptr = strtok(NULL, ";");
            
            }
            numOfStmt = idx;
            pidArr = (int*)malloc(sizeof(int)*numOfStmt);
    
            //fork numOfStmt times
            for(i=0; i<numOfStmt; i++)
            {
    
                pidArr[i] = fork();
                if(pidArr[i]<0)
                {
                    fprintf(stderr, "fork failed\n");
                    exit(1);
                }
                // child process
                else if(pidArr[i]==0)
                {
                    //separate string by " "
                    idx = 0;
                    ptr = strtok(stmtArr[i], " ");
            
                    while(ptr !=NULL)
                    {
                        strArr[idx++]= ptr;
                        ptr = strtok(NULL, " ");
                    
                    }
                    //function execvp needs NULL with last argument
                    strArr[idx] = NULL;
                    if(execvp(strArr[0], strArr)<0)
                    {
                        exit(1);
                    }
                }
    
            }
            // parent process
            for(i=0;i<numOfStmt;i++)
            {
                wait(NULL);
//                printf("pid ; %d, ppid : %d\n",pidArr[i],getpid());
            }
            free(pidArr);

        }
    }
    //batch mode
    else if(argc==2) 
    {
        FILE * fp = fopen(argv[1], "r");
        if(fp == NULL)
        {
            fprintf(stderr, "file open fail\n");
            exit(1);
        
        }

        //read batch file
        while(fgets(str, sizeof(str), fp))
        {
            idx =0;
            str[strlen(str)-1] = '\0';
            puts(str);
            
            //separate string by ;
            ptr = strtok(str,";");
            while(ptr !=NULL)
            {
                stmtArr[idx++]= ptr;
                ptr = strtok(NULL, ";");
            
            }
            numOfStmt = idx;
            pidArr = (int*)malloc(sizeof(int)*numOfStmt);
    
            //fork numOfStmt times
            for(i=0; i<numOfStmt; i++)
            {
    
                pidArr[i] = fork();
                if(pidArr[i]<0)
                {
                    fprintf(stderr, "fork failed\n");
                    exit(1);
                }
                //child process
                else if(pidArr[i]==0)
                {
                    //separate string by " "
                    idx = 0;
                    ptr = strtok(stmtArr[i], " ");
            
                    while(ptr !=NULL)
                    {
                        strArr[idx++]= ptr;
                        ptr = strtok(NULL, " ");
                    
                    }
                    //function execvp needs NULL with last argument
                    strArr[idx] = NULL;
                    if(execvp(strArr[0], strArr)<0)
                    {
                        exit(1);
                    }
                }
    
            }
            //parent process
            for(i=0 ; i<numOfStmt; i++)
            {
                wait(NULL);
  //              printf(" pid ; %d, ppid : %d\n",pidArr[i],getpid());
               
            }
            free(pidArr);
        }
        fclose(fp);
    }
    else //argv>2 , argument overflow
    {
        puts("./shell (no argument) : interactive mode");
        puts("./shell batchfile : batch mode");
    }
    return 0;

    
}

