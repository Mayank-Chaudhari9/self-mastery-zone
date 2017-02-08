#include <iostream>

using namespace std;

class friend1
{

    public:
        friend1(){ int myvar = 0;}
    private:
        int myvar;
    //prototype of friend function
    friend void myfriend (friend1 &f);
};
//friend funvtion definition
void myfriend(friend1 &f)
{
    f.myvar = 99;
    cout << f.myvar << endl;
}


int main()
{
    friend1 f2;
    myfriend(f2);

    return 0;
}
