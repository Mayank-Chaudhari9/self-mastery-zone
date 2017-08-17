#include <stdio.h>
//#include <iostream>
//using namespace std;
int main(void)
{
    int *i;
    i=7;

    // below code gives seg fault
   	//printf("%d\n", *i); 

   	// below code gives 7 as ans

   	printf("%d\n",i);
   
    return 0;
} 