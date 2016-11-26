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
  sleep(2);
  struct node *new_front=front;
  while (1)
  {
    int paper_match_value,paper_tobacco_value,tobacco_match_value;
    sem_getvalue(&paper_match,&paper_match_value);
    sem_getvalue(&tobacco_match,&tobacco_match_value);
    sem_getvalue(&paper_tobacco,&paper_tobacco_value);
    //testting logic for condition with sem_value
    /*  if(paper_match_value==1)
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
      }*/
      ///------------------------------------------------------------


      while((front!=NULL)&&(pthread_equal(tid,new_front->id)))
      {
        sem_getvalue(&paper_match,&paper_match_value);
        sem_getvalue(&tobacco_match,&tobacco_match_value);
        sem_getvalue(&paper_tobacco,&paper_tobacco_value);


        printf("rear is %lu\n",rear->id );
        printf("new_front is %lu\n",new_front->id );
        pthread_t store_tid=new_front->id;
        if(pthread_equal(tid,new_front->id))
         {
           printf(" thread is %lu\n", new_front->id);
           printf("p_m : %d\t p_t : %d\t t_b : %d\t",paper_match_value,paper_tobacco_value,tobacco_match_value);
           printf("required resource %d\n", resource);
           if((resource==0) &&(paper_match_value==1) )
           {
             sem_wait(&paper_match);
             sem_post(&distributer);
             printf("resource paper_match_value granted to %lu\n",new_front->id);
             delete(new_front->id);
             sem_wait(&sem_queue);
             sleep(2);
             sem_post(&sem_queue);
             insert(store_tid);
             printf("controlis here\n");
           }
           if((resource==1) && (paper_tobacco_value==1))
           {
             sem_wait(&paper_tobacco);
             sem_post(&distributer);
             printf("resource paper_tobacco_value granted  to %lu\n",new_front->id);
             delete(new_front->id);
             sleep(2);
             sem_wait(&sem_queue);
             insert(store_tid);
             sem_post(&sem_queue);
             printf(" stored thread is %lu\n", store_tid);
           }
           if((resource==2)&&(tobacco_match_value==1))
           {
             sem_wait(&tobacco_match);
             sem_post(&distributer);
             printf("resource tobacco_match_value granted to %lu\n",new_front->id);
             delete(new_front->id);
             sleep(2);
             sem_wait(&sem_queue);
             insert(store_tid);
             sem_post(&sem_queue);
             printf(" stored thread is %lu\n", store_tid);
           }

         }


         //queue_size();

      }
      new_front=new_front->link;
          //sleep(1);
          queue_size();
    }

  //insert(tid);
}
