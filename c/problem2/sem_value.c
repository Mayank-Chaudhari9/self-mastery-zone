#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>


int main()
{
  int val;
  sem_t test;
  sem_init(&test,0,0);
  //sem_wait(&test);
  sem_post(&test);
  sem_post(&test);
  sem_getvalue(&test,&val);
  printf(" down value is %d\n",val);

  return 0;
}
