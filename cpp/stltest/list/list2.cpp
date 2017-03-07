#include <iostream>
#include <list>


bool compare_function(std::string &s1, std::string &s2)
{
	return (s1.length() < s2.length());
}

int main()
{
	std::list<int> li {10,2,33,4,5};
	std::list<std::string> ls{"hello","hi", "bye", "goodnight", "alvida"};

	/**
		sort() method sorts the given list. It does not create new sorted list but changes the position of elements within an existing list to sort it.
		sort() : sorts the elements of the list in ascending order, the element of the list should by numeric for this function.
		sort(compare_function) : This type of sort() is used when we have to alter the method of sorting. Its very helpful for the elements that are not numeric. We can define how we want to sort the list elements in compare_funtion

	*/
	//sorting above lists
	li.sort();
	ls.sort(); //sortd lexiographically
	for(std::list<int>::iterator i=li.begin(); i!=li.end(); ++i)
		std::cout << *i << " ";
	std::cout<< std::endl;

	for(std::list<std::string>::iterator i=ls.begin(); i!=ls.end(); ++i)
		std::cout << *i << " ";
	std::cout<< std::endl;

	// sorting using compare function
	std::cout<<"sorting using a compare function according to string lenght" << std::endl;
	ls.sort(compare_function);
	for(std::list<std::string>::iterator i=ls.begin(); i!=ls.end(); ++i)
		std::cout << *i << " ";
	std::cout<< std::endl;


	/** splice operation

		splice() method transfers the elements from one list to another. There are three versions of splice :

		splice(iterator, list_name) : Transfers complete list list_name at position pointed by the iterator.

		splice(iterator, list_name, iterator_pos) : Transfer elements pointed by iterator_pos from list_name at position pointed by iterator

		splice(iterator, list_name, itr_start, itr_end) : Transfer range specified by itr_start and itr_end from list_name at position pointed by iterator.

	**/
	std::list<int> list1 = {1,2,3,4};
  	std::list<int> list2 = {5,6,7,8};
  	std::list<int>::iterator it;

  	it = list1.begin();
  	++it;   //pointing to second position           

  	list1.splice(it, list2);
  	/* transfer all elements of list2 at position 2 in list1 */
  	/* now list1 is 1 5 6 7 8 2 3 4 and list2 is empty */

                                          
  	list2.splice(list2.begin(), list1, it);
  	/* transfer element pointed by it in list1 to the beginning of list2 */
  	/* list2 is now 5 and list1 is 1 6 7 8 2 3 4*/


  	/* merging two lists
  		Merges two sorted list. It is mandatory that both the list should be sorted first

  		merge() merges the two list such that each element is placed at its proper position in the resulting list. 

  	*/

  	std::list<int> list11 = {1,3,5,7,9};
    std::list<int> list21 = {2,4,6,8,10};

    /* both the lists are sorted. In case they are not , 
    first they should be sorted by sort function() */

  	list1.merge(list2);
  
  	/* list list1 is now 1,2,3,4,5,6,7,8,9,10  */
  
  	std::cout << list11.size() << std::endl;


	return 0;
}