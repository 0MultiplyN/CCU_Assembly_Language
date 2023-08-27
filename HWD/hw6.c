#include "stdio.h"
extern int BIN2BCD(int) ;
extern int BCDADD(int,int) ;
extern int BCDSUB(int,int) ;

int main()
{
    int a = 0 , b = 0 , a1 = 0 , b1 = 0 , r1 = 0 , r2 = 0 ; 
    scanf("%d %d",&a,&b) ; 

    a1 = BIN2BCD(a) ; // binary to bcd representation
    b1 = BIN2BCD(b) ; 

    r1 = BCDADD(a1,b1) ; // bcd type addition
    r2 = BCDSUB(a1,b1) ; // bcd type subtraction

    // process output
    int cnt = 0 ; 
    
    // counter for count length of array 
    //=========================================
    
    
    int arr1[ 12 ] = { 0 } ;
    int arr2[ 12 ] = { 0 } ; 
    int arr3[ 12 ] = { 0 } ; 
    int arr4[ 12 ] = { 0 } ; 
    // arr1 -> r1
    // arr2 -> r2
    // arr3 -> a1
    // arr4 -> b1
    while( r1 != 0 )
    {
        int tmp = r1 % 2 ;
        arr1[cnt] = tmp ; 
        r1 = r1 / 2 ; 
        cnt++ ; 
    }
    // do ten to binary 
    // store in the array
    cnt = 0 ; 
    while( r2 != 0 )
    {
        int tmp = r2 % 2 ;
        arr2[cnt] = tmp ; 
        r2 = r2 / 2 ; 
        cnt++ ; 
    }
    // do ten to binary
    // store in the array
    // do ten to binary 
    // store in the array
    cnt = 0 ; 
    while( a1 != 0 )
    {
        int tmp = a1 % 2 ;
        arr3[cnt] = tmp ; 
        a1 = a1 / 2 ; 
        cnt++ ; 
    }
    // do ten to binary 
    // store in the array
    cnt = 0 ; 
    while( b1 != 0 )
    {
        int tmp = b1 % 2 ;
        arr4[cnt] = tmp ; 
        b1 = b1 / 2 ; 
        cnt++ ; 
    }
    // output a1 , b1 , r1 , r2
    
    printf("result_of_a1\n") ; 
    printf("%d%d%d%d_",arr3[11],arr3[10],arr3[9],arr3[8]) ; 
    printf("%d%d%d%d_",arr3[7],arr3[6],arr3[5],arr3[4]) ; 
    printf("%d%d%d%d\n",arr3[3],arr3[2],arr3[1],arr3[0]) ; 
    printf("result_of_b1\n") ; 
    printf("%d%d%d%d_",arr4[11],arr4[10],arr4[9],arr4[8]) ; 
    printf("%d%d%d%d_",arr4[7],arr4[6],arr4[5],arr4[4]) ; 
    printf("%d%d%d%d\n",arr4[3],arr4[2],arr4[1],arr4[0]) ; 
    printf("result_of_r1\n") ; 
    printf("%d%d%d%d_",arr1[11],arr1[10],arr1[9],arr1[8]) ; 
    printf("%d%d%d%d_",arr1[7],arr1[6],arr1[5],arr1[4]) ; 
    printf("%d%d%d%d\n",arr1[3],arr1[2],arr1[1],arr1[0]) ; 
    printf("result_of_r2\n") ; 
    printf("%d%d%d%d_",arr2[11],arr2[10],arr2[9],arr2[8]) ; 
    printf("%d%d%d%d_",arr2[7],arr2[6],arr2[5],arr2[4]) ; 
    printf("%d%d%d%d\n",arr2[3],arr2[2],arr2[1],arr2[0]) ; 

    return  0 ; 
}
