# include <bits/stdc++.h>

#define R 3
#define C 6

using namespace std;


void spiralPrint(int row, int col, int a[R][C])
{

	int i=0;
	int j=0;
	
	int l=0;
	int k=0;

	int itr;
	while(i<row && l<col)
	{

		for(itr =i ;itr <col ;itr++)
			cout << a[i][itr] <<" ";

		//cout << "count" <<endl;
		i++;

		for(itr =i; itr < row;itr++)
			cout << a[itr][col-1];

		col--;

		for (itr = col-1; itr >= k; itr++)
		{
			cout << a[row-1][itr] << " ";
		}

	}


}





int main(int argc, char const *argv[])
{

	//int row= 3;
 	//i//nt col =6;
	int a[R][C] = {{1,2,3,4,5,6},{7,8,9,10,11,12},{13,14,15,16,17,18}};

	spiralPrint(R, C,a);
	return 0;
}



