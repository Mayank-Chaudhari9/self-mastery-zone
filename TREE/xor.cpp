
#include <iostream>
#include <bits/stdc++.h>
using namespace std;



int main()
{
    vector<int> N;
    int tests=0;
    cin >> tests;

    for(int i=0;i<tests;i++)
        cin >> N[i];

    /*
    for(int i=0;i<tests;i++)
        cout << N[i];
    */
    // calculate X for nth input
    int n_x=N[0];
    int D=0;
    for(int i=1;i<tests;i++)
        {
            int D= D^N[i];

        }
        cout << D;
    for(int i=0;i<tests;i++)
        {
            //int D= N[i];
            //for(int j=0;j<D;j++)
        }


    return 0;
}
