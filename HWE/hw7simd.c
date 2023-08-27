#include <xmmintrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <immintrin.h> 

#define height 17280
#define width  30720

struct timespec diff(struct timespec start, struct timespec end) {

    struct timespec tmp;
    if ((end.tv_nsec-start.tv_nsec)<0) {
        tmp.tv_sec = end.tv_sec-start.tv_sec-1;
        tmp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
    }else {
        tmp.tv_sec = end.tv_sec-start.tv_sec;
        tmp.tv_nsec = end.tv_nsec-start.tv_nsec;
    }
    return tmp;
}

int main()
{
    struct timespec begin_time, end_time, readTime, compTime, writeTime;
    int  *pBitmap , row, col;
    //int pixel, red, green, blue, alpha, bw;
    void *ptr;
     
    // my code compute readtime extraly....
    /////////////////////////////////////////////
    // declare for basic integer array for vector to normal integer
    clock_gettime(CLOCK_MONOTONIC, &begin_time);
    int bwArray[4] __attribute__((aligned(32))) ; 
    int alphaArray[4] __attribute__((aligned(32)));
    int redArray[4] __attribute__((aligned(32)));
    int greenArray[4] __attribute__((aligned(32)));
    int blueArray[4] __attribute__((aligned(32)));
    int andimmArray[4]__attribute__((aligned(32))) = { 0xff , 0xff , 0xff , 0xff } ;
    

    // the float constant for simd computoation
    float redimmArray[4]__attribute__((aligned(32))) = { 0.299 , 0.299 , 0.299 , 0.299} ;
    float greenimmArray[4]__attribute__((aligned(32))) = { 0.587 , 0.587 , 0.587 , 0.587 } ;
    float blueimmArray[4]__attribute__((aligned(32))) = { 0.114 , 0.114 , 0.114 , 0.114} ;
    
    // for tmp for computing float point computation
    float redftArray[4]__attribute__((aligned(32))) ;
    float greenftArray[4]__attribute__((aligned(32))) ;
    float blueftArray[4]__attribute__((aligned(32))) ;
    
    
    posix_memalign(&ptr, 16, height * width * sizeof(int));
    pBitmap = (int*) ptr;
    
    // for aligned
    //////////////////////////////////////////////
    __m128i *tmp0 , *tmp1 ; 

    // declation need aligned
    ///////////////////////////////////////////////

    for (row=0; row<height; row++)
    {
        for (col=0; col<width; col++)
        {
            pBitmap[col+row*width] = rand() ;
        }
    }

    __m128i *pBitmap128 , *alpha , *red , *green , *blue , *andimm , *bw;
    __m128 *redf , *greenf , *bluef ;  // float type multiplier 
    __m128 *redt , *greent , *bluet ;  // float type multiplier 
    // we need to use type conversion
    // for int / float array for put into vector
    pBitmap128 = (__m128i*)pBitmap ;
    alpha = (__m128i*)alphaArray ; 
    red = (__m128i*)redArray ;
    green = (__m128i*)greenArray ; 
    blue = (__m128i*)blueArray ;
    andimm = (__m128i*)andimmArray ;
    bw = (__m128i*)bwArray ; 

    redf = (__m128*)redimmArray ; 
    greenf = (__m128*)greenimmArray ; 
    bluef = (__m128*)blueimmArray ; 

    redt = (__m128*)redftArray ; 
    greent = (__m128*)greenftArray ; 
    bluet = (__m128*)blueftArray ; 

    clock_gettime(CLOCK_MONOTONIC, &end_time);
    readTime = diff(begin_time,end_time);
    // Count compute time
    clock_gettime(CLOCK_MONOTONIC, &begin_time);
    // Compute the result


    for (row=0; row < 4320 ; row++)
    {
        for (col=0; col< 7680 ; col++)
        {

            //pixel = pBitmap[col+row*height] ;
            
            //printf("%d\n", pixel);
            ////alpha = (pixel >> 24) & 0xff;
            *alpha =  _mm_srai_epi32 ( *(pBitmap128+col+row*width) , 24  ) ; 
            *alpha =  _mm_and_si128 ( *alpha , *andimm ); 

            //red = (pixel >> 16) & 0xff;
            *red =  _mm_srai_epi32 ( *(pBitmap128+col+row*width)  ,  16 ) ; 
            *red =  _mm_and_si128 ( *red , *andimm ); 
            //green = (pixel >> 8) & 0xff;
            *green =  _mm_srai_epi32 ( *(pBitmap128+col+row*width)  , 8 ) ; 
            *green =  _mm_and_si128 ( *green , *andimm ); 

            //blue = pixel & 0xff;
            *blue =  _mm_and_si128 ( *(pBitmap128+col+row*width)  , *andimm ); 
           
            // because there is no transformation between
            // _m128i and _m128 , so i nedd to transform by meself
            // but this method will decreas the performance
            // due to the loop 

            *redt = _mm_cvtepi32_ps( *red ) ; //red*0.299 
            *greent = _mm_cvtepi32_ps( *green ) ; // green*0.587
            *bluet = _mm_cvtepi32_ps( *blue) ; // blue*0.114

            *redf = _mm_mul_ps( *redf, *redt ) ; //red*0.299 + green*0.587 
            *greenf = _mm_mul_ps( *greenf , *greent ) ; //+blue*0.114
            *bluef = _mm_mul_ps( *bluef , *bluet ) ; //(int)
        
            //bw = (int) (red*0.299 + green*0.587 + blue*0.114);
            *redf  = _mm_add_ps( *redf , *bluef  ) ;
            *redf = _mm_add_ps( *redf , *greenf ) ;
            *bw = _mm_cvtps_epi32( *redf ) ;
            //*bw = _mm_castps_si128( *redf ) ; 
            /////////////////////////////////////////////////////////////////

            //( alpha<<24 ) + (bw<<16) + (bw<<8) + (bw);
            // put this result in alpha temporary 
            *alpha =  _mm_slli_epi32 ( *alpha , 24 ) ; 
            *alpha = _mm_add_epi32( _mm_slli_epi32 ( *bw , 16 ) , *alpha ) ;
            *alpha = _mm_add_epi32( _mm_slli_epi32 ( *bw , 8 ) , *alpha ) ;
            
            *alpha = _mm_add_epi32( *bw , *alpha ) ;
            

            // ==========above is for computing==============

            // put ans in original array 
            for(int k = 0; k < 4 ; k++)
            {
			    pBitmap[ col+row*width+k ] = alphaArray[k];
		    }

            /////////////////////////////////////////////////////////////////    
        }
    }
    // Count end
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    compTime = diff(begin_time,end_time);
    printf("SIMD readTime:%f \n" , readTime.tv_sec + (float) readTime.tv_nsec / 1000000000.0  ) ; 
    printf("SIMD compTime:%f \n" , compTime.tv_sec + (float) compTime.tv_nsec / 1000000000.0  ) ; 

    return 0;
}