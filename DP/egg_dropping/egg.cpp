# include <bits/stdc++.h>


using namespace std;

int max(int a, int b){return (a>b)? a:b;}


int recursive(int n, int k )
{

	if(k==0 || k==1)
	{
		return k;
	}

	if(n==1)
		return k;


	int min=  INT_MAX, res;

	for(int x=1;x<=k;x++)
	{
		res = max(recursive(n-1,x-1),recursive(n,k-x));

		if(res < min)
			min = res;
	}

	return min+1;

}


int dp()
{

	return 0;
}




int main(int argc, char const *argv[])
{

	int n=2;
	int k=10;

	cout << recursive(n,k) <<endl;

	return 0;
}