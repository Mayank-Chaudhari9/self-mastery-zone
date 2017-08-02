#include <stdio.h>
#include <stdlib.h>


/*
int main()
{

	char *c;
	printf("%c\n",*c );
	printf("%d\n",c );
	printf("%d \n",&c );

	return 0;
}
*/

/* int main(int argc, char const *argv[])
{
	
	char s[] ="hello";
	char *ss =s;
	ss++;
	printf("%c\n", *ss);
	return 0;
}
*/
//#include <stdio.h>
/*
    void main()
    {
        int k = 5;
        int *p = &k;
        int **m  = &p;
        printf("%d%d%d\n", k, *p, **p);
    }
		
		// compile time error;
    */
void main()
    {
        int a[3] = {1, 2, 3};
        int *p = a;
        int *r = &p;
        printf("%d", (**r));
    }
