#include <bits/stdc++.h>

using namespace std;

bool comp(int i,int j)
{

  return j<i;
}


int main()

{
  int a[] ={1,4,2,89,4,56,34,12,23,90};
  vector<int>v (a,a+sizeof(a)/sizeof(int));
  //cout<<sizeof(a)/sizeof(int) << endl;
  sort(v.begin(),v.end()-5,comp);
  for(std::vector<int>::iterator it =v.begin();it!=v.end();++it)
    {
      cout <<' '<< *it;
    }


  return 0;
}
