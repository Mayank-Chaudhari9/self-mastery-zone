#include <bits/stdc++.h>

using namespace std;

void print(int a[], int len)
{

	//nt len= sizeof(a)/sizeof(a[0]);
	unordered_map<int,int> m;
	int i;
	for(i=0; i<len; i++);
	{
		m[a[i]]++;

	}
	unordered_map<int, int> ::iterator it;

	for(it=m.begin();it!=m.end();++it)
	{
		cout << it->first <<" " <<it->second << endl;
	}

}





int main()
{
	int a[] = {5,2,3,2, 4, 5, 12, 2, 3, 3, 3, 12,4};
	int len =sizeof(a)/sizeof(a[0]);
	print(a, len);
	return 0;
}