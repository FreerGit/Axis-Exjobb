#include <stdlib.h>  /* qsort() */
#include <stdio.h>   /* printf() */

int intcmp(const void *aa, const void *bb)
{
    const int *a = aa, *b = bb;
    return (*a < *b) ? -1 : (*a > *b);
}
int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

// extern void qsort(void *base, size_t nitems, size_t size, int (*compar)(const void *, const void*));
int testSort(int nums [], int len)
{
    int numsx[5] = {2,4,3,1,2};
    puts("fdsfsdfdsfsd");
    
    qsort(numsx, 5, sizeof(int), cmpfunc);
    for(int x=0; x < 5; x++){
        printf("%d, ", numsx[x]);
    }
    puts("done");
    return len;
}
double factorial(double a) {
    if (a <= 1) return 1;
    return a * factorial (a-1);
}

int main() {
}

// clang --target=wasm32-unknown-wasi --sysroot /tmp/wasi-libc -emit-llvm -c -S calc.c
// clang --target=wasm32-unknown-wasi --sysroot /tmp/wasi-libc -emit-llvm -c -S calc.c

// llc -march=wasm32 -filetype=obj calc.ll

// wasm-ld-10 --no-entry --export-all -o calc.wasm calc.o