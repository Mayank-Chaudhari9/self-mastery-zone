# include <bits/stdc++.h>



using namespace std;


bool is_k(int a[],int size, int k)
{
	map<int,int> m;

	//m.insert(a[0]);
	for(int i=0; i< size; i++)
	{
		if(m.find(a[i])!=m.end())
			return true;

		m.insert(make_pair(i,a[i]));

		if(i>=k)
			m.erase(a[i]);
	}

	return false;
}



int main()
{
	int a[] ={10,5,3,4,10,5,6};
	int k=3;
	int size = sizeof(a)/sizeof(a[0]);
	if(is_k(a,size,k))
		cout << " yes" << endl;
	else
		cout << " NO " << endl;

	return 0;
}