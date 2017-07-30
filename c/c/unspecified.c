#include <stdio.h>

int f()
{
	printf("Inside F()\n");
	return 3;
}

int g()
{


	// hello tingoo
	printf("Inside G()\n");
	return 4;
}


int sum(int i, int j)
{
	return i+j;
}


int main()
{
	return sum(f(),g());
}