#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

int recherche(char *m, char* texte);

int main(){
    char * texte = "aaabbaa";
    char * m1 = "c";
    char * m2 = "ab";
    printf("c dans aaabbaa ? %d\n", recherche(m1, texte));
    printf("ab dans aaabbaa ? %d\n", recherche(m2, texte));
    return 0;
}

int recherche(char *m, char* texte){
    return strstr(texte, m) == NULL ? -1 : strstr(texte, m)-texte;
}