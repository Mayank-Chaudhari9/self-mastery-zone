#include <stdio.h>

#include <stdlib.h>

int my_main();

void _start()
{
	int x =my_main();
	exit(x);
}


int my_main()
{
	printf("Hello without main \n");
	return 0;
}