#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
#include <string>
using namespace std;

void digit_sum(string initial_sum, int &ans)
{
    
    string ch;
    unsigned long long _sum=0;
    string ssum;
    if(initial_sum.length()==1)
    {
        ans =stoi(initial_sum)%10;
        return;
    }
    else
    {
        for(int i=0;i<initial_sum.length();i++)
        {
            ch=initial_sum[i];
            //cout <<stoi(ch) <<endl;
            _sum=stoi(ch)+_sum;

        }
        ssum = to_string(_sum);
        digit_sum(ssum, ans);
    }    
    
    
    
}

int main() {
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */   
    string n;
    int k;
   
    cin >> n >> k;
   
    int input_len= n.length();
    unsigned long long initial_sum=0;
    string ch,ssum;
    int ans=0;
    for(int i=0;i<input_len;i++)
    {
        ch=n[i];
        //cout <<stoi(ch) <<endl;
        initial_sum=stoi(ch)+initial_sum;
        
    }
    initial_sum=initial_sum*k;
    ssum=to_string(initial_sum);
    
    digit_sum(ssum, ans);
    
    
    //cout << n << " "<<k<< " "<< input_len << " "<<initial_sum<<endl;
    cout<< ans;
    
    
    return 0;
}