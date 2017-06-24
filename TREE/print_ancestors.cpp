#include <bits/stdc++.h>


using namespace std;

struct node
{
	int data;

	node *left, *right;

};


struct node * newNode(int key)
{
	node *temp = new node;
	temp->data = key;
	temp->left=NULL;
	temp->right=NULL;
}

void printTree(node *root)
{
	if (root==NULL)
		return;
	cout << "->"<<root->data;
	printTree (root->left);
	printTree(root->right);

}

bool print_ances(node *root, int key) //recursive
{
	if(root == NULL)
		return false;

	if(root->data==key)
		return true;

	if(print_ances(root->left,key) || print_ances(root->right,key))
	{
		cout << " " <<root->data;
		return true;
	}
	else 
		false;


}

void print_ancestors(node *root, int key) //without recursion;
{
	stack<node*> ans;

	node *temp = root;

	if(temp==NULL)
		return ;
	if(temp->left==NULL && temp->right==NULL)
		cout << root->data <<endl;

	while(1)
	{
		while(root && root->data != key)
		{
			ans.push(root);
			root=root->left;
		}

		if(root && root->data==key)
			break;

		if((ans.top())->right == NULL)
		{
			root = ans.top();
			ans.pop();

			while(!ans.empty() && (ans.top())->right == root)
					{
						root = ans.top();
						ans.pop();
					}	
		}
		root =ans.empty() ? NULL : ((ans.top())->right);
	}
	while(!ans.empty())
	{
		cout << ans.top()->data <<" ";
		ans.pop();
	}
}


int main()
{

	node *root = newNode(1);
	root->left = newNode(2);
	root->right = newNode(3);
	root->left->left = newNode(4);
	root->left->right = newNode(5);

	root->right->left=newNode(6);
	root->right->right=newNode(7);

	root->left->left->left=newNode(8);
	root->left->right->right=newNode(9);
	root->right->right->left=newNode(10);

	printTree(root);
	cout<< endl;
	print_ances(root,7);
	cout<<endl;
	print_ancestors(root,7);
	cout << endl;

	return 0;
}