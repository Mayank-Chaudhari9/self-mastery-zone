#include <iostream>
#include <vector>


int main()
{
	std::vector<double> v;
	std::vector<std::string> sv;
	std::vector<std::string>::const_iterator si;
	std::vector<double> ::const_iterator i; //const_iterator because we do not want to change the content of vector

	int sum=0;
	double mean;
	for(int i=0;i<10;i++)
		v.push_back(i);
	// using normal for loop
	for(int i=0;i<10;i++)
		sum=sum+v.at(i);

	mean = sum/double(v.size());

	std::cout<< "sum is : "<< sum << " mean is : "<< mean<< std::endl;

	// using const_iterator
	// v.begin() points to first element
	// v.end() points to one element past to last element
	// we cant dereference memory at v.end()

	for( i=v.begin(); i!=v.end(); ++i)
		std:: cout <<(*i) <<std::endl; 


	sv.push_back("Chaudhari");
	sv.push_back("Mayank");
	// using assign() to initialize an vector

	std::vector<std::string> sv1;
	sv1.assign(sv.begin(),sv.end());
	//sv1.assign(3,"Mayank"); // uncommenting this will reinitialize the vector with Mayank*3

	for( si=sv1.begin(); si!=sv1.end(); ++si)
		std::cout << (*si) << std::endl;

	//some string vector constructor example

	/* 
		    typedef std::vector<std::string> str_vec_t;
		    str_vec_t v1;                       // create an empty vector
		    str_vec_t v2(10);                   // 10 copies of empty strings
		    str_vec_t v3(10, "hello");          // 10 copies of the string
		                                        // "hello"
		    str_vec_t v4(v3);                   // copy ctor
		     
		        std::list<std::string> sl;      // create a list of strings
		                                        // and populate it
		        sl.push_back("cat");
		        sl.push_back("dog");
		        sl.push_back("mouse");
		     
		    str_vec_t v5(sl.begin(), sl.end()); // a copy of the range in
		                                        // another container
		                                        // (here, a list)
		     
		    v1 = v5;                            // will copy all elements
	*/	                                        // from v5 to v1

	return 0;

}