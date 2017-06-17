#include<bits/stdc++.h>

using namespace std;

struct Node
{
  int data;
  struct Node *next;
};

struct Node * insertll(struct Node *head, int data)
{
  struct Node *current=head;
  struct Node *temp = (struct Node *)malloc(sizeof(struct Node));
  temp->data=data;
  temp->next=NULL;


  if(head==NULL)
    head=temp;

  else
    {
        while(current->next!=NULL)
          current=current->next;

          current->next=temp;
        }

  return head;

}

void printll(struct Node * head)
{
  if (head==NULL)
    cout<< "empty ll" <<endl;
  else
    while(head!=NULL)
    {
      cout<< "->"<<head->data;
      head=head->next;
    }

}

void nth_node(struct Node * head, int nth)
{
  int pos=0;
  while(pos<nth)
    {
      if(head==NULL)
        {
          cout<<"not possible" <<endl;

          return;
        }
      else
      {
          head=head->next;
          pos=pos+1;
        }

    }
    cout <<endl;
    cout << nth << " node is "<<head->data<<endl;

}




int main()
{
  struct Node *head = NULL;
  head=insertll(head,1);
  head=insertll(head,2);
  head=insertll(head,7);
  head=insertll(head,8);

  printll(head);
  nth_node(head,2);

  return 0;
}
