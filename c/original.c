#include<stdio.h>

unsigned long Exponentiation(unsigned long M, unsigned N) {
  unsigned long result = 1L;
  while(N) {
    result = (N&1) ? result*M : result;
    M *= M;
    N >>= 1;
  }
  return result;
}

void PrintIterates(unsigned long t, unsigned prec) {
  if(prec) {
    char result[prec+1];
    unsigned m;
    result[prec] = (char)0;
    for(m=1; m<=prec; m++) {
      result[prec-m] = '0' + (char)(t % 10L);
      t /= 10L;
    }
    printf("%lu.%s\n",t,result);
  }
  else printf("%lu.0\n",t);
}

void FindNthRoot(unsigned long M, unsigned N, unsigned prec) {
  unsigned long min, max, t;
  unsigned m;
  int searching=1;
  long sign; //=(1L<<(sizeof(unsigned long)*8-1));
  min=1; max=M; t=(min+max)/N;
  int ops=0;
  for(m=1; m<=prec+1; m++) {
    while(min<t && t<max && searching) {
      ops++;
      PrintIterates(t,m-1);
      unsigned long tRaisedToN;
      tRaisedToN = Exponentiation(t,N);
      sign = tRaisedToN - M;
      if(sign < 0L) sign = -1L;
      else if(sign > 0L) sign = 1L;
      switch(sign) {
          case -1L: min = t; break;
          case 0L: searching = 0; break;
          case 1L: max = t; break;
      }
      t=(min+max)/2;
    }
    if(m <= prec+1) {
      t *= 10;
      min = t-10;
      max = t+10;
      M *= Exponentiation(10,N);
    }
  }
  printf("\n");
}

int main(int argc, char *argv[]) {
  unsigned k, prec, N;
  unsigned long M;
  scanf("%u",&k);
  while(k--) {
    scanf("%lu%u%d", &M, &N, &prec);
    if(N*prec > 18) printf("-1\n");
    else FindNthRoot(M,N,prec);
  }
  return 0;
}
