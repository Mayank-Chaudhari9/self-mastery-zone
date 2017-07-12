#include <bits/stdc++.h>

using namespace std;

int _inversion(int arr[], int temp[], int l, int r);
int merge(int arr[], int temp[],int l, int m, int r); 

int inversion(int arr[], int len) 
{
	int temp[len];

	
	return _inversion(arr, temp,0,len-1);

}

int _inversion(int arr[], int temp[], int l, int r)
{
	int mid;

	int inversion_count =0;

	if(l<r)
	{
		mid = (l+r)/2;

		inversion_count = _inversion(arr, temp, l, mid);
		inversion_count += _inversion(arr, temp, mid+1, r);

		inversion_count += merge(arr, temp, l, mid+1, r);
	}
	return inversion_count;
}

int merge(int arr[], int temp[], int l, int mid, int r)
{
	int i,j,k;
	int inversion_count =0;
	i=l;
	j=mid;
	k=l;

	while(i<=(mid-1) && j<=r)
	{
		if(arr[i]<=arr[j])
			temp[k++] = arr[i++];
		else
		{
			temp[k++] = arr[j++];
			inversion_count = inversion_count + (mid-i);
		}
	}
	//return inversion_count;
	while(i<= (mid-1))
	{
		temp[k++] = arr[i++];
	}
	
	while(j<=r)
	{
		temp[k++] = arr[j++];
	}

	for(int i=0;i<=r;i++)
		arr[i]=temp[i];


	return inversion_count;



}



int main(int argc, char const *argv[])
{
	
	int arr[] = {1, 20, 6, 4, 5};
	int len =  sizeof(arr)/sizeof(arr[0]);
	cout << "inversions are " << inversion(arr,len)<< endl;;

	return 0;
}