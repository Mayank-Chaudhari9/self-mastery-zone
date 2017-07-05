# include <bits/stdc++.h>

using namespace std;


int main(int argc, char const *argv[])
{
	
	string s= "I am here";

	istringstream ss(s);
	string buf;
	while(ss)
	{
		ss >> buf;
		cout << buf << " ";
	}

	return 0;
}