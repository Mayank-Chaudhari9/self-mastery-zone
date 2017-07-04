#include <bits/stdc++.h>

using namespace std;

void bsort(int a[],int len)
{
	

	for(int i=0; i<len-1;i++)
	{

		for(int j=0; j<len-i-1;j++)
		{
			if(a[j]> a[j+1])
				swap(a[j],a[j+1]);
		}
	}

	//for(int i=0; i<len-1;i++)
	//	cout << a[i] << " ";

}
void printa(int a[], int len)
{
	for(int i=0; i<len-1;i++)
		cout << a[i] << " ";
}


int main(int argc, char const *argv[])
{
	/* code */
	int arr[] = {64, 34, 25, 12, 22, 11, 90};
	int len = sizeof(arr)/sizeof(arr[0]);
	bsort(arr,len);
	cout << " the sorted array is " << endl;
	printa( arr, len);
	cout << endl;
	return 0;
}