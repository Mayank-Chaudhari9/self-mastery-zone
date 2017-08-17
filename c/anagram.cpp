#include <bits/stdc++.h>

using namespace std;


int anagram(string a, string b, int la, int lb)
{
	int count=0;

	unordered_map<char,int>m;


	//bool f1;
	int an[26], bn[26];
	for (int i = 0; i < 26; ++i)
	{
		an[i]=0;
		bn[i]=0;
	}


	if(la==0 and lb ==0)
		return 0;
	if(la==0)
		return lb;
	else if(lb==0)
		return la;



	

	for(int i=0 ;i<la ;i++)
	{
		char a1= a[i];
		int index = a1-97;
		an[index]=an[index]+1;

	}


	for(int i=0 ;i<lb ;i++)
	{
		char b1= b[i];
		int index1 = b1-97;
		bn[index1]=bn[index1]+1;

	}


	for(int i=0;i<26; i++)
	{
		count = count+ (max(an[i],bn[i])-min(an[i],bn[i]));
	}



return count;






}

int main(int argc, char const *argv[])
{
	string a, b;
	cin >>a;
	cin >>b;

	int la= a.length();
	int lb=b.length();

	int count =anagram(a,b,la,lb);

	cout << count<< endl;

	return 0;
}