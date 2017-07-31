#include <stdio.h>

int main(int argc, char const *argv[])
{
	int a[1];
	a[0]=1;
	a[1]=2;
	a[2]=3;

	printf("%d\n",a[0] );
	printf("%d\n",a[1] );
	printf("%d\n",a[2] );

	return 0;
}