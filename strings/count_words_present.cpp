# include <bits/stdc++.h>

using namespace std;


int count_words(vector<string> v, string str)
{
    map<string ,int> m;

    //cout << sizeof(words);

    istringstream s1(str);
    string s;
    while(getline(s1,s,' '))
    {
      //cout << s<< endl;
      m[s]++;
    }
    int count=0,index=0;
    for(auto i =0 ; i<v.size(); i++)
    {
        if(m.find(v[i])!= m.end())
          count++;
        //  cout << v[i] << endl;
        //index++;
    }




      //for(auto i=m.begin(); i!=m.end();++i)
        //cout << i->first << " "<< i->second<< endl;;

    return count;
}



int main(int argc, char const *argv[]) {
  /* code */
   string words [] ={"welcome", "to", "geeks", "portal"};
  std::vector<string> v(words, words+4);
  string str = "geeksforgeeks is a computer science portal for geeks.";

  cout << " no of words prsent " << count_words(v, str) << endl;

  return 0;
}
