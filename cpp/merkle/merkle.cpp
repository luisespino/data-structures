#include <iostream>
#include <string>
#include <cmath>

using namespace std;

class DataNode {
public:
    int value;
    DataNode *next;
    DataNode(int value_) : value(value_), next(nullptr) {}
};


class HashNode {
public:
    int hash;
    HashNode *left;
    HashNode *right;
    DataNode *down;
    HashNode(int hash_) : hash(hash_), left(nullptr), right(nullptr), down(nullptr) {}
};

class Merkle {
public:
    HashNode *tophash;
    DataNode **datablock;
    string dot;
    int max;
    int index;

    Merkle(int max_) : tophash(nullptr), max(max_), index(0)  {
        datablock = new DataNode*[max];
    }

    void add(int value) {
        datablock[index++] = new DataNode(value);
        //cout  << datablock[index-1]->value << endl;
    }

    void createTree(int exp) {
        tophash = new HashNode(0);
        createTree(tophash, exp);
    }

    void createTree(HashNode *tmp, int exp) {
        if (exp > 0) {
            tmp->left = new HashNode(0);
            tmp->right = new HashNode(0);
            createTree(tmp->left, exp - 1);
            createTree(tmp->right, exp - 1);
        }
    }

    void genHash(HashNode *tmp, int n) { // postorder
        if (tmp != nullptr) {
            genHash(tmp->left, n);
            genHash(tmp->right, n);
            
            if (tmp->left == nullptr && tmp->right == nullptr) {
                tmp->down = datablock[n-index];
                index--;
                tmp->hash = tmp->down->value*10;
            } else {
                tmp->hash = (tmp->left->hash + tmp->right->hash)*10;
            }
        }
    }

    void preorder(HashNode* tmp) {
        if (tmp != nullptr) {
            //if (tmp->down != nullptr) {
            //    cout << "DB:" << tmp->down->value << ' ';
            //} else {
                cout << tmp->hash << ' ';
            //}
            preorder(tmp->left);
            preorder(tmp->right);
        }
    }

    void auth() {
        int exp = 1;
        while (pow(2, exp) < (index + 1)) {
            exp += 1;
        }
        for (int i = index  ; i < pow(2, exp); i++) {
            datablock[index++] = new DataNode(i*100);
        }
        /*for (int i = 0; i < index; i++) {
            cout << datablock[i]->value << endl;
        }*/
        //index = pow(2, exp);
        createTree(exp);
        genHash(tophash, index);
        preorder(tophash);
    }

    void show() {
        for (int i = 0; i < (index + 1); i++) {
            cout << datablock[i]->value << ' ';
        }
    }

    void dotgen(HashNode* tmp) {
        if (tmp != nullptr) {
            dot += to_string(tmp->hash) + " [label=\"" + to_string(tmp->hash) + "\"];";
            if (tmp->left != nullptr) {
                dot += to_string(tmp->hash) + "--" + to_string(tmp->left->hash) + ";";           
            }
            if (tmp->right != nullptr) {
                dot += to_string(tmp->hash) + "--" + to_string(tmp->right->hash) + ";";           
            }
            dotgen(tmp->left);
            dotgen(tmp->right);
            if (tmp->left == nullptr && tmp->right == nullptr && tmp->down != nullptr) {
                dot += to_string(tmp->down->value) + " [label=\"" + to_string(tmp->down->value) + "\" shape=rect];";
                dot += to_string(tmp->hash) + "--" + to_string(tmp->down->value) + ";";
            }
        }
    }
};

int main() {
    Merkle *m = new Merkle(8);
    m->add(4);
    m->add(5);
    m->add(6);
    m->add(7);
    m->add(8);
    m->auth();
    m->dot = "graph{";
    m->dotgen(m->tophash);
    m->dot += '}';
    
    std::cout << m->dot << std::endl;

    return 0;
}
