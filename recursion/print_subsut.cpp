#include <bits/stdc++.h>


using namespace std;

void dist_ele(int a[], int n, int curr, unordered_set<int> &s)
{

	if(curr > n)
		return;

	if (curr == 0)
	{
		
	}


}



void print_sub(int a[], int n)
{
	unordered_set<int> s;
	dist_ele(a,n,0,s);
}


int main(int argc, char const *argv[])
{

	int a[] = {1,2,3};

	int n = sizeof(a)/sizeof(a[0]);

	print_sub(a,n);

	return 0;
}