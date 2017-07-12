#include <bits/stdc++.h>

using namespace std;

//Segregate even and odd nodes in a Linked List

//Given a Linked List of integers, write a function to modify the linked list such that all even numbers appear before all the odd numbers in the modified linked list. Also, keep the order of even and odd numbers same.


void print_l(list<int> l){
	//int i=0;
	list<int> :: iterator i;
	for(auto i=l.begin();i!=l.end();i++ )
		cout << *i <<" ";

	cout <<endl;
}

void revert(list<int> &l)
{
	reverse(l.begin(),l.end());


}

void method1(list<int> l)
{
	// create two lists and then join them and print;

	list<int> even;
	list<int> odd;

	for (auto i= l.begin(); i!= l.end();i++)
	{
		if(*i%2 ==0)
			even.push_back(*i);

		else
			odd.push_back(*i);		
	}
	//odd.merge(even);
	for (auto i= even.begin(); i!= even.end();i++)
	{
		cout << *i << " ";		
	}

	
	for (auto i= odd.begin(); i!= odd.end();i++)
	{
		cout << *i <<" ";	
	}

	cout << endl;
}



void method2(list<int> &l)
{
	revert(l);
	cout << sizeof(l)/sizeof(int);

	for (auto i=l.begin(); i!=l.end();i++)
	{
		if((*i)%2==1)
		{
			l.push_back(*i);
			//l.erase(i);
		}

	}
	cout << " called method 2 " ;
	print_l(l);

}

int main(int argc, char const *argv[])
{	
	list<int> l;

	l.push_back(11);
	l.push_back(10);
	l.push_back(8);
	l.push_back(6);
	l.push_back(4);
	l.push_back(2);
	l.push_back(0);
	l.push_back(5);

	cout << "normal list --> ";
	print_l(l);

	//revert(l);

	//cout << " reversed list --> ";
	//print_l(l);
	
	method1(l);
	cout << endl;
	method2(l);

	return 0;
}