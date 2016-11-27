
#include <stdlib.h>
#include <stdio.h>

int max(int a, int b) { return (a > b)? a : b;}



// this is the most basic recursive version implementation
int cuts[20];


int cut_rod(int p[] , int n) {

   int q = -999;

 if (n == 0) {
    return 0;

 }





 for (int i=0; i<n; i++){

 int res=p[i] + cut_rod(p,n - (i+1) );
 if(q>res)
      cuts[i]=i;

 q= max(q,res);


 }
return  q;





}

// memoized version of cut_rod

int memoized_cut_rod (int p[] , int n) {


 // create an array table to store memoized values

 int temp[100]={};

 int q=-1;
 int i=0;

 if ( n== 0) {

    return 0;

 }

 if (temp[n]>0) {

    return temp[n];

 }
else {

         for (i=0; i<n; i++) {

             int res=p[i] + cut_rod(p,n - (i+1) );
             if(q>res)
                cuts[i]=i;

 q= max(q,res);
 


 }

return q;

}


}

// cut_rod using bottom up approach

 int r[100]= {};

int bottom_cut_rod (int p[],int n) {


    r[0]=0;


   for (int j=0; j<n; j++) {

        int q=-5;

        for(int i=1; i-1<=j; i++) {
              

              if(q<(p[i - 1] + r[j - i + 1]))
                cuts[j]=i;
              q=max(q,p[i - 1] + r[j - i + 1]);


               
              printf("q : %d\t",q);



        }


  r[j+1]=q;
  r[1]=0;

  
  printf("r : %d\n",r[j]);

   }



return r[n];


}

int main() {

int arr[]={1,5,8,9,10,17,17,20,24,30,31,32,33,34,35,36,37,38},count=18;
int length_to_cut;
printf("Enter rod length to cut between (1-18)\n");
scanf("%d",&length_to_cut);

 //printf("%d\n",cut_rod(arr,length_to_cut));


  //printf("%d\n",memoized_cut_rod(arr,length_to_cut));

 
  printf(" Final max profit %d\n",bottom_cut_rod(arr,length_to_cut));
  printf("\n---------------------------------------------------------------------------------------------------------------------------------------------------\n" );
  printf("length:\t");
  for (int i = 0; i < count; i++)
  {
    printf("%d\t",i+1 );
  }
  printf("\n---------------------------------------------------------------------------------------------------------------------------------------------------\n" );
  printf("values:\t");
  for (int i = 0; i < 18; i++)
  {
    printf("%d\t",arr[i] );
  }
  printf("\n---------------------------------------------------------------------------------------------------------------------------------------------------\n" );
  printf("cut at:\t");
  for (int i = 0; i < count; i++)
  {
    printf("%d\t",cuts[i] );
  }
  printf("\n");
  printf("\n---------------------------------------------------------------------------------------------------------------------------------------------------\n" );

return 0;

}