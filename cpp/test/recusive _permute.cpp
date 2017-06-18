#include <bits/stdc++.h>

using namespace std;

void permute(string in, string out)
{
	if(in.size()==0)
		{
			cout << out <<endl;
		}
	for(int i=0;i<in.size();i++)
	{
		permute(in.substr(1), out + in[0]);
		rotate(in.begin(),in.begin()+1,in.end());
	}
}



int main()
{
	string s="ABC";
	permute(s,"");
	return 0;


}