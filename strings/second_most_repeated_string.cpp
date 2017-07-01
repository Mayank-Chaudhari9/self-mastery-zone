# include <bits/stdc++.h>

using namespace std;

string second_most(std::vector<string> seq)
{
    unordered_map<string, int> m;

    // filling string in map;

    for(int i=0; i<seq.size(); i++)
      m[seq[i]]++;

  // find second max
    int first_max= INT_MIN, sec_max= INT_MIN;
    for(auto i=m.begin(); i!=m.end(); ++i)
    {

      if(i->second> first_max)
      {
        sec_max = first_max;
        first_max = i->second;
      }
      else if(i->second > sec_max && i->second != first_max)
        sec_max= i->second;
    }

    // return second max string;

    for(auto i = m.begin(); i!= m.end(); ++i)
    {
      if(i->second == sec_max)
        return i->first;
     }


}



int main(int argc, char const *argv[]) {
  /* code */
 vector<string> seq = {"ccc", "aaa", "ccc","ddd", "aaa", "aaa" };

 cout << " the second max occuring string is " <<" "<< second_most(seq)<< endl;

  return 0;
}
