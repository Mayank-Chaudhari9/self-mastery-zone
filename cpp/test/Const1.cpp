#include "Const1.h"
#include <iostream>

using namespace std;
Const1::Const1()
{
    //ctor
}

// a normalfunction
void Const1 :: regularPrint()
{
    cout << "this is a regular function" << endl;
}

// defining a constant function
void Const1::regularPrint2() const{
    cout<< "I am a const function"<<endl;
}
