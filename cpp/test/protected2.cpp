#include <iostream>
#include "protected1.h"
#include "protected2.h"

using namespace std;
protected2::protected2()
{
    //ctor
}

void protected2::doSomething()
{
    publicvar = 10;
    protectedvar = 20;
    //privatevar =30; // uncommenting this will generate context error
    cout << " Public variable is " << publicvar <<endl;
    //cout << "Private variable is " << p2.privatevar <<endl;
    cout << "protected variable is "<< protectedvar << endl;

}
