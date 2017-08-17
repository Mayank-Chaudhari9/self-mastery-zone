#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>

static int value =5;

int main()
{
  pid_t pid;
  pid = fork();

  if(pid==0)
  {
    value +=15;
    //printf("%d\n",value );
  }
  else if(pid>0)
  {
    wait(NULL);
    printf("Parent : value =%d\n",value );
    exit(0);
  }

return 0;
}
