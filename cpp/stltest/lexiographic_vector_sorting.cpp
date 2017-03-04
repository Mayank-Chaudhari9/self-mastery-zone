#include <vector>
#include <string>
#include <iostream>
#include <algorithm>

int main()
{
  std::vector<std::vector<std::string>> v{{"a", "c", "duck"},
                                          {"a", "a", "f"},
                                          {"bee", "s", "xy"},
                                          {"b", "a", "a"}};
  std::sort(v.begin(), v.end());

  for (const auto& v_: v)
  {
    for (const auto& s : v_)
      std::cout << s << " ";
    std::cout << std::endl;
  }
  std::cout << std::endl;

  return 0;
}

//Output:

//a a f 
//a c duck 
//b a a 
//bee s xy 

// works with c++11