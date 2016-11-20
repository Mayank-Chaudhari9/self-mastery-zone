#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

pthread_t tid[3];
sem_t mutex1,mutex2;
sem_init(&mutex1,0,1);
sem_init(&mutex2,0,1);

void *counter(void *value)
{

}


int main(int argc, char const *argv[]) {
  printf("Thread sync using semaphore example\n");


  return 0;
}
