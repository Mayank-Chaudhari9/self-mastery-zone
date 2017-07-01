# include <bits/stdc++.h>



using namespace std;

int possiblestrings(int r, int g,int b, int n)
{
   int left = n-(r+g+b);
   int fact[n+1];

   fact[0]=1;
// pre calculate factorial
   for(int i=1;i<=n;i++)
  {
    fact[i]=fact[i-1]*i;
  }
   int sum =0;
// find all combinations
   for(int i=0;i<=left;i++)
   {
     for(int j=0;j<=left-i;j++)
     {
       int k = left-(i+j);

       sum = sum+fact[n]/(fact[r+i]*fact[b+j]*fact[g+k]);
     }
   }
   //return sum of all such combinations;
return sum;


}

int main(int argc, char const *argv[]) {
  int n=4,r=2, g = 1, b=0;

  cout << "all possible strings with this combination " << possiblestrings(r,g,b,n)<<endl;
  return 0;
}
