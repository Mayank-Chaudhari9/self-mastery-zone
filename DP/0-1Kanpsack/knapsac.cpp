# include <bits/stdc++.h>

using namespace std;

int max(int a , int b)
{
	return (a>b)? a:b;
}


int recursive(int W, int wt[], int val[], int n)
{
	if(W==0 || n==0)
		return 0;

	if(W < wt[n-1])
		return recursive(W, wt, val,n-1);
	else
		return max(val[n-1]+recursive(W-wt[n-1],wt,val,n-1), recursive(W,wt, val,n-1) );
}





int main(int argc, char const *argv[])
{
	
	int val[]={60,100,120};
	int wt[] = {10,20,30};

	int W= 50;
	int n= sizeof(val)/sizeof(int);
	cout << recursive(W, wt, val, n);



	return 0;
} 