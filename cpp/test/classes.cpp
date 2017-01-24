#include <iostream>
using namespace std;

class TestClass{
    public: // access specifier
        void print()
            {
                    cout << "this is a class function"<<endl;
            }

};

int main()
{
    TestClass tc;
    tc.print();
    return 0;
}
