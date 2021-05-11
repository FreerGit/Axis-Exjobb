#define DCACHE_SIZE 10000

long fibcache_values[DCACHE_SIZE] = {0};

long fibb(long n)
{
  if (n <= 0)
    return 0;
  if (n == 1)
    return 1;
  if (n < DCACHE_SIZE)
  {
    if (fibcache_values[n] != 0)
      return fibcache_values[n];
    else
      return fibcache_values[n] = fibb(n - 1) + fibb(n - 2);
  }
  else
  {
    return fibb(n - 1) + fibb(n - 2);
  }
}