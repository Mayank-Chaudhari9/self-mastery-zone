#include <iostream>
#include <vector>
#include <string>

int main(int argc, char const *argv[])
{
	std::vector<std::string> sv;
	std::string name1,name2,name3;
	std::cout<<"string vector initial capacity : "<<sv.capacity()<<" initial size : "<<sv.size()<<std::endl;
	sv.push_back("Mayank");
	sv.push_back("Chaudhari");
	sv.push_back("saurabh");
	sv.push_back("parmar");
	
	std::cout<<"string vector final capacity : "<<sv.capacity()<<" final size : "<<sv.size()<<std::endl;
	std::cout<<"removing last elemrnt : " << sv.back()<<std::endl;
	sv.pop_back(); //removing last element from vector
	//print last element after removing
	std::cout<<sv.back()<<std::endl;
	
	std::cout<<sv.front()<<std::endl;
	return 0;
}