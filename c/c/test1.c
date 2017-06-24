#include <stdio.h>


dosome(list)
int list[];
{
    int i;

    for (i = 0;i < 5; i++)
        printf("Before matrix[%d] = %d\n", i ,list[i]);

    for (i = 0; i < 20; i++)
        list[i] += 10;

    for (i = 0; i < 5; i++)
        printf("After matrix[%d] = %d\n", i, list[i]);
}



//void dosome(int array[]);
void main( )
{
    int index;
    int matrix[20];

    for (index = 0 ;index < 20; index++)
        matrix[index] = index + 1;

    for (index = 0; index < 5 ;index++)
        printf("Start matrix[%d] = %d\n", index, matrix[index]);

    dosome(matrix);

    for (index = 0; index < 5 ;index++)
        printf("Back matrix[%d] = %d\n", index, matrix[index]);
}


