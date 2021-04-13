#include <stdlib.h>  /* qsort() */
// #include <stdint.h>
// #include <stdio.h>   /* printf() */

void quicksort(int* number,int first,int last){
   int i, j, pivot, temp;

   if(first<last){
      pivot=first;
      i=first;
      j=last;

      while(i<j){
         while(number[i]<=number[pivot]&&i<last)
            i++;
         while(number[j]>number[pivot])
            j--;
         if(i<j){
            temp=number[i];
            number[i]=number[j];
            number[j]=temp;
         }
      }

      temp=number[pivot];
      number[pivot]=number[j];
      number[j]=temp;
      quicksort(number,first,j-1);
      quicksort(number,j+1,last);

   }
}

int intcmp(const void *aa, const void *bb)
{
    const int *a = aa, *b = bb;
    return (*a < *b) ? -1 : (*a > *b);
}
int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int testSort(int* nums, int len)
{    
    // qsort(nums, len, sizeof(int), cmpfunc);
    quicksort(nums, 0, len-1);
    return len;
}
double factorial(double a) {
    if (a <= 1) return 1;
    return a * factorial (a-1);
}

int main() {
}
