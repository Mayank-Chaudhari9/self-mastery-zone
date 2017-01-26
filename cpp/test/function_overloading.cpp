#include <iostream>

using namespace std;

void printNumber(int x)
{
    cout << " this function print integer : "<<x << endl;
}
void printNumber(float x)
{
    cout << " this function is printing float : " << x << endl;
}


int main()
{
    int a =54;
    float b= 32.678;

    printNumber(a);
    printNumber(b);

    return 0;
}
