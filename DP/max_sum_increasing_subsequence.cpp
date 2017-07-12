#include <bits/stdc++.h>


using namespace std;



int max_sum(int arr[],int n)
{
	int sum[n];

	for(int i=0; i<n; i++)
		sum[i]= arr[i];

	int maxs=0;

	if(n==0)
		return 0;
	for(int i=1;i<n; i++)
	{
		for (int j=0; j<i; j++)
			if(arr[i]> arr[j] && sum[i] < sum[j]+arr[i])
				sum[i]= sum[j]+arr[i];
	}

	for (int i = 0; i < n; i++)
	{
		 if (maxs<sum[i])
		 {
		 	maxs=sum[i];
		 }
	}
	return maxs;
}


int main(int argc, char const *argv[])
{
		
	int arr[] = {1, 101, 2, 3, 100, 4, 5};
    int n = sizeof(arr)/sizeof(arr[0]);
    printf("Sum of maximum sum increasing subsequence is %d\n",max_sum( arr, n ) );
    return 0;

}