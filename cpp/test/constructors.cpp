#include <iostream>
#include <string>

using namespace std;

class Constructor_test
{
    public:
        Constructor_test(string z)
        {
            setName(z);

            cout<< "this is a constructor and printed automatically" <<endl; // it will called as soon as object is made
        }

        void setName(string x)
        {
            name =x;
        }

        string getName()
        {
            return name;
        }


    private:
        string name;


};


int main()
{
    //Constructor_test con_t; // calls constructor
    Constructor_test con_t("Mayank"); // using constructor to initialize value

    cout << con_t.getName() << endl;

    Constructor_test con_t2(" Chaudhari");
    cout << con_t2.getName() <<endl;
    return 0;
}
