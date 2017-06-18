#include <bits/stdc++.h>

using namespace std;

int main()
{
	//char in[] = {'m','a','y','a','n','k'};
	char in[] = {'d','b','a'};
	//vector<char>s (6);
	vector<char> s (in, in+ sizeof(in)/sizeof(char));

	sort(s.begin(),s.end());
	for(int i=0;i<s.size();i++)
		cout << s[i];
	
	cout << endl;
	int count=1;
	cout<<count<< " --> " <<s[0]<<" "<<s[1]<<" "<<s[2]<<" "<<s[3]<<" "<<s[4]<<" "<<s[5]<<" "<<endl;
	while(next_permutation(s.begin(),s.end()))
		{
			count++;
			cout<<count<< " --> " <<s[0]<<" "<<s[1]<<" "<<s[2]<<" "<<s[3]<<" "<<s[4]<<" "<<s[5]<<" "<<endl;
			
		}
		cout<<count<< " --> " <<s[0]<<" "<<s[1]<<" "<<s[2]<<" "<<s[3]<<" "<<s[4]<<" "<<s[5]<<" "<<endl;

	cout << endl;

}