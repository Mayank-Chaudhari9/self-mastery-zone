#include <iostream>
#include "deconstructor1.h"

using namespace std;

int main()
{
    deconstructor1 d1; // here constructor is called
    cout << " do something here before deconstructor is called"<< endl;

    //deconstructor will be called automatically here
    return 0;
}
