#include <stdio.h>
#include <stdlib.h>
#include <pthread.c>
#include <semaphore.h>
#include <unistd.h>
#define SMOKERS 5

pthread_t smoker[SMOKERS];

void* smoker(void *arg)
{

}
void* agent(void *arg)
{

}


int main()
{
  int i;
  for(i=0;i<SMOKERS;i++;)
    pthread_create(&smoker[i],NULL,&smoker,NULL);

  return 0;
}
