#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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
    void *ptr;
    int *pBitmap, row, col;
    int pixel, red, green, blue, alpha, bw;

    clock_gettime(CLOCK_MONOTONIC, &begin_time);
    //pBitmap = (int*) malloc(height * width * sizeof(int));
    posix_memalign(&ptr, 16, height * width * sizeof(int));
    pBitmap = (int*) ptr;
    
    for (row=0; row<height; row++)
    {
        for (col=0; col<width; col++)
        {
            pBitmap[col+row*width] = rand() ;
        }
    }
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    readTime = diff(begin_time,end_time);
    // Count compute time
    clock_gettime(CLOCK_MONOTONIC, &begin_time);
    // Compute the result

    for (row=0; row<height; row++)
    {
        for (col=0; col<width; col++)
        {
            pixel = pBitmap[col+row*width] ;
            
            //printf("%d\n", pixel);
            
            alpha = (pixel >> 24) & 0xff;
            red = (pixel >> 16) & 0xff;
            green = (pixel >> 8) & 0xff;
            blue = pixel & 0xff;
            bw = (int) (red*0.299 + green*0.587 + blue*0.114);
            pBitmap[col + row*width] = ( alpha<<24 ) + (bw<<16) + (bw<<8) + (bw);
        }
    }
    // Count end
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    compTime = diff(begin_time,end_time);
    printf("SIMD readTime:%f \n" , readTime.tv_sec + (float) readTime.tv_nsec / 1000000000.0 ) ; 
    printf("SIMD compTime:%f \n" , compTime.tv_sec + (float) compTime.tv_nsec / 1000000000.0 ) ; 


    return 0;
}