#include <bits/stdc++.h>

using namespace std;

auto cmp=[](pair<a, pair<b,c>>&x,pair<a, pair<b,c>>&y)
{
	return x.second.first> y.second.first;
}

void print(int a[], int len)
{

	//nt len= sizeof(a)/sizeof(a[0]);
	map<int,pair<int,int>> m;
	//int i;

	for(int i=0; i<len; i++)
	{
		int x=a[i];
		//cout << a[i] << endl;
		
		if(m.find(x)==m.end())
		{
			m[x].first=i;
			m[x].second++;
		}
		else
			m[x].second++;



	}

	sort(m.begin(),m.end(),cmp);

	map<int,pair<int,int>> ::iterator it;

	for(it=m.begin();it!=m.end();++it)
	{
		cout << it->first <<" " <<it->second.first<< " "<< it->second.second<<endl;
	}

}





int main()
{
	int a[]= {2,3,2,4,6,7,8,3,5,6,9,4,6,2,5,6};
	int len = sizeof(a)/sizeof(int);
	print(a, len);
	return 0;
}