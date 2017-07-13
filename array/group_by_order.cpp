#include <bits/stdc++.h>

using namespace std;


void print_group(int a[], int s)
{
	map<int, int> m;

	for(int i=0; i<s; i++)
	{
		if(m.find(a[i])==m.end())
			m.insert(make_pair(a[i],1));
		else
			m[a[i]]++;


	}
	//unordered_map<int,int>::iterator i;
	for(auto i=0;i<s;i++)
	{
		auto temp =m.find(a[i]);
		if(temp!=m.end())
		{
			while(temp->second >0)
				temp->second--,cout << temp->first <<" ";
		}
	}
}


int main(int argc, char const *argv[])
{
	int a[] ={5,3,5,1,3,3};
	int size = sizeof(a)/sizeof(a[0]);

	print_group(a, size);


	return 0;
}