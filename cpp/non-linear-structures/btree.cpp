// BTree Knuth Implementation
// Luis Espino 2024

#include <iostream>

// order 4
#define MAX 3
#define MIN 1

using namespace std;

class BTreeNode
{
    public:
    int val[MAX + 1];
    int num = 0;
    BTreeNode *link[MAX + 1];
};

class BTree
{
    public:
    BTreeNode *root = nullptr;

    void insert(int val)
    {
        int i;
        BTreeNode *child = nullptr;
        if (setValue(val, &i, root, &child))
            root = createNode(i, child);
    }

    int setValue(int val, int *pval, 
        BTreeNode *node, BTreeNode **child)
    {
        int pos;
        if (!node)
        {
            *pval = val;
            *child = nullptr;
            return 1;
        }

        if (val < node->val[1]) 
        {
            pos = 0;
        }
        else
        {
            for (pos = node->num;
                (val < node->val[pos] && pos > 1); pos--);
            if (val == node->val[pos]) 
            {
                cout << "Duplicates not allowed" << endl;
                return 0;
            }
        }
        if (setValue(val, pval, node->link[pos], child))
        {
            if (node->num < MAX)
            {
                insertNode(*pval, pos, node, *child);
            } 
            else 
            {
                splitNode(*pval, pval, pos, node, *child, child);
                return 1;
            }
        }
        return 0;
    }

    BTreeNode* createNode(int val, BTreeNode *child)
    {
        BTreeNode *newNode = new BTreeNode();
        newNode->val[1] = val;
        newNode->num = 1;
        newNode->link[0] = root;
        newNode->link[1] = child;
        return newNode;
    }

    void insertNode(int val, int pos, 
        BTreeNode *node, BTreeNode *child)
    {
        int j = node->num;
        while (j > pos) {
            node->val[j + 1] = node->val[j];
            node->link[j + 1] = node->link[j];
            j--;
        }
        node->val[j + 1] = val;
        node->link[j + 1] = child;
        node->num++;
    }

    void splitNode(int val, int *pval, int pos, 
        BTreeNode *node, BTreeNode *child, BTreeNode **newNode)
    {
        int median, j;
        if (pos > MIN)
            median = MIN + 1;
        else
            median = MIN;
        *newNode = new BTreeNode();
        j = median + 1;
        while (j <= MAX)
        {
            (*newNode)->val[j - median] = node->val[j];
            (*newNode)->link[j - median] = node->link[j];
            j++;
        }
        node->num = median;
        (*newNode)->num = MAX - median;

        if (pos <= MIN)
        {
            insertNode(val, pos, node, child);
        } 
        else
        {
            insertNode(val, pos - median, *newNode, child);
        }
        *pval = node->val[node->num];
        (*newNode)->link[0] = node->link[node->num];
        node->num--;
    }

    void traversal(BTreeNode *myNode)
    {
        int i;
        if (myNode)
        {
            cout << "[";
            for (i = 0; i < myNode->num; i++)
            {
                //traversal(myNode->link[i]);
                cout << myNode->val[i + 1] << ",";
            }
            for (i = 0; i <= myNode->num; i++)
            {
                traversal(myNode->link[i]);
            }
            cout << "]";
        }
    }

};

int main()
{
    BTree *t = new BTree();
    t->insert(5);t->insert(10);
    t->insert(15);t->insert(20);
    t->insert(25);t->insert(30);
    t->insert(35);t->insert(40);
    t->insert(45);t->insert(50);
    t->traversal(t->root);cout << endl;
}

