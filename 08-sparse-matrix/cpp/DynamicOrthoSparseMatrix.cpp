// Luis Espino 2024

#include <iostream>
#include <string>

using namespace std;

class SparseNode {
public:
    string data;
    int row, col;
    SparseNode* up;
    SparseNode* down;
    SparseNode* right;
    SparseNode* left;

    SparseNode(const string& data, int row, int col)
        : data(data), row(row), col(col), up(nullptr), down(nullptr), right(nullptr), left(nullptr) {}
};

class SparseMatrix {
private:
    SparseNode* head;

public:
    SparseMatrix() {
        head = new SparseNode("XX", 0, 0);
    }

    ~SparseMatrix() {
        // Cleanup function to delete all nodes (not implemented here for brevity)
    }

    void add(const string& data, int row, int col) {
        SparseNode* ci = nullptr; // col iterator
        SparseNode* cip = nullptr; // col iterator preview
        SparseNode* ri = nullptr; // row iterator
        SparseNode* rip = nullptr; // row iterator preview

        bool update = false;
        SparseNode* newnode = nullptr;

        // bind column
        ci = head; // col iterator
        cip = nullptr; // col iterator preview
        while (ci != nullptr) {
            if (ci->col == col) {
                // search row
                ri = ci; // row iterator
                rip = nullptr; // row iterator preview
                while (ri != nullptr) {
                    if (ri->row == row) {
                        // update
                        ri->data = data;
                        update = true;
                        break;
                    } else if (ri->row > row) {
                        // add at middle
                        newnode = new SparseNode(data, row, col);
                        newnode->up = rip;
                        newnode->down = ri;
                        rip->down = newnode;
                        ri->up = newnode;
                        if (col == 0) update = true;
                        break;
                    } else if (ri->down == nullptr) {
                        // add at end
                        newnode = new SparseNode(data, row, col);
                        newnode->up = ri;
                        ri->down = newnode;
                        if (col == 0) update = true;
                        break;
                    }
                    rip = ri;
                    ri = ri->down;
                }
                break;
            } else if (ci->col > col) {
                // add at middle
                if (row == 0) {
                    newnode = new SparseNode(data, row, col);
                    newnode->left = cip;
                    newnode->right = ci;
                    cip->right = newnode;
                    ci->left = newnode;
                    update = true;
                } else {
                    SparseNode* tmp = new SparseNode("XX", 0, col);
                    tmp->left = cip;
                    tmp->right = ci;
                    cip->right = tmp;
                    ci->left = tmp;
                    newnode = new SparseNode(data, row, col);
                    tmp->down = newnode;
                    newnode->up = tmp;
                }
                break;
            } else if (ci->right == nullptr) {
                // add at end
                if (row == 0) {
                    newnode = new SparseNode(data, row, col);
                    newnode->left = ci;
                    ci->right = newnode;
                    update = true;
                } else {
                    SparseNode* tmp = new SparseNode("XX", 0, col);
                    tmp->left = ci;
                    ci->right = tmp;
                    newnode = new SparseNode(data, row, col);
                    tmp->down = newnode;
                    newnode->up = tmp;
                }
                break;
            }
            cip = ci;
            ci = ci->right;
        }

        // bind row
        if (!update) {
            ri = head; // col iterator
            rip = nullptr; // col iterator preview
            while (ri != nullptr) {
                if (ri->row == row) {
                    // search col
                    ci = ri; // col iterator
                    cip = nullptr; // col iterator preview
                    while (ci != nullptr) {
                        if (ci->col > col) {
                            // add at middle
                            newnode->left = cip;
                            newnode->right = ci;
                            cip->right = newnode;
                            ci->left = newnode;
                            break;
                        } else if (ci->right == nullptr) {
                            // add at end
                            newnode->left = ci;
                            ci->right = newnode;
                            break;
                        }
                        cip = ci;
                        ci = ci->right;
                    }
                    break;
                } else if (ri->row > row) {
                    // add at middle
                    if (col == 0) {
                        newnode->up = rip;
                        newnode->down = ri;
                        rip->down = newnode;
                        ri->up = newnode;
                    } else {
                        SparseNode* tmp = new SparseNode("XX", row, 0);
                        tmp->up = rip;
                        tmp->down = ri;
                        rip->down = tmp;
                        ri->up = tmp;
                        // newnode bind
                        tmp->right = newnode;
                        newnode->left = tmp;
                    }
                    break;
                } else if (ri->down == nullptr) {
                    // add at end
                    if (col == 0) {
                        newnode->up = rip;
                        newnode->down = ri;
                        rip->down = newnode;
                        ri->up = newnode;
                    } else {
                        SparseNode* tmp = new SparseNode("XX", row, 0);
                        tmp->up = ri;
                        ri->down = tmp;
                        // newnode bind
                        tmp->right = newnode;
                        newnode->left = tmp;
                    }
                    break;
                }
                rip = ri;
                ri = ri->down;
            }
        }
    }

    void printRef(int dim) {
        SparseNode* r = head;
        for (int i = 0; i < dim; ++i) {
            if (r != nullptr) {
                if (r->row == i) {
                    SparseNode* c = r;
                    for (int j = 0; j < dim; ++j) {
                        if (c != nullptr) {
                            if (c->col == j) {
                                cout << c->data << " ";
                                c = c->right;
                            } else {
                                cout << "-- ";
                            }
                        } else {
                            cout << "-- ";
                        }
                    }
                    r = r->down;
                } else {
                    for (int j = 0; j < dim; ++j) {
                        cout << "-- ";
                    }
                }
            } else {
                for (int j = 0; j < dim; ++j) {
                    cout << "-- ";
                }
            }
            cout << endl;
        }
    }
};

int main() {
    SparseMatrix sp;
    sp.add("00", 0, 0);
    sp.add("02", 0, 2);
    sp.add("03", 0, 3);
    sp.add("11", 1, 1);
    sp.add("22", 2, 2);
    sp.add("30", 3, 0);
    sp.add("33", 3, 3);
    sp.printRef(4);
    return 0;
}
