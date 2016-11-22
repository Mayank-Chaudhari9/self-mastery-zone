#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

pthread_t agent,smoker1,smoker2,smoker3;
sem_t distributer,paper_match,tobacco_match,paper_tobacco;

void* smoker(void *arg)
{
  /**
    *## smoker code ##
    * smoker makes cigarette, passes the control back to agent
    * smoker smokes for 5 sec before contending again
  **/
  int i=0;
  pthread_t id =pthread_self();

  if(pthread_equal(id,smoker1))
  {
    while(1)
      {
        sem_wait(&paper_match);
        sem_post(&distributer);
        printf("Smoker1 is smoking \n" );
        sleep(5);
        printf("Smoker1 finished smoking\n");
      }
  }

  if(pthread_equal(id,smoker2))
  {
    while(1)
      {
        sem_wait(&paper_tobacco);
        sem_post(&distributer);
        printf("Smoker2 is smoking \n" );
        sleep(5);
        printf("Smoker2 finished smoking\n");
      }
  }

  if(pthread_equal(id,smoker3))
  {
    while(1)
      {
        sem_wait(&tobacco_match);
        sem_post(&distributer);
        printf("Smoker3 is smoking \n" );
        sleep(5);
        printf("Smoker3 finished smoking\n");
      }
  }
}


void* table(void *arg)
{
  /** ## Agent code ##
    * Agent randomly put two elements on table
      paper_match
      paper_tobacco
      tobacco_match
    * on the basis of request put by smoker and elements available he gets chance
    * The agent wait for very short time (neded for making a cigarette)
  **/
  int i=0;
  pthread_t id =pthread_self();

  if(pthread_equal(id,agent))
  {
    while(1)
      {
        sem_wait(&distributer);
        printf("Agent is distributing \n" );
        i=rand()%3;
        if(i==0)
          sem_post(&paper_match);
        if(i==1)
          sem_post(&paper_tobacco);
        if(i==2)
          sem_post(&tobacco_match);
      }
  }
}



int main(int argc, char const *argv[])
{
  int i=0;
  //Semaphore initialization
  sem_init(&distributer,0,1);
  sem_init(&paper_match,0,0);
  sem_init(&paper_tobacco,0,0);
  sem_init(&tobacco_match,0,0);

  //Thread creation for smoker and agent
  pthread_create(&agent,NULL,&table,NULL);
  pthread_create(&smoker1,NULL,&smoker,NULL);
  pthread_create(&smoker2,NULL,&smoker,NULL);
  pthread_create(&smoker3,NULL,&smoker,NULL);


  //printf("Waiting all for all threads to exit\n");
  // Wait for completion of threads
  pthread_join(smoker1,NULL);
  pthread_join(smoker2,NULL);
  pthread_join(smoker3,NULL);

  return 0;
}
