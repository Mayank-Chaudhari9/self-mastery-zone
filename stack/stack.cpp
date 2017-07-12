# include <bits/stdc++.h>

#define MAX 5
using namespace std;


class Stack
{
	int top;

public:
	int a[MAX];
	Stack()
	{
		top =-1;
	}
	bool push(int x);
	int pop();
	bool isEmpty();

};


bool Stack::push(int x)
{
	if(top >= MAX)
		{
			cout << " Stack overflow" << endl;
			return false;
		}
	else
	{
		a[++top]= x;
		return true;
	}

}

int Stack::pop()
{
	if (top <0)
	{
		cout << " stack underflow "<<endl;
		return 0;
	}
	else
	{
		//int x= a[top--];
		return a[top--];
		//return x;
	}
}

bool Stack::isEmpty()
{
	if (top<0)
	{
		return true;
	}
	else
		false;
}

int main(int argc, char const *argv[])
{
	Stack s;
	s.push(10);
	s.push(20);
	s.push(30);
	s.push(40);
	s.push(50);
	//s.push(60);
	cout << s.pop() << endl;
	cout << s.pop() << endl;
	cout << s.pop() << endl;
	cout << s.pop() << endl;
	cout << s.pop() << endl;
	cout << s.pop() << endl;
	cout << s.pop() << endl;
	return 0;
}