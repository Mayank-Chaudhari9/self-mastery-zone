#include <bits/stdc++.h>


using namespace std;


void permute(string s, int l, int r)
{
	if(l==r)
		cout << s << endl;

	for(int i =l; i<=r; i++)
	{
		swap(s[l],s[i]);
		permute(s, l+1, r);
		swap(s[l],s[i]);
	}	
}

// it does not consider repeated chars;


int main(int argc, char const *argv[])
{
	string str ="mayank";
	int n= str.length();
	permute(str,0,n-1);

	return 0;
}