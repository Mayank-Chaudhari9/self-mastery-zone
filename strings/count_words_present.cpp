# include <bits/stdc++.h>

using namespace std;


int count_words(string words[], string str)
{
    map<string ,int> m;

    istringstream s1(str);
    string s;
    while(getline(s1,s,' '))
    {
      //cout << s<< endl;
      m[s]++;
    }





      for(auto i=m.begin(); i!=m.end();++i)
        cout << i->first << " "<< i->second<< endl;;

    return 0;
}



int main(int argc, char const *argv[]) {
  /* code */
  string words [] ={"welcome", "to", "geeks", "portal"};
  string str = "geeksforgeeks is a computer science portal for geeks.";

  cout << " no of words prsent " << count_words(words, str) << endl;

  return 0;
}
