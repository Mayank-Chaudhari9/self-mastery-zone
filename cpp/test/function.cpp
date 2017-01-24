#include <iostream>

using namespace std;

void test(int a);

int main()
{
    int a ;
    cout<< "Enter a value to print \n";
    cin>>a;
    test(a);
    return 0;
}

void test(int a )
{
    cout<<"This is a function function that print a input value "<<a<<endl;
}
