#ifndef OP1_H
#define OP1_H


class op1
{
    public:
        op1();
        int num;
        op1(int);
    // prtotype for + operator overloading.
        op1 operator+(op1);

    protected:

    private:
};

#endif // OP1_H
