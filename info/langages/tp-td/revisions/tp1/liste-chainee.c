#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct list
{
    int elmt;
    struct list* next;
}typedef list;



list* add(list *l, int e);
void print_liste(list *l);
list *del(list *l);

int main(){
    list n1; list n2; list n3;
    n1.elmt = 1; n2.elmt = 2; n3.elmt = 3;
    n1.next = &n2; n2.next = &n3; n3.next = NULL;
    list* lc = &n1;
    print_liste(lc);
    lc = add(lc, 4);
    print_liste(lc);
    lc = del(lc);
    print_liste(lc);

}

list* add(list *l, int e){
    list * new = (list*) malloc(sizeof(list));
    new->elmt = e; new->next = l;
    return new;
}

void print_liste(list *l){
    list* actual = l;
    while(actual != NULL){
        printf("%d ", actual->elmt);
        actual = actual->next;
    }
    printf("\n");
}

list *del(list *l){
    list* new = l->next;
    free(l);
    return new;
}

// 5- On a implémenté une pile