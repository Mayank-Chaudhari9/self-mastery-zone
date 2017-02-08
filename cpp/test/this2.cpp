#include "this2.h"
#include <iostream>

using namespace std;

this2::this2(int num)
: h(num)
{

}

void this2::printCrap()
{
    cout <<"h = " <<h << endl;
    cout << "this->h = " << this->h << endl;
    cout << "(*this).h = " <<(*this).h << endl;

}
