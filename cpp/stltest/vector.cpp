#include <vector>
#include <iostream>

int main()
{
	std::cout << "my first vector program" << std::endl;

	std::vector<int> int_v; // normal declaraton of vector
	std::vector<int> reserved_int_v(10); //reserving 10 spaces in advance
	// another way of reserving array
	std::vector<char> char_v;
	char_v.reserve(10); // make room for 10 elements


	// checking capacity of each array
	std::cout << "capacity of int default array : "<<int_v.capacity()<<std::endl;
	std::cout << "capacity of int default array : "<<reserved_int_v.capacity()<<std::endl;
	std::cout << "capacity of char_v default array : "<<char_v.capacity()<<std::endl; 

	std::cout << "initial vector size: "<<int_v.size()<<std::endl;
	for (int i=0;i<10;i++)
		int_v.push_back(i);
	std::cout << "new capacity of int default array : "<<int_v.capacity()<<std::endl;
	std::cout << "new vector size: "<<int_v.size()<<std::endl;

	char_v.push_back('M');
	std::cout<<int_v.at(6) << std::endl; // correct
	std::cout<<char_v.at(0); // correct
	//std::cout<<char_v.at(2); // not-correct -> although space is reserved for 10 but memory is not initialized for them -> out_of_range error
	/*
		    std::vector<int> array;   // create an empty vector
		    array.reserve(3);         // make room for 3 elements
		                              // at this point, capacity() is 3
		                              // and size() is 0
		    array.push_back(999);     // append an element
		    array.resize(5);          // resize the vector
		                              // at this point, the vector contains
		                              // 999, 0, 0, 0, 0
		    array.push_back(333);     // append another element into the vector
		                              // at this point, the vector contains
		                              // 999, 0, 0, 0, 0, 333
		    array.reserve(1);         // will do nothing, as capacity() > 1
		    array.resize(3);          // at this point, the vector contains
		                              // 999, 0, 0
		                              // capacity() remains 6
		                              // size() is 3
		    array.resize(6, 1);       // resize again, fill up with ones
		                              // at this point the vector contains
		                              // 999, 0, 0, 1, 1, 1


	*/


	return 0;
}