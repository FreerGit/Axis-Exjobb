#include <stdlib.h>
#include <syslog.h>

void main(int argc, char *argv[]){
    openlog("fibbers", LOG_PID|LOG_CONS, LOG_USER);
    syslog(LOG_INFO, "fibb(40) = fdsafdsafdsfadsa");
    closelog();
    int status = system("./runner-wasmtime");
};