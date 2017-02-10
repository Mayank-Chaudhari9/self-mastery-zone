#include "op1.h"
#include <iostream>

using namespace std;

op1::op1()
{
    //ctor
}

op1::op1(int a )
{
    num = a;
}

// return a new object of type op1
// new definition for overloaded operator
op1 op1::operator+(op1 op)
{
    op1 newop;
    newop.num = num + op.num;
    return (newop);
}
