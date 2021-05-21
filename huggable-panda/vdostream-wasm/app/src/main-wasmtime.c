#include <stdlib.h>
#include <syslog.h>
#include <stdio.h>
#include <assert.h>

int FP_MAX = 10000;
int main(int argc, char *argv[])
{
    openlog("vdostream", LOG_PID | LOG_CONS, LOG_USER);
    FILE *fp;
    char path[FP_MAX];

    fp = popen("./runner-wasmtime", "r");
    assert(fp != NULL);

    // Read output of popen call, basically redirect printf from called function
    while (fgets(path, FP_MAX, fp) != NULL)
    {
        syslog(LOG_INFO, "%s", path);
    }
    closelog();
    fclose(fp);
    return 0;
};