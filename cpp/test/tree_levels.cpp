#include <bits/stdc++.h>

using namespace std;

typedef struct node
{
	int data;
	struct node *left,*right;
}*tree;

node * newnode(int data)
{
	node *temp = (node *)malloc(sizeof(node));
	temp->data= data;
	temp->left= NULL;
	temp->right=NULL;

	return temp;
}

void preorder(node *root)
{

	if(root)
		{
			cout << root->data;
			preorder(root->left);
			preorder(root->right);
		}

}

int main()
{

	tree root =NULL;
	//node *root=NULL;
	//*tree=root;
	root = newnode(1);

	root->left=newnode(2);
	root->right=newnode(3);

	root->left->left=newnode(4);

	root->left->left->left=newnode(5);

	preorder(root);


	return 0;	
}