#include <bits/stdc++.h>

using namespace std;

int r_count(int a[], int size, int val)
{
	if(val==0)
		return 1;

	if(val <0)
		return 0;
	//cout << "call" <<" ";

	if(size <=0 && val>=1 )
		return 0;
	
	//cout <<r_count(a,size-1,val) + r_count(a,size, val-a[size-1]) << endl;
	return r_count(a,size-1,val) + r_count(a,size, val-a[size-1]);
}

int d_count(int a[], int size, int val, vector<int> &v)
{

	//cout << "here" << endl;
	if(val==0)
		return 1;

	if(val <0)
		return 0;

	if(size <=0 && val >=1)
		return 0;

	if(v[val])
		{
			cout << a[val] <<endl;
		
			return v[val];
		}
	else 
		{
			v[val] = d_count(a,size-1, val,v)+ d_count(a,size, val-a[size-1],v);
			//cout << "call" <<endl;
			}

	return v[val]; 

}




int main(int argc, char const *argv[])
{
	int a[] ={1,2,3};

	int s =sizeof(a)/sizeof(a[0]);
	int val =4;
	//cout << count(a,s,val);
	//cout<< endl;

	cout << r_count(a,s,val);
	cout << endl;

	vector<int> v;
	for(auto i=0;i<val+1;i++)
		v.push_back(0);



	///wrong
	cout << d_count(a,s,val,v);
	cout << endl;

	return 0;
}