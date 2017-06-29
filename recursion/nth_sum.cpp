#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;


void nthsum(int k, int n, int &solutions,int current_sum, int current_no)
{
    if(current_sum==k)
    {
        solutions++;
        return;
    }
    for(int i=current_no;current_sum+pow(i,n) <=k;i++)
        nthsum(k,n,solutions,current_sum+pow(i,n),i+1);
   
}

int main() {
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */  
    int K, N;
    cin >> K >> N;
    int solutions=0;
    
    //cout << K << " " << N <<endl;
    
    nthsum(K, N, solutions, 0, 1);
    
    cout  << solutions;
        
    
    return 0;
}