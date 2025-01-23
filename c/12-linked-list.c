#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

typedef struct LinkedList {
    Node* head;
} LinkedList;

Node* createNode(int data) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data = data;
    newNode->next = NULL;
    return newNode;
}

void addStart(LinkedList* list, int data) {
    Node* tmp = createNode(data);
    tmp->next = list->head;
    list->head = tmp;
}

void show(LinkedList* list) {
    Node* tmp = list->head;
    while (tmp != NULL) {
        printf("%d\n", tmp->data);
        tmp = tmp->next;
    }
}

// Función principal
int main() {
    LinkedList* list1 = (LinkedList*)malloc(sizeof(LinkedList));
    list1->head = NULL; 

    addStart(list1, 10);
    addStart(list1, 20);
    addStart(list1, 30);

    show(list1);

    Node* tmp;
    while (list1->head != NULL) {
        tmp = list1->head;
        list1->head = list1->head->next;
        free(tmp);
    }
    free(list1);

    return 0;
}
