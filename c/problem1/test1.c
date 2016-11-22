#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

pthread_t agent,smoker1,smoker2,smoker3;
sem_t distributer,paper_match,tobacco_match,paper_tobacco;

void* smoker(void *arg)
{
  int i=0;
  pthread_t id =pthread_self();

  if(pthread_equal(id,smoker1))
  {
    while(i<3)
      {
        printf("Smoker1 is smoking \n" );
        i++;
      }
  }

  if(pthread_equal(id,smoker2))
  {
    while(i<3)
      {
        printf("Smoker2 is smoking \n" );
        i++;
      }
  }

  if(pthread_equal(id,smoker3))
  {
    while(i<3)
      {
        printf("Smoker3 is smoking \n" );
        i++;
      }
  }
}


void* table(void *arg)
{
  int i=0;
  pthread_t id =pthread_self();

  if(pthread_equal(id,agent))
  {
    while(i<3)
      {
        printf("Agent is distributing \n" );
        i++;
      }
  }
}



int main(int argc, char const *argv[])
{
  int i=0;
  sem_init(&distributer,0,1);
  sem_init(&paper_match,0,0);
  sem_init(&paper_tobacco,0,0);
  sem_init(&tobacco_match,0,0);

  while (i<10)
  {
    printf("%d\n",rand()%3);i++;
  }
  pthread_create(&agent,NULL,&table,NULL);
  pthread_create(&smoker1,NULL,&smoker,NULL);
  pthread_create(&smoker2,NULL,&smoker,NULL);
  pthread_create(&smoker3,NULL,&smoker,NULL);


  printf("Waiting all for all threads to exit\n");

  pthread_join(smoker1,NULL);
  pthread_join(smoker2,NULL);
  pthread_join(smoker3,NULL);

  return 0;
}
