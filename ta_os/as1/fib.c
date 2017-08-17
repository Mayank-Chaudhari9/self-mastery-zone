#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


int main(int argc, char* argv[])
{
  //printf("%d\n",atoi(argv[1]));
  int a=0;
  int b=1;
  int n=a+b;
  int num;

 // check for valid no of arguements
  if(argc<=1 || argc>2)
  {
    printf("Enter correct no of arguement \n");
  }

//check for valid input
  num = atoi(argv[1]);
  if(num < 0)
    printf("Invalid input \n");


//Fibonnaci no using child
  pid_t pid = fork();

  if(pid==0)
  {
    printf("Child process calculating Fibonnaci\n");
    while(num >0)
    {
      n=a+b;
      printf("%d\n",n);
      a=b;
      b=n;
      num--;
      if (num==0)
      {
        printf("Child processing exiting\n");
      }
    }
  }

  else
  {
    printf("Parent is waiting for child to complete\n");
    waitpid(pid,NULL,0);
    printf("Parent exiting \n");
  }


  return 0;
}
