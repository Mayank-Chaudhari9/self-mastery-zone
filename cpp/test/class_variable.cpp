#include <iostream>
# include <string>

using namespace std;

class C_variable
{
    private:
        string name;

    public:
        void setName(string x) // setter function (public)
        {
            name=x;
        }

        string getName() // getter function (public)
        {
            return name;
        }


};

int main()
{
    C_variable cv;
    cv.setName("mayank");
    //cv.name="Mayank";  //--> will give context error due to private variable
    cout<<cv.getName();
    return 0;
}
