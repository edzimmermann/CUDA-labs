#include <stdio.h>

void firstParallel()
{
  printf("This is running in parallel.\n");
}

int main()
{
  firstParallel<<<5, 5>>>();
  cudaDeviceSynchronize();
}
