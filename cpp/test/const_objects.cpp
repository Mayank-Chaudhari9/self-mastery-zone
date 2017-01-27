#include <iostream>
#include "Const1.h"

using namespace std;

int main()
{
    Const1 const1;
    const1.regularPrint();
    //calling a constant function
    const Const1 constobj;
    constobj.regularPrint2();
    return 0;
}
