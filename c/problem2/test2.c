#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#define SMOKERS 5

pthread_t smokers[SMOKERS],agent;
sem_t distributer,paper_match,tobacco_match,paper_tobacco,sem_queue;

//---------------------------------- Queue logic ------------------------//
struct node
{
  pthread_t id;
  struct node *link;
}*front,*rear;

void insert(pthread_t id)
{
  struct node *temp;
  temp=(struct node*)malloc(sizeof(struct node));
  temp->id=id;
  temp->link=NULL;
  if(rear ==NULL)
  {
    front=rear=temp;
  }
  else
  {
      rear->link=temp;
      rear=temp;
  }
}

void delete()
{
  struct node *temp;
   temp=front;
   if (front==NULL)
   {
     printf("queue is empty\n");
     front=rear=NULL;
   }
   else
   {
      printf("removed element is %lu\n",front->id);
      front=front->link;
      free(temp);
   }
}

void queue_size()
{
    struct node *temp;

    temp = front;
    int cnt = 0;
    if (front  ==  NULL)
    {
        printf(" queue empty \n");
    }
    while (temp)
    {
        printf("%lu  ", temp->id);
        temp = temp->link;
        cnt++;
    }
    printf("********* size of queue is %d ******** \n", cnt);
}
//---------------------------------------------Queue ends here-----------------

void* smoker(void* arg)
{
  pthread_t tid=pthread_self();
  int resource=*(int*)arg;
  sem_wait(&sem_queue);
  insert(tid);
  //printf("Front is %lu\t\n", tid);
  //printf("Smoker %lu is smoking  and resource is \t%d\n",tid,resource);
  sem_post(&sem_queue);
  //printf("Front is %lu resource %d\t\n", front->id,resource);
  //printf("Rear is %lu\t\n", rear->id);

  while (1)
  {
    int paper_match_value,paper_tobacco_value,tobacco_match_value;
    sem_getvalue(&paper_match,&paper_match_value);
    sem_getvalue(&tobacco_match,&tobacco_match_value);
    sem_getvalue(&paper_tobacco,&paper_tobacco_value);

      if(paper_match_value==1)
      {
        sem_wait(&paper_match);
        printf("paper_match available\n");
        sem_post(&distributer);
      }
      if(paper_tobacco_value==1)
      {
          sem_wait(&paper_tobacco);
          printf("paper_tobacco available\n");
          sem_post(&distributer);
      }
      if(tobacco_match_value==1)
      {
          sem_wait(&tobacco_match);
          printf("tobacco_match available\n");
          sem_post(&distributer);
      }
    }

  //insert(tid);
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
    //smoker_id[i];
    //pthread_create(&smokers[i],NULL,&smoker,&smoker_id[i]);
    pthread_create(&smokers[i],NULL,&smoker,&resource);
  }

  for(i=0;i<SMOKERS;i++)
    pthread_join(smokers[i],NULL);

  queue_size();
  return 0;
}
