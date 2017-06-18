#include <bits/stdc++.h>

using namespace std;

int main()
{
	char in[] = {'m','a','y','a','n','k'};
	vector<char>s (6);
	//vector<char> s (in, in+ sizeof(in)/sizeof(char));

	for(int i=0;i<s.size();i++)
		cout << s[i];

	cout << endl;

	//rotate(s.begin(),s.begin()+3,s.end());
	rotate_copy(in,in+3,in+6,s.begin());

	for(int i=0;i<s.size();i++)
		cout << s[i];

	cout << endl;

}