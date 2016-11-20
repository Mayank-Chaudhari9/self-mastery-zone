#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

pthread_t tid[3];

void* run(void *arg)
{
  unsigned long i=0;
  pthread_t id =pthread_self();
  if(pthread_equal(id,tid[0]))
    {
      printf("First thread is running\n");
    }
  else if(pthread_equal(id,tid[1]))
  {
    printf("Second thread is running\n");
  }
  else
    printf("Third thread is running\n");

  for (int i=0; i<100000; i++);


  return NULL;
}

int main(int argc, char const *argv[]) {

  int i=0;
  int error;
  while (i<3)
  {
    error=pthread_create(&(tid[i]),NULL,&run,NULL);
    if(error!=0)
      printf("Thread creation failled\n");
    else
      printf("Thread creation successfull\n");

    i++;

  }
  /**
   Wait till all threads are complete before main thread  continues. Else there isa risk of running a exit before completion of all Thread. We can do it by joining threads or wait forsome time using sleep (not a good way)
  */
  pthread_join(tid[0],NULL);
  pthread_join(tid[1],NULL);
  pthread_join(tid[2],NULL);
  //sleep(2);
  return 0;
}
