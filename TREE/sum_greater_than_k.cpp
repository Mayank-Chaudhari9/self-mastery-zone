# include <bits/stdc++.h>

using namespace std;

struct node
{
	int data;
	struct node *left, *right;
};



struct node *newNode (int data)
{
 	
 	node *temp= new node;
 	temp->data = data;
 	temp->left = temp->right = NULL;

}

void print_t(node *root)
{
	if (root!=NULL)
	{
		print_t(root->left);
		cout << root->data << " ";
		print_t(root->right);
	}
		
}

node *process_t(node *root, int k, int *sum)
{
	if (root==NULL)
	{
		return NULL;
	}

	int lsum=*sum+(root->data);
	int rsum=lsum;

	root->left=process_t(root->left, k, &lsum);
	root->right=process_t(root->right, k, &rsum);

	*sum = max(lsum, rsum);

	if(*sum < k)
	{
		free(root);
		root = NULL;
	}

	return root;
}


node *process(node *root, int k)
{
	
	int sum=0;
	return process_t(root, k, &sum);
}



int main(int argc, char const *argv[])
{
	int k=45;

	node *root= newNode(1);
	root->left = newNode(2);
    root->right = newNode(3);
    root->left->left = newNode(4);
    root->left->right = newNode(5);
    root->right->left = newNode(6);
    root->right->right = newNode(7);
    root->left->left->left = newNode(8);
    root->left->left->right = newNode(9);
    root->left->right->left = newNode(12);
    root->right->right->left = newNode(10);
    root->right->right->left->right = newNode(11);
    root->left->left->right->left = newNode(13);
    root->left->left->right->right = newNode(14);
    root->left->left->right->right->left = newNode(15);

    cout << " before processing " << endl;
    print_t(root);
    cout << endl;

    cout << "after deleting nodes in path wiht sum <=k "<<endl;
    root =process(root,k);
    print_t(root);

    cout << endl;


	return 0;
}