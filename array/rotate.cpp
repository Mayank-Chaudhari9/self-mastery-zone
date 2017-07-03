# include <bits/stdc++.h>

using namespace std;



int gcd(int a, int b)
{
	if(b==0)
		return a;
	else
		return gcd(b,a%b);

}


void rotate(int a[], int d, int n)
{

	int i,temp,j,k;

	for(i=0	;i<gcd(d,n); i++)
	{	
		temp =a[i];
		j=i;
		while(1)
		{
			k=j+d;
			if(k>=n)
				k=k-n;
			if(k==i)
				break;
			a[j]=a[k];
			j=k;
		}
		a[j] = temp;
	}
}

void printArray(int a[], int len)
{
	for(int i=0; i< len;i++)
		cout << a[i]<< " ";
}


int main()
{
   int arr[] = {1, 2, 3, 4, 5, 6, 7};
   rotate(arr, 2, 7);
   printArray(arr, 7);
   //getchar();
   cout << endl;
   return 0;

	return 0;
}