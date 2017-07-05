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

	cout <<endl;

	string output;
	string s2= " comma, seperated, values";

	istringstream ss2(s2);
	while(getline(ss2, output,','))
		cout << output << " " <<  endl;

	return 0;
}