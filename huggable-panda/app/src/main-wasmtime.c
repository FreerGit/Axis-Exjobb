#include <stdlib.h>
#include <syslog.h>
#include <stdio.h>
#include <assert.h>

uint FP_MAX = 100;
int main(int argc, char *argv[]){
    char runner_name[] = "runner_wasmtime"; // placeholder
    openlog("fibbers", LOG_PID|LOG_CONS, LOG_USER);
    syslog(LOG_INFO, "main_wasmtime running......");
    syslog(LOG_INFO, "starting %s!", runner_name);
    FILE* fp;
    char path[FP_MAX];

    fp = popen("/mnt/flash/usr/local/packages/main_wasmtime/opt/app/runner-wasmtime", "r"); 
    assert(fp != NULL);
    
    // Read output of popen call, basically redirect printf from called function
    while(fgets(path, FP_MAX, fp) != NULL){
        syslog(LOG_INFO, "%s", path);
    }
    closelog();
    fclose(fp);
    return 0;
};