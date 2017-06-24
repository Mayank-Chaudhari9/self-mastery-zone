#include <bits/stdc++.h>


int lookup[1000];
using namespace std;


int fibonacci(int n)
{
	if(n<=1)
		lookup[n]=n;
	else
		lookup[n]= fibonacci(n-1)+fibonacci(n-2);

	return lookup[n];

}



int main()
{
	//std::vector<int> fib;

	int n=9;
	cout <<fibonacci(n);


	return 0;
}