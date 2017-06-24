#include <bits/stdc++.h>


using namespace std;

int findmaxsum(int a[])
{

	int in=0,ex=0;
	int n_ex;
	for(int i=0;i<6;i++)
	{
		n_ex =(in > ex)? in: ex;
		in = ex+a[i];
		ex = n_ex;
	}
	return ((in > ex)? in: ex);
}






int main(int argc, char const *argv[])
{
	/* code */
	int  a[6] ={5, 5, 10, 100, 10, 5};
	cout << findmaxsum(a)<<endl;;
	return 0;
}