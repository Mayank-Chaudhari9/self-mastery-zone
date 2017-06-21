#include <bits/stdc++.h>


using namespace std;

struct node{

    int data;
    struct node *next;

};


struct node * reversell(struct node *head)
{
    struct node *rhead;

    if(head == NULL || head->next == NULL)
        return head;

    rhead = reversell(head->next);
    head->next->next=head;
    head->next=NULL;

    return rhead;
}


void print(struct node * head)
{
    struct node  *temp = head;
    if(head==NULL)
        cout<< "empty ll" << endl;
    else
        while(temp!=NULL)
            {
                cout << temp->data << endl;
                temp= temp->next;
            }

}


int main()
{
    struct node *head=NULL;
    struct node *tail;
    struct node *h1=(struct node *)malloc(sizeof(struct node));
    h1->data=1;

    struct node *h2=(struct node *)malloc(sizeof(struct node));
    h2->data=2;
    //h1->next=h3;

    struct node *h3=(struct node *)malloc(sizeof(struct node));
    h3->data=3;
    //h1->next=h4;

    struct node *h4=(struct node *)malloc(sizeof(struct node));
    h4->data=4;
    //h1->next=h5;

    struct node *h5=(struct node *)malloc(sizeof(struct node));
    h5->data=5;

    h1->next=h2;
    h2->next=h3;
    h3->next=h4;
    h4->next=h5;

    h5->next=NULL;

    print(head);
    print(h1);

    tail = reversell(h1);
    print(tail);

    return 0;
}
