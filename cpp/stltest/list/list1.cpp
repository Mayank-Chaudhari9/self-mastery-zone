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
	std::cout << " printing new values of l2 " << std::endl;
	for( auto v : l2)
		std::cout<< v << " ";
	std::cout<<std::endl;

	return 0;


}