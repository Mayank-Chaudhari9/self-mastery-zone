#include <stdio.h>

void print(int *arr)
{
  for(int i=0;i<4;i++)
    {
      for(int j=0;j<4;j++)
      {
        printf("%d",*((arr+i*4)+j));
      }
      printf("\n");
    }
}



int main(int argc, char const *argv[]) {

  int arr[4][4];

  for(int i=0;i<4;i++)
    for(int j=0;j<4;j++)
      arr[i][j]=i*j;

      for(int i=0;i<4;i++)
        {
          for(int j=0;j<4;j++)
          {
            printf("%d",arr[i][j]=i*j);
          }
          printf("\n");
        }
        printf("\n");
  print(arr);
printf("\n");

  return 0;
}
