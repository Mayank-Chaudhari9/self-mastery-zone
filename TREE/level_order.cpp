# include <bits/stdc++.h>

using namespace std;

struct node
{
  int data;
  node *left, *right;
};

node *newnode(int data)
{
  node *temp= new node;
  temp->data=data;
  temp->left,temp->right=NULL;
  return temp;
}

void print(node *root)
{
  if(root!=NULL)
  {
    print(root->left);
    cout << root->data<<" ";
    print(root->right);
  }
}

void print_level(node *root)
{
  queue<node*>q;
  q.push(root);
  while(!q.empty())
  {
    node *val=q.front();
  
    cout<<val->data << " ";
    if(val->left!=NULL)
      q.push(val->left);
    if(val->right!=NULL)
      q.push(val->right);
    q.pop();


  }
}

int main()
{
  node *root=NULL;
  root=newnode(10);
  root->left=newnode(12);
  root->right=newnode(15);

  root->left->left=newnode(25);
  root->left->right=newnode(30);
  root->right->left=newnode(36);

  cout << "inorder is\n";
  print(root);

  cout << endl;

  cout << "level order is" <<endl;
  print_level(root);

  cout << endl;

  return 0;
}
