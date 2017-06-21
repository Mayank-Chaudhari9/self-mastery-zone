#include <bits/stdc++.h>

using namespace std;

int CeilIndex(vector<int> &v,int l, int r, int key)
{

	/*int mid = l+(r-l)/2;

	if(v[mid]==key)
		return mid;

	if (v[mid]>key)
	{
		return CeilIndex(v, l, mid, key);
	}
	else
		return CeilIndex(v,mid,r, key);


	return mid;
	*/

	while (r-l > 1) {
    int m = l + (r-l)/2;
    if (v[m] >= key)
        r = m;
    else
        l = m;
    }
 
    return r;
}



int LongestIncreasingSubsequence(vector<int> &v)
{
	
	if(v.size()==0)
		return 0;

	std::vector<int> tail(v.size(),0);
	int length =1;

	tail[0] = v[0];

	for(size_t i=1;i<v.size(); i++)
	{
		if(v[i]<v[0])
			tail[0]=v[i];

		else if (v[i] > tail[length-1])
			tail[length++] = v[i];

		else
			tail[CeilIndex(tail, -1, length-1,v[i])] = v[i];
	}

	return length;


}





int main(int argc, char const *argv[])
{
	vector <int> v {2,5,3,7,11,8,10,13,6,20,3,40};
	cout << "length of longest increasing subsequence is " <<  LongestIncreasingSubsequence(v) << endl;
	//cout << "length of longest increasing subsequence is " << CeilIndex(v,7,9,6) << endl;
	return 0;
}