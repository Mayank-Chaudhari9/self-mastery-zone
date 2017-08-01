#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct emp
{
	int emp_id;
	int emp_len;
	char name[0];

}e;

int main(int argc, char const *argv[])
{
	/* code */

	struct emp *e1 = (struct emp*)malloc(sizeof(*e1) + sizeof(char)*128);

	e1->emp_id = 10;
	e1->emp_len = 20;
	//strncpy(e1->name, " MAYANAK", 20);
	strcpy(e1->name,"MAYANK");

	printf("%d\n",e1->emp_id);
	printf("%d\n",e1->emp_len );
	printf("%s\n",e1->name );


	return 0;
}