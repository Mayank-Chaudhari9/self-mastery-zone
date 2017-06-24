#include <bits/stdc++.h>



using namespace std;

stack <num> st;
stack <num> min_s;


void push(int num)
{
    if(st.empty())
    {
        st.push_back(num);
        min_s.push_back(num);
    }
    else
    {

        st.push_back(num);

        if (num <min_s.top())
            min_s.push_back(num);
        else
            min_s.push_back(min_s.top());

    }

}



int pop()
{


return top
}

int minimum()
{



return minimum;
}




int main()
{






    return 0;

}
