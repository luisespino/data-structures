#include <iostream>

class Node
{
public:
    int val;
    Node* izq;
    Node* der;
    int alt;
    Node (int val_) : val(val_), izq(0), der(0), alt(0) {}
};

class AVLTree
{
public:
    Node *raiz;
    AVLTree () : raiz(0) {}
    void add(int val)
    {
        if (raiz!=0) add(val, raiz);
        else raiz = new Node(val);
    }
    void add(int val, Node* &tmp)
    {
        if (tmp==0) tmp = new Node(val);
        else if (val<tmp->val)
        {
            add(val, tmp->izq);
            if ((altura(tmp->izq)-altura(tmp->der))==2)
            {
                if (val<tmp->izq->val) tmp = srl(tmp);
                else tmp = drl(tmp);
            }
        }
        else if (val>tmp->val)
        {
            add(val, tmp->der);
            if ((altura(tmp->der)-altura(tmp->izq))==2)
            {
                if (val>tmp->der->val) tmp = srr(tmp);
                else tmp = drr(tmp);
            }
        }
        int d,i,m;
        d = altura(tmp->der);
        i = altura(tmp->izq);
        m = maxi(d,i);
        tmp->alt = m + 1;
    }
    int altura(Node* tmp)
    {
        if (tmp==0) return -1;
        else return tmp->alt;
    }
    void preorden(Node* tmp)
    {
        if (tmp!=0)
        {
            std::cout << tmp->val << " ";
            preorden(tmp->izq);
            preorden(tmp->der);
        }
    }
    void enorden(Node* tmp)
    {
        if (tmp!=0)
        {
            enorden(tmp->izq);
            std::cout << tmp->val << " ";
            enorden(tmp->der);
        }
    }
    void postorden(Node* tmp)
    {
        if (tmp!=0)
        {
            postorden(tmp->izq);
            postorden(tmp->der);
            std::cout << tmp->val << " ";
        }
    }
    Node* srl(Node* t1)
    {
        Node* t2;
        t2 = t1->izq;
        t1->izq = t2->der;
        t2->der = t1;
        t1->alt = maxi(altura(t1->izq), altura(t1->der))+1;
        t2->alt = maxi(altura(t2->izq),t1->alt)+1;
        return t2;
    }
    Node* srr(Node* t1)
    {
        Node* t2;
        t2 = t1->der;
        t1->der = t2->izq;
        t2->izq = t1;
        t1->alt = maxi(altura(t1->izq), altura(t1->der))+1;
        t2->alt = maxi(altura(t2->der),t1->alt)+1;
        return t2;
    }
    Node* drl(Node* tmp)
    {
        tmp->izq = srr(tmp->izq);
        return srl(tmp);
    }
    Node* drr(Node* tmp)
    {
        tmp->der = srl(tmp->der);
        return srr(tmp);
    }
    int maxi(int val1, int val2)
    {
        return ((val1 > val2) ? val1 : val2);
    }

    int magic(Node* tmp)
    {
        if (tmp!=0)
            return tmp->val+magic(tmp->der)-magic(tmp->izq);
        return 0;
    }
};

int main()
{
    AVLTree* t = new AVLTree();
    //t->add(22);t->add(7);t->add(8);t->add(15);t->add(20);t->add(28);
    //t->add(31);t->add(23);t->add(2);t->add(5);t->add(7);t->add(13);
    //t->add(25);t->add(2);t->add(15);t->add(14);t->add(20);t->add(11);
    //t->add(5);t->add(1);t->add(50);t->add(21);t->add(44);t->add(10);
     //t->add(13);t->add(5);t->add(7);t->add(23);t->add(2);t->add(31);
    //t->add(40);t->add(30);t->add(20);
    //t->add(5);t->add(35);t->add(10);
    //t->add(30);t->add(20);
    //t->add(5); t->add(35); t->add(10);t->add(25);
    //t->add(25);t->add(10);t->add(35); t->add(5);
    //t->add(20); t->add(30);t->add(40);
    t->add(5);t->add(10);t->add(15); t->add(20);
    t->add(25);t->add(30);t->add(35);

    t->preorden(t->raiz);std::cout<<"\n";
    t->enorden(t->raiz);std::cout<<"\n";
    t->postorden(t->raiz);std::cout<<"\n";
    //std::cout << t->altura(t->raiz);
    //std::cout << t->magic(t->raiz);
    return 0;
}