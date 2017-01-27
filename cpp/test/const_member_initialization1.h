#ifndef CONST_MEMBER_INITIALIZATION1_H
#define CONST_MEMBER_INITIALIZATION1_H


class const_member_initialization1
{
    // constructor protype
    public:
        const_member_initialization1(int a, int b);
        void print();

    protected:
        int regular;
        const int constVar;
    private:
};

#endif // CONST_MEMBER_INITIALIZATION1_H
