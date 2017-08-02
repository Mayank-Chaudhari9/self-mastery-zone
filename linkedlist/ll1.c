# include <stdlib.h>
#include <stdio.h>

struct node {
 int data;
 struct node *next;

};

void insert( struct node** head, int data)
{
  struct node *last = *head;
  struct node *new = (struct node*)malloc(sizeof(struct node));
  if(!new)
    printf("ERROR creating node\n");
new->data= data;

  if(last==NULL)
    *head = new;
  else
    {
      while(last->next!=NULL)
        last=last->next;

      last->next= new;

    }
}

void print(struct node *head)
{
  if(head==NULL)
    printf("empty \n");
  else
    while (head) {
      printf("%d\t",head->data );
      head=head->next;
    }

}

void delete(struct node ** head,int k)
{
  struct node *temp =*head;
  if(*head==NULL && k-1>0)
    printf("NOt possible\n");
  while (temp->next!=NULL && k-1>0)
   {
     temp= temp->next;
     k--;
  }
  if(k-1>0)
    printf("not permitted\n");
  else
    temp->next = temp->next->next;

}



int main(int argc, char const *argv[])
{
  struct node *head = NULL;
  insert(&head,10);
  insert(&head,20);
  insert(&head,30);



print(head);
delete(&head, 4);
printf("\n");
print(head);

  return 0;
}
