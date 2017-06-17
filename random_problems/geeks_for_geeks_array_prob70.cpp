#include <iostream>
#include <algorithm>
#include <vector>
#include <numeric>
#include <math.h>
#include <map>

using namespace std;

struct Entry
{
   int a;
   int b;
};

int main () {

   typedef vector<int> VI;

   VI l(5);
   l[0] = 1;
   l[1] = 2;
   l[2] = -1;
   l[3] = -2;
   l[4] = 5;
   l[5] = 6;

   sort(l.begin(), l.end());

   int sumTo = 0;

   typedef multimap<int, Entry> Table;

   typedef pair<int,Entry> PairEntry;

   Table myTbl;

   // N
   for (int i = 0; i < l.size(); ++i)
   {
      // N
      for (int j = i+1; j < l.size(); ++j)
      {
         // Const
         int val = l[i] + l[j];

         // A is always less than B
         Entry ent = {i, j};

         myTbl.insert(PairEntry(val,ent));
      }
   }

   pair<Table::iterator, Table::iterator> range;

   // Start at beginning of array
   for (Table::iterator ita = myTbl.begin();
        ita != myTbl.end();
        ++ita)
   {
      int lookFor = sumTo - ita->first;
      // Find the complement
      range = myTbl.equal_range(lookFor);

      // Const bound
      for (Table::iterator itb = range.first;
           itb != range.second;
           ++itb)
      {
         if (ita->second.a == itb->second.a || ita->second.b == itb->second.b)
         {
            // No match
         }
         else
         {
            // Match
            cout << l[ita->second.a] << " " << l[itb->second.a] << " "
                 << l[ita->second.b] << " " << l[itb->second.b] << endl;

            return 0;
         }
      }
   }

   return 0;
}
