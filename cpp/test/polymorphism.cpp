#include <iostream>

using namespace std;

class Enemy
{
    protected :
        int attackPower;
    public:
        void setAttackPower(int a)
            {
                attackPower = a;
            }
};

class Ninja : public Enemy
{
    public:
        void attack()
        {
            cout << "I am ninja and my attackpower is %d : " << attackPower << endl;
        }
};

class Monster :public Enemy
{
    public:
        void attack()
        {
            cout << "I am monster and my attackpower is %d : " << attackPower << endl;
        }

};

int main()
{
    Ninja n;
    Monster m;
    Enemy *enemy1 = &n;
    Enemy *enemy2 = &m;

    enemy1->setAttackPower(10);
    enemy2->setAttackPower(20);

    n.attack();
    m.attack();
    return 0;
}
