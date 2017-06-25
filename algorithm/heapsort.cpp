# include <bits/stdc++.h>

using namespace std;



void heapify(int arr[],int i, int n)
{

	int largest= i;
	int l=2*i+1;
	int r=2*i+2;

	if(l < n && arr[l] > arr[largest])
		largest = l;

	if(r < n && arr[r] > arr[largest])
		largest = r;

	if(largest != i)
	{
		swap(arr[i], arr[largest]);

		heapify(arr, largest, n);
	}

}


void heapsort(int arr[], int n)
{

	for(int i=n/2 -1; i>=0;i-- )
		heapify(arr, i, n);

	for(int i=n-1;i>=0;i--)
	{
		swap(arr[0],arr[i]);

		heapify(arr,0,i);
	}
}





int main(int argc, char const *argv[])
{
	/* code */
	int arr[] = {1,4,2,6,5,7,8,12,3,9};
	/*for(int i=10/2 -1 ; i>=0; i--)
		heapify(arr, i,10);
		*/
	heapsort(arr, 10);	 

	for(int i=0;i<10;i++)
		cout << arr [i] <<" ";

	cout <<"\n";
	return 0;
}