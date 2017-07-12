#include <bits/stdc++.h>


using namespace std;



struct  node
{
	int data;
	struct  node *left, *right;
	
};


node *newNode(int data)
{
	node *temp = new node;
	temp->data= data;
	temp->left = temp->right = NULL;

	return temp;
}

void left_view(node *root, int level, int *max_level)
{
	if(root==NULL)
		return;

	if(*max_level < level)
	{
		cout << root->data << " ";
		*max_level =level;
	}

	left_view(root->left, level+1, max_level);
	left_view(root->right, level+1, max_level);
}

void print_left_view(struct node *root)
{

	int max_level = 0;
	left_view(root, 1, &max_level);
}




int main(int argc, char const *argv[])
{
	/* code */
	node *root = newNode(12);
	root->left = newNode(10);
    root->right = newNode(30);
    root->right->left = newNode(25);
    root->left->left = newNode(15);
    root->right->right = newNode(40);


    print_left_view(root);
    cout << endl;

	return 0;
}