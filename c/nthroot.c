#include <stdlib.h>
#include <stdio.h>
#include <math.h>


int power(int number, int nthpower)
{
	int product=number;
	while(nthpower>1)
	{
		product=product*number;
		nthpower--;
	}
	return product;
}

void checkpre()
{

}


void binarysearch(int min,int max,int number, int nthroot, int precision)
{
	int temp=(min+max)/2;
	
	if(power(temp,nthroot)>number)
	{
		printf("%d\n",temp);
		binarysearch(min,temp,number,nthroot,precision);
		
	}
	else if(power(temp,nthroot)<number)
	{
		printf("%d\n",temp);
		binarysearch(temp,max,number,nthroot,precision);
	}
	else 
		printf("root is :%d\n",temp );

}



int main(int argc, char const *argv[])
{
	/* code */
	if (argc<4)
		{
			printf("incomplete input\n");
			return 0;
		}

	int number 	  = atoi(argv[1]);
	int nthroot	  = atoi(argv[2]);
	int precision = atoi(argv[3]);

	binarysearch(0,number,number,nthroot,precision);



	return 0;
}
