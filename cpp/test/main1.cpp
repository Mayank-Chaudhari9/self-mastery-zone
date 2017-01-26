#include <iostream>
#include "Test.h"

using namespace std;

int main()
{
    // claaing function using object
    Test t1;
    cout << " Class member function called using object " << endl;
    t1.print();
    // calling function using pointer
    Test *t2;
    cout << "Class member funtion called using pointer "<< endl;
    t2->print();
    return 0;
}
