#include "const_member_initialization1.h"
#include <iostream>

using namespace std;
// constant member variable initialization using constructor
const_member_initialization1::const_member_initialization1(int a, int b)
:regular(a),
constVar(b)
{
    //ctor
}

void const_member_initialization1::print()
{
    cout<<"value of regular variable is: "<<regular<<endl;
    cout<<"value of constant variable is: "<<constVar<<endl;
}
