#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

pthread_t tid[3];
sem_t mutex1,mutex2;

void* run(void *arg)
{
  /**
    # This function is common to three threads.
    # Synchronization is provided here with three semaphores to control the  execution of the threads.
    # exeution order -thread3->thread1->thread2
  */

  unsigned long i=0;
  pthread_t id =pthread_self();
  if(pthread_equal(id,tid[0]))
    {
      while(sem_wait(&mutex1));
        printf("First thread is running\n");
      sem_post(&mutex2);
    }
  if(pthread_equal(id,tid[1]))
  {
    while (sem_wait(&mutex2));
    {
        printf("Second thread is running\n");
    }

  }
  if(pthread_equal(id,tid[2]))
    {
      printf("Third thread is running\n");
      sem_post(&mutex1);
    }

  for (int i=0; i<100000; i++);


  return NULL;
}


int main(int argc, char const *argv[])
 {
   int i=0;
   int error;
   sem_init(&mutex1,0,0);
   sem_init(&mutex2,0,0);

   printf("mutex 2 is %d\n",mutex2 );

   printf("Thread sync using semaphore example\n");

   while (i<3)
   {
      error=pthread_create(&(tid[i]),NULL,&run,NULL);
      if(error!=0)
        printf("Thread creation failled\n");
      else
        printf("Thread creation successfull\n");

      i++;

  }

  sleep(2);
  return 0;
}
