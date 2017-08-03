 #include <stdio.h>
#include <stdlib.h>


struct node
{
  int data;
  struct node *left;
  struct node *right;
};


struct node * newnode(int data)
{
  struct node *node = (struct node*)malloc(sizeof(struct node));

  node->left = NULL;
  node->right=NULL;
  node->data=data;

  return node;
}


void inorder(struct node *root)
{
    if(root!=NULL)
    {
      inorder(root->left);
      printf("%d\t",root->data);
      inorder(root->right);
    }

}

void fixprev(struct node * root)
{
  static struct node *prev=NULL;
  if(root!=NULL)
  {
    fixprev(root->left);
    root->left=prev;
    prev=root;
    fixprev(root->right);
  }
}

struct node* fixnext(struct node* root)
{
  struct node * prev=NULL;
  while(root  && root->right!=NULL)
    root=root->right;

    while(root && root->left!=NULL)
    {
      prev =root;
      root=root->left;
      root->right=prev;
    }

    return (root);

}
struct node* btll(struct node * root)
{
  fixprev(root);

  return fixnext(root);
}

void printl(struct node * head)
{
  while(head!=NULL)
  {
    printf("%d\t",head->data );
    head=head->right;
  }
}


int main(int argc, char const *argv[]) {
  /* code */
  struct node *root=NULL;

  root=newnode(10);
  root->left=newnode(12);
  root->right=newnode(15);

  root->left->left=newnode(25);
  root->left->right=newnode(30);

  //root->left=newnode(12);
  //root->right=newnode(15);

  //root->left=newnode(12);
  root->right->left=newnode(36);

  inorder(root);
  printf("\n");



  struct node *head = btll(root);

  //printf("%d\n",head->data );

printl(head);
printf("\n");




  return 0;
}
