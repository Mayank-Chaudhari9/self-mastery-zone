#include <iostream>

using namespace std;

class Enemy
{
    public:
        virtual void attack() // its just a template
        {

        }
};

class Ninja : public Enemy
{
    public:
        void attack()
        {
            cout << "Ninja attack " << endl;
        }
};

class Monster : public Enemy
{
    public:
        void attack()
        {
            cout << "Monster attack " << endl;
        }

};

int main()
{
    Ninja n;
    Monster m;

    Enemy * enemy1= &n; //both are of enemy typeso me can do
    Enemy * enemy2= &m;

    enemy1->attack();
    enemy2->attack();

    return 0;
}
