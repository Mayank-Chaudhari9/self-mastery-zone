#include <bits/stdc++.h>


using namespace std;


int max(int a , int b){
	return (a>b)?a:b;
}

int rodcut_recursive(int price[], int n)
{
	if(n<=0)
		return 0;

	int max_cost = INT_MIN;

	for(int i=0;i<n; i++)
		max_cost = max(max_cost,price[i] + rodcut_recursive(price, n-i-1));

	return max_cost;

}


int rodcut_dp(int price[], int n)
{

	int val[n+1];
	val[0]=0;
	int i,j;

	for(i=1;i<=n;i++)
	{
		int max_val=INT_MIN;
		for(j=0;j<i;j++)
			max_val =max(max_val, price[j]+val[i-j-1]);
		val[i]=max_val;
	}
	return val[n];
}


int main(int argc, char const *argv[])
{
	/* code */
	int arr[] = {1,5,8,9,10,17,17,20};
	int size = sizeof(arr)/sizeof(int);

	cout << " maximun cost is " << rodcut_recursive(arr, size) << endl;
	cout << " maximun cost is " << rodcut_dp(arr, size) << endl;



	return 0;
}