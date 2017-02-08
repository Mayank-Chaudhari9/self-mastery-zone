#include <iostream>
#include "op1.h"

using namespace std;


int main()
{
    op1 a(34); // to give no prop
    op1 b(16); // to give no prop
    op1 c;
    // now our overloaded operator waht it has to do;
    c=a+b;
    // it added the value of first object to the num value of second object

    cout << c.num << endl;
    return 0;
}
