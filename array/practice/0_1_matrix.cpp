#include <bits/stdc++.h>


using namespace std;





int main(int argc, char const *argv[])
{
	/* code */
	int r=3;
    int c=3;
	int a[r][c] = { {1, 0, 0, 1},
        {0, 0, 1, 0},
        {0, 0, 0, 0},
    };


    for(int i=0;i<r ;i++)
 		{
 			for (int j = 0; j < c; j++)
 			{
 				cout << a[i][j] << " ";
 			}
 			cout << endl;
 		}

   //----------------------------------------

 		for(int i=0;i<r ;i++)
 		{
 			for (int j = 0; j < c; j++)
 			{
 				if(a[i][j]==1)
 					{
 						a[0][j]=1;
 						a[i][0]=1;
 					}
 			}
 			
 		}
 		cout << endl;

 		for(int i=0;i<r ;i++)
 		{
 			for (int j = 0; j < c; j++)
 			{
 				cout << a[i][j] << " ";
 			}
 			cout << endl;
 		}



 		for(int i=r-1;i>=0 ;i--)
 		{
 			for (int j = c-1; j >=0; j--)
 			{
 				if(a[0][j]==1)
 					{
 						a[i][j]=1;
 						
 					}
 				if (a[i][0]==1)
 				{
 					a[i][j] =1;
 				}
 			}
 			
 		}
 		cout << endl;


 	//----------------------------------------

 	 for(int i=0;i<r ;i++)
 		{
 			for (int j = 0; j < c; j++)
 			{
 				cout << a[i][j] << " ";
 			}
 			cout << endl;
 		}

	return 0;
}