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

  


  return 0;
}
