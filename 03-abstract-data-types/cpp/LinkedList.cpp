#include <iostream>

class Node
{
public:
    int data;
    Node* next;
    Node (int data_) : data(data_), next(0) {}
};

class LinkedList
{
public:
    Node* head = 0;
    void addStart(int data)
    {
        Node* tmp = new Node(data);
        tmp->next = head;
        head = tmp;
    }

    void show()
    {
        Node* tmp = head;
        while (tmp != 0)
        {
            std::cout << tmp->data << std::endl;
            tmp = tmp->next;
        }
    }
};

int main()
{
    LinkedList *list1 = new LinkedList();
    list1->addStart(5);
    list1->addStart(10);
    list1->addStart(7);
    list1->show();
    return 0;
}
