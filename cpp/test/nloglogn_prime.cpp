# include <bits/stdc++.h>

using namespace std;


void printPrime(int n)
{
	bool prime[n+1];
	int t=n;

	memset(prime, true, sizeof(prime));

	for(int p=2;p*p <=n;p++)
	{
		if(prime[p]==true)
		{
			for(int i=p*2;p<=n;i=i+p)
				prime[i]=false;
		}
	}
	//cout << prime[4];
	//int i=2;
	for(int p=2;p<t;p++)
		{
			if(prime[p])
			cout << p << " ";
	}
	cout<< endl;
}




int main(int argc, char const *argv[])
{
	/* code */
	int N = 30 ;

	cout << "printing prime in range 30" << endl;
	printPrime(30) ;


	return 0;
}