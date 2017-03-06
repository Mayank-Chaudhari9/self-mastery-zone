#include <iostream>
#include <list>

int main()
{
	// creating an empty list
	std::list<int> l;


	// list with initialization
	std::list<int> l1{1,2,3,4,5};

	
	std::list<int> l2 ;

	/* member functions
		-> insert(iterator, element) : insert elemrnt in the list before position pointed by the itertor
		-> insert(iterator, count , element) : insert count no of element before iterator 
		-> insert(iterator, start_itertor, end_iterator) : insert elemrnt pointed by start_iterator tothe element pointed by end_iterator before the position pointed by iterator
	*/

	std::list<int>::iterator it = l1.begin();

	std::cout <<"value of l1 before insertion : " << std::endl;
	
	/* this does not workin list
		list do not have at()  ??????
		for(int i=0; i<l1.size(); i++)
			std::cout << l1.at(i) << " ";
	*/
	// use iterators
	std::cout << "print using iterator " <<std::endl;
	for(std::list<int>::iterator i = l1.begin(); i!=l1.end(); ++i)
		std::cout << *i << " ";		
	std::cout <<std::endl;

	std::cout<< "print using foreach loop " <<std::endl;
	// or other method is to use foreach loop
	for(auto v : l1)
		std::cout<< v << " ";
	std::cout << std::endl;

	// insert 100 at 2nd position in l1
	l1.insert(++(l1.begin()), 100);

	for(std::list<int>::iterator i = l1.begin(); i!=l1.end(); ++i)
		std::cout << *i <<" ";
	std::cout<< std::endl;

	// inserting elements in l2 from beginning of l1 to end of l1
	l2.insert(l2.begin(), l1.begin(), l1.end());
	std::cout << "printing new values of l2 " << std::endl;
	for( auto v : l2)
		std::cout<< v << " ";
	std::cout<<std::endl;

	std::cout<< "inserting values in l2 at the beginning " <<std::endl;
	// inserting 5 times 10 in the starting of the list
	l2.insert(l2.begin(), 5 , 10);
	for (std::list<int>::iterator i =l2.begin(); i!=l2.end(); ++i)
		std::cout<< *i << " ";
	std::cout << std::endl;

	/**
	 	push_back(element) : push values at the end of list
	 	push_front(element) : push values at the start of thr list
	*/
	
	std::cout<< "inserting value at the start of the l2" << std::endl;
	l2.push_front(3015);
	std::cout<< "inserting 3080 at the end of list l2" << std::endl;
	l2.push_back(3080);

	std::cout << "new vaue of l2" << std::endl;
	for(auto v : l2)
		std::cout << v << " ";
	std::cout << std::endl;

	// empty function test

	std::cout << "is l2 empty " << l2.empty() << std::endl;
	std::cout << "size of l2 is " <<l2.size() << std::endl;
	std::cout << "front elementof l2 is  : "<< l2.front() << " last elementof l2 is : " << l2.back() << std::endl;

	//swapping two lists

	std::cout<<"swapping two lists l2 and l1" << std::endl;
	l2.swap(l1); 

	std::cout<< "new l1" << std::endl;
	for(auto v : l1)
		std::cout<< v << " ";
	std::cout<< std::endl;

	std::cout << "new contents of l2" << std::endl;
	for(auto v : l2)
		std::cout<< v << " ";
	std::cout << std::endl;


	// reversig the list

	std::cout<< " reversing l2 "<<std::endl;
	l1.reverse();
	for(auto v : l2)
		std::cout << v << " ";
	std::cout<< std::endl;
	return 0;


}