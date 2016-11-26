#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#define SMOKERS 5

pthread_t waiting_area[SMOKERS];
static int counter=0;

pthread_t smokers[SMOKERS],agent;
sem_t distributer,paper_match,tobacco_match,paper_tobacco,sem_queue;

//---------------------------------- Queue logic ------------------------//

void insert(pthread_t tid)
{

   waiting_area[counter]=tid;
   counter++;
   printf("counter %d\n", counter);


  printf("storing %lu\n",tid);

}

void delete(pthread_t tid)
{

}
void show_smokers()
{
  int idx=0;
  for(idx=0;idx<SMOKERS;idx++)
  {
    printf("smokers %lu\n",waiting_area[idx]);
  }

}
//---------------------------------------------Queue ends here-----------------

void* smoker(void* arg)
{
  pthread_t tid=pthread_self();

  int resource=*(int*)arg;

// logic for putting threads in queue
  sem_wait(&sem_queue);
    insert(tid);
    printf("thread %lu is here \n",tid );
  sem_post(&sem_queue);
//  --------------------------------------------
}



void* table(void *arg)
{
  int i=0;
  pthread_t id =pthread_self();

  if(pthread_equal(id,agent))
  {
    while(1)
      {
        sem_wait(&distributer);
        printf("Agent is distributing \n" );
        i=rand()%3;
        printf("semaphore no %d\n",i );
        if(i==0)
          sem_post(&paper_match);
        if(i==1)
          sem_post(&paper_tobacco);
        if(i==2)
          sem_post(&tobacco_match);
      }
  }
}


int main()
{
  int i=0,smoker_id[SMOKERS],resource;

  sem_init(&distributer,0,1);
  sem_init(&paper_match,0,0);
  sem_init(&paper_tobacco,0,0);
  sem_init(&tobacco_match,0,0);
  sem_init(&sem_queue,0,1);


  pthread_create(&agent,NULL,&table,NULL);

  for(i=0;i<SMOKERS;i++)
  {
    resource=rand()%3;
    pthread_create(&smokers[i],NULL,&smoker,&resource);
  }
  for(i=0;i<SMOKERS;i++)
    waiting_area[i]=0;

  for(i=0;i<SMOKERS;i++)
    pthread_join(smokers[i],NULL);

  show_smokers();
  sleep(2);
  return 0;
}
