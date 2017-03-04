#include <vector>
#include <iostream>

int main()
{
	std::cout << "my first vector program" << std::endl;

	std::vector<int> int_v;

	std::cout << "initial vector size: "<<int_v.size()<<std::endl;
	for (int i=0;i<10;i++)
		int_v.push_back(i);
	std::cout << "new vector size: "<<int_v.size()<<std::endl;


	return 0;
}