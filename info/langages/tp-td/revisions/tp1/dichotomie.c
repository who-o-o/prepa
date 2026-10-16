#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

bool dichotomie(int* t, int e, int n);

int main(){
    int tab[5] = {1,2,3,40, 100};
    int *t = tab;
    int n = 5;
    printf("%d \n", dichotomie(t, 40, 5));
}

bool dichotomie(int *t, int e, int n){
    int g = 0; int d = n-1; 
    while(d-g > 0){
        int m = (d+g)/2;
        printf("m : %d\n",m);
        printf("d : %d\n", d);
        printf("g: %d\n", g);
        printf("t[m] : %d\n\n", t[m]);
        if(t[m] == e){
            return true;
        }
        if(t[m] > e) d = m;
        else{g = m;}
    }
    return false;
}