#include <iostream>

using namespace std;

int tuna=69;

int main()
{
    int tuna = 20;
    cout << "printing local tuna : "<<tuna <<endl;
    cout << "printing global tuna : "<< :: tuna <<endl;
    return 0;
}

