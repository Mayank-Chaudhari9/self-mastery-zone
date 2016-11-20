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
  sleep(2);
  return 0;
}
