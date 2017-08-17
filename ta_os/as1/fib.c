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


  if(argc<=1 || argc>2)
  {
    printf("Enter correct no of arguement \n");
  }

  num = atoi(argv[1]);

  if(num < 0)
    printf("Invalid input \n");





  pid_t pid = fork();

  if(pid==0)
  {
    printf("Child is make the Fibonnaci\n", );
    while(num >0)
    {

    }
  }

  return 0;
}
