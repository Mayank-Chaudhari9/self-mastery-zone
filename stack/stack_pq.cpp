#include <bits/stdc++.h>

using namespace std;

typedef pair<int,int> p;

class Stack
{
	int pr;
	priority_queue<pair<int,int>>pq;
public:
	Stack()
	{
		pr= 0;
	}
	void push(int x);
	bool isEmpty();
	int top();
	void pop();


	//~Stack();
	
};


void Stack::push(int x)
{
	pr++;
	pq.push(p(pr,x));
}

void Stack::pop()
{
	if(pq.empty())
	{
		cout << " stack underflow"<<endl;
	}
	pr--;
	pq.pop();
}

int Stack::top()
{
	p temp = pq.top();
	return temp.second;
}

bool Stack::isEmpty()
{
	return pq.empty();
}

int main(int argc, char const *argv[])
{
	Stack s ;//= new Stack();

	s.push(10);
	s.push(20);

	while(!s.isEmpty()){
        cout<<s.top()<<endl;
        s.pop();
    }

	return 0;
}