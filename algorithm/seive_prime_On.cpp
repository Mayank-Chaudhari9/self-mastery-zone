# include <bits/stdc++.h>


using namespace std;


 const long long MAX_SIZE = 1000001; 
vector<long long>is_prime(MAX_SIZE, true);

std::vector<long long> prime;

std::vector<long long>SPF(MAX_SIZE);


void generate_prime(int N)
{
	is_prime[0]=false,is_prime[1]=false;

	for(long long int i=2;i< N;i++)
	{
		if(is_prime[i])
		{
			prime.push_back(i); // add no to prime list

			SPF[i] = i; // prime is its own SPF
		}

		// remove multiples of covered  elements in the range of SPF
		for(long long int j=0; j< N && i*prime[j] < N && j <= SPF[j];j++)
		{
			is_prime[i*prime[j]] = false;
			SPF[i*prime[j]] = prime[j]; // updating SPF of that position to avoid calculations;
		} 
	}

}




int main(int argc, char const *argv[])
{
	/* code */
	int N =13;

	generate_prime(N);

	for(int i=0;i<prime.size() && prime[i] <= N;i++)
	{

		cout << prime[i] << " ";
	}



	return 0;
}