#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;

void calculate(long a, long b)
{
    long result=a;
    float bc = b>>1;
    if((bc/a)>1)
        cout << (a & (b>>1)) <<endl;
    else
    {
       for(long i=a+1; i<=b;i++)
        {
            result = result & i;
        }
        cout << result <<endl;
    }
    //cout << (a & b) << endl;
}


int main() {
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */   
    
   int test;
    cin>>test;
   
   for(int i=0;i<test;i++)
   {
       long a, b;
       cin >>a >> b;
       
       //cout << a << " " <<b << endl;
       calculate(a,b);
        
   }
    
    
    return 0;
   }
