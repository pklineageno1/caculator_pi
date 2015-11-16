#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

double compute_pi( size_t dt )
{
    double pi = 0.0;
    double delta = 1.0 / dt;
    for ( size_t i = 0 ; i < dt ; i++ )
    {
        double x = (double) i / dt;
        pi += delta / (1.0 + x * x);
    }

    return pi * 4.0;
}

int main(void)
{
    int i=128000000;
    clock_t start, end;
    start = clock();
    printf( "%f\n", compute_pi( i ) );
    end = clock();
    printf("%f\n",(end-start)/(double)(CLOCKS_PER_SEC));
}
