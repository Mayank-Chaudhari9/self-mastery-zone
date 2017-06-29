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


int dp(int W, int wt[], int val[], int n)
{
	int i,w;

	int k[n+1][W+1];

	for(i=0; i<=n; i++)
	{
		for(w=0; w<=W; w++)
			{

				if (i==0 || w==0)
					k[i][w]= 0;
				else if(wt[i-1] <= W)
					k[i][w] =max(val[i-1] + k[i-1][w-wt[i-1]], k[i-1][w]);
				else
					k[i][w] = k[i-1][w];
			}
	}

	return k[n][W];
}



int main(int argc, char const *argv[])
{
	
	int val[]={60,100,120};
	int wt[] = {10,20,30};

	int W= 50;
	int n= sizeof(val)/sizeof(int);
	cout << recursive(W, wt, val, n);
	cout << endl;
	cout << dp(W, wt, val,n);

	cout << endl;



	return 0;
} 