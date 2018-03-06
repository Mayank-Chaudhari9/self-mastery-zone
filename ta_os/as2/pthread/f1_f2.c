#include<stdio.h>
#include<string.h>
#include<pthread.h>
#include<stdlib.h>
#include<unistd.h>

pthread_t tid[2];
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;


void f1()
{
	pthread_mutex_lock( &mutex1 );
	for(int i=0;i<10;i++)
		printf("%d\t",i);
	printf("\n");
	pthread_mutex_unlock( &mutex1 );
}

void f2()
{
	pthread_mutex_lock( &mutex1 );
	for(int i=10;i<20;i++)
		printf("%d\t",i);
	printf("\n");
	pthread_mutex_unlock( &mutex1 );
}


void* doSomeThing(void *arg)
{
    unsigned long i = 0;
    
    pthread_t id = pthread_self();

    if(pthread_equal(id,tid[0]))
    {
        printf("\n First thread processing\n");
	f1();
	
    }
    else if(pthread_equal(id,tid[1]))
    {
        printf("\n Second thread processing\n");
	f2();
    }

    
   
    return NULL;
}

int main(void)
{
    int i = 0,j=0;
    int err;

    while(i < 2)
    {
        err = pthread_create(&(tid[i]), NULL, &doSomeThing, NULL);
        if (err != 0)
            printf("\ncan't create thread :[%s]", strerror(err));
        else
            printf("\n Thread created successfully\n");

        i++;
    }
    while(j<2)
	{
		pthread_join(tid[j],NULL);
		j++;	
	}
    
    return 0;
}
