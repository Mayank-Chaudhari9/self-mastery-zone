#include "const_member_initialization1.h"
#include <iostream>

using namespace std;

int main()
{
    // calling constructor with(regular, constVariable)
    const_member_initialization1 cmi(30,15);
    cmi.print();

    return 0;

}
