#include <iostream>
#include <queue>

using namespace std;

class Node
{
public:
    int val;
    Node* left;
    Node* right;
    Node (int val_) : val(val_), left(0), right(0) {}
};

class BSTree
{
public:
    Node* root;
    BSTree () : root(0) {}

    void add(int val)
    {
        if (root != 0) add(val, root);
        else root = new Node(val);
    }

    void add(int val, Node* tmp)
    {
        if (val<tmp->val)
        {
            if (tmp->left!=0) add(val, tmp->left);
            else tmp->left = new Node(val);
        }
        else
        {
            if (tmp->right!=0) add(val, tmp->right);
            else tmp->right = new Node(val);
        }
    }

    // also called depth traversal with backtracking
    void preorder(Node* tmp)
    {
        if (tmp!=0)
        {
            cout << tmp->val << " ";
            preorder(tmp->left);
            preorder(tmp->right);
        }
    }

    void inorder(Node* tmp)
    {
        if (tmp!=0)
        {
            inorder(tmp->left);
            cout << tmp->val << " ";
            inorder(tmp->right);
        }
    }

    void postorder(Node* tmp)
    {
        if (tmp!=0)
        {
            postorder(tmp->left);
            postorder(tmp->right);
            cout << tmp->val<< " ";
        }
    }

    // also called breadth traversal
    void levelorder(Node* tmp)
    {
        if (tmp == 0) return;

        queue<Node*> q;
        q.push(tmp);

        while (!q.empty())
        {
            Node *node = q.front();
            cout << node->val << " ";
            q.pop();

            if (node->left != 0) q.push(node->left);
            if (node->right != 0) q.push(node->right);
        }
    }

};

int main()
{
    BSTree* t = new BSTree();
    t->add(25);t->add(10);t->add(35); t->add(5);
    t->add(20); t->add(30);t->add(40);
    t->preorder(t->root);cout << endl;
    t->inorder(t->root);cout << endl;
    t->postorder(t->root);cout << endl;
    t->levelorder(t->root);cout << endl;
}

