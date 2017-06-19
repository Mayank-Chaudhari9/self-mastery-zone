/*#include <bits/stdc++.h>

using namespace std;


struct Node
{
    int key;
    Node *left, *right;
};

struct  Node * newNode(int key)
{
	struct Node *temp= new Node;
	temp->key= key;
	temp->left=NULL;
	temp->right=NULL;

	return temp;	
}

void getVerticalOrder(Node *root, int hd,map<int,vector<int>> &m)
{
	if(root=NULL)
		return;
	
	m[hd].push_back(root->key);
     cout<<"here";
	getVerticalOrder(root->left,hd-1,m);
	getVerticalOrder(root->right,hd+1,m);


}

void printVerticalOrder(Node *root)
{
	map<int ,vector<int>> m;

	int hd=0;
	cout << "here";//cout << "here";
	getVerticalOrder(root,hd,m);
	//cout << "here";
	map<int,vector<int>> :: iterator it;
	for(it=m.begin(); it!=m.end(); it++)
	{
		for(int i=0; i<it->second.size(); ++i)
			cout << it->second[0] << " ";
		cout << endl;
	}

}



int main(int argc, char const *argv[])
{
	
	Node *root = newNode(1);
    root->left = newNode(2);
    root->right = newNode(3);
    root->left->left = newNode(4);
    root->left->right = newNode(5);
    root->right->left = newNode(6);
    root->right->right = newNode(7);
    root->right->left->right = newNode(8);
    root->right->right->right = newNode(9);
    cout << "Vertical order traversal is \n";
    printVerticalOrder(root);

	return 0;
}
*/

#include <bits/stdc++.h>

using namespace std;

struct Node
{
	int data;
	Node *left, *right;
};




struct Node * newNode(int key)
{
	Node *temp = new Node;
	temp->data = key;
	temp->left=NULL;
	temp->right=NULL;
}

void printTree(Node *root)
{
	if (root==NULL)
		return;
	cout << root->data<<endl;
	printTree (root->left);
	printTree(root->right);

}


void getVerticalOrder(Node *root, int hd, map<int,vector<int>> &m)
{
	if (root==NULL)
		return;
	m[hd].push_back(root->data);
	getVerticalOrder(root->left,hd-1,m);
	getVerticalOrder(root->right,hd+1,m);
}
void printVerticalOrder(Node *root)
{
	int hd=0;

	map<int,vector<int>> m;

	getVerticalOrder(root, hd, m);

	map<int,vector<int>>::iterator it;

	for (it = m.begin(); it != m.end();it++)
	{
		for(int i=0;i<it->second.size(); ++i)
			cout << it->second[i] << " ";
		cout << endl;
	}





}

int main(int argc, char const *argv[])
{
	Node *root = newNode(1);
	root->left = newNode(2);
	root->right = newNode(3);
	root->left->left = newNode(4);
	root->left->right = newNode(5);

	root->right->left=newNode(6);
	root->right->right=newNode(7);

	root->right->left->right=newNode(8);
	root->right->right->right=newNode(9);




	//printTree(root);

	printVerticalOrder(root);

	return 0;
}


