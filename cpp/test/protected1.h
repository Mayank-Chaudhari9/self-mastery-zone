#ifndef PROTECTED1_H
#define PROTECTED1_H


class protected1
{
    public:
        // inside this class and outside this class
        protected1();
        int publicvar;

    protected:
        // anything inside class has access to it
        //any friend has access to it
        // any class inheriting from it has access to it
        int protectedvar;

    private:
        // we can access inside this class only
        // we use public metthod to change private variables
        int privatevar;
};

#endif // PROTECTED1_H
