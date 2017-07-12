# include <bits/stdc++.h>


using namespace std;


int max(int a , int b)
{
	return (a>b)? a:b;
}



int lps_recursive(string str, int s, int e)
{
	if(s==e)
		return 1;

	if(str[s] == str[e] && s+1 == e)
		return 2;

	if(str[s]==str[e])
		return lps_recursive(str, s+1, e-1)+2;

	return max(lps_recursive(str,s,e-1), lps_recursive(str,s+1, e));




}

int lps_dp(string str, int n)
{
	int lps[n][n];
	int cl,j,i;

	for(i=0; i< n;i++)
		lps[i][i]=1;

	
	for(cl=2; cl<=n; cl++)
		{
			for(i=0; i<n-cl+1; i++)
			{
				j= i+cl-1;

				if(str[i]==str[j] && cl==2)
					lps[i][j] =2;

				else if(str[i]==str[j])
					lps[i][j]=lps[i+1][j-1]+2;
				else
					lps[i][j]= max(lps[i+1][j], lps[i][j-1]);
			}
		}

	return lps[0][n-1];

}



int main(int argc, char const *argv[])
{
	string str="mayank";
	int n= str.length();

	cout<< "the length of lps_recursive " << " "<<lps_recursive(str, 0,n-1);
	cout<< endl;

	cout<< "the length of lps_dp " << " "<<lps_dp(str,n);
	cout<< endl;

	return 0;
}