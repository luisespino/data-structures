#include <iostream>

using namespace std;

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
            cout << tmp->data << " ";
            tmp = tmp->next;
        }
    }

};

int main()
{
    LinkedList *a[5];
    for (int i=0; i<5; i++)
        a[i] = new LinkedList();
    a[1%5]->addStart(1);
    a[3%5]->addStart(3);
    a[6%5]->addStart(6);
    a[8%5]->addStart(8);
    a[14%5]->addStart(14);
    for (int i=0; i<5; i++)
    {
        cout << i << " -> ";
        a[i]->show();
        cout << endl;
    }
    return 0;
}
