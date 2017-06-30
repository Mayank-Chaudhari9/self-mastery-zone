# include <bits/stdc++.h>

using namespace std;


int partition(int a[], int l , int h)
{

	int pivot = a[h];

	int i= l-1;

	for(int j=l;j<=h-1;j++)
	{
		if(a[j]<=pivot)
		{
			i++;
			swap(a[i],a[j]);
		}
	}

	swap(a[i+1],a[h]);
	return i+1;
}


void  quicksort(int a[], int l, int h)
{

	if(l<h)
	{
		int p = partition(a, l, h);
		quicksort(a, l,p-1);
		quicksort(a, p+1,h);
	}
}



int main(int argc, char const *argv[])
{
	int a[]={10,80,30,90,40,50,70};
	quicksort(a,0,6);

	for (int i = 0; i <7; ++i)
	{
		cout << a[i] << " ";
	}

	return 0;
}
