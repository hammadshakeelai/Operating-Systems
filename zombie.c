#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
int main() {
    pid_t pid = fork();

    if (pid < 0) 
    {
        printf("fork");
        return 1;
    }
    else if (pid == 0)
    {
        printf("[child ] PID=%d, PPID=%d -> exiting now\n", getpid(), getppid());
        _exit(0);  // or exit(0);
    } 
    else {
        printf("[parent] PID=%d, child PID=%d -> sleeping so child becomes zombie\n", getpid(), pid);
        wait(NULL);
        printf("[parent] sleeping... %d\n", i);
        sleep(1);
        printf("[parent] done sleeping, now exiting (zombie will be reaped by init)\n");
    }
    return 0;
}
