#include <stdio.h>


int main(int argc, char const *argv[])
{
	char a[10];
	//gets(a);
	fgets(a,10,stdin);
	printf("%s\n",a );


	// carriage return test;

	printf("FOOO\bBAAR");
	printf("\n");
	printf("MAYANK \rCHAUDHARI\n");


	return 0;
}