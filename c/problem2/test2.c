#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#define SMOKERS 5

pthread_t smokers[SMOKERS],agent;
sem_t distributer,paper_match,tobacco_match,paper_tobacco,sem_queue,mutex;

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

void delete(pthread_t tid)
{
  struct node *temp;
   temp=front;
   if (front==NULL)
   {
     printf("queue is empty\n");
     front=rear=NULL;
   }
   if (front->id==tid)
    {
      printf("removed element is %lu\n",front->id);
      front=front->link;
      //free(front);
    }
   else
   {
     while((temp->link)!=NULL)
     {
       if(temp->link->id==tid)
          temp->link=temp->link->link;
        else
          temp=temp->link;

      }
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
  printf("resurce needed %d\n",resource);
  sem_post(&sem_queue);
  int a=0;
  sleep(2);
  struct node *front_copy=front;
  int paper_match_value,paper_tobacco_value,tobacco_match_value;
  while(a<5)
  {

    sem_wait(&mutex);
    if(pthread_equal(tid,front_copy->id))
    {
      sem_getvalue(&paper_match,&paper_match_value);
      sem_getvalue(&tobacco_match,&tobacco_match_value);
      sem_getvalue(&paper_tobacco,&paper_tobacco_value);
      pthread_t store_tid=front_copy->id;
      printf("front_copy data %lu\n",front_copy->id );
      printf("i am here \n");

        if((resource==0)&&(paper_match_value==1))
          {
            printf("resource paper_match_value accessed \n");
            sem_wait(&paper_match);
            sem_post(&distributer);
            printf("i am here\n");
            //sem_wait(&sem_queue);
            delete(front_copy->id);
            sleep(2);
            insert(store_tid);
            printf("i am here \n");
            //sem_post(&sem_queue);
            front_copy=front_copy->link;
            printf("i am here \n");
            continue;
          }
        else if ((resource==1)&&(paper_tobacco_value==1))
          {
            printf("resource paper_tobacco_value accessed\n");
            sem_wait(&paper_tobacco);
            sem_post(&distributer);
            //sem_wait(&sem_queue);
            delete(front_copy->id);
            sleep(2);
            insert(store_tid);
            printf("i am here \n");
            //sem_post(&sem_queue);
            front_copy=front_copy->link;
            printf("i am here \n");
            continue;
          }
        else if ((resource==2)&&(tobacco_match_value==1))
         {
           printf("resource tobacco_match_value accessed\n");
           sem_wait(&tobacco_match);
           sem_post(&distributer);
           //sem_wait(&sem_queue);
           delete(front_copy->id);
           sleep(2);
           insert(store_tid);
           printf("i am here \n");
           //sem_post(&sem_queue);
           front_copy=front_copy->link;
           printf("i am here \n");
           continue;
         }
         else
            {
              front_copy=front_copy->link;
              continue;
            }

        //front_copy=front_copy->link;
    }
    sem_post(&mutex);
    a++;
    //front_copy=front_copy->link;



  }



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
  sem_init(&mutex,0,1);


  pthread_create(&agent,NULL,&table,NULL);

  for(i=0;i<SMOKERS;i++)
  {
    resource=rand()%3;
    pthread_create(&smokers[i],NULL,&smoker,&resource);
  }

  for(i=0;i<SMOKERS;i++)
    pthread_join(smokers[i],NULL);

  queue_size();
  return 0;
}
