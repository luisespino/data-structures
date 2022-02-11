class SparseNode {
    Object data;
    int row, col;
    SparseNode up;
    SparseNode down;
    SparseNode right;
    SparseNode left;

    public SparseNode(Object data, int row, int col) {
        this.data = data;
        this.row = row;
        this.col = col;
        up = down = right = left = null;
    }
}

public class SparseMatrix {
    SparseNode head;

    public SparseMatrix() {
        head = new SparseNode("XX", 0, 0);
    }

    void add(Object data, int row, int col) {        
        SparseNode ci  = null; // col iterator
        SparseNode cip = null; // col iterator preview
        SparseNode ri  = null; // row iterator
        SparseNode rip = null; // row iterator preview

        boolean update = false;
        SparseNode newnode = null;
        
        // bind column
        ci = head; // col iterator
        cip = null; // col iterator preview
        while (ci!=null) {
            if (ci.col == col) {
                // search row
                ri = ci; // row iterator
                rip = null; // row iterator preview
                while (ri!=null) {
                    if (ri.row == row) {                        
                        // update
                        ri.data = data;
                        update = true;
                        break;
                    } else if (ri.row > row) {
                        // add at middle
                        newnode = new SparseNode(data, row, col);
                        newnode.up = rip;
                        newnode.down = ri;
                        rip.down = newnode;
                        ri.up = newnode;
                        if (col==0) update = true;
                        break;
                    } else if (ri.down == null) {
                        // add at end
                        newnode = new SparseNode(data, row, col);
                        newnode.up = ri;
                        ri.down = newnode;
                        if (col==0) update = true;
                        break;
                    }
                    rip = ri;
                    ri = ri.down;
                }
                break;
            } else if (ci.col > col) {
                // add at middle
                if (row == 0) {
                    newnode = new SparseNode(data, row, col);
                    newnode.left = cip;
                    newnode.right = ci;
                    cip.right = newnode;
                    ci.left = newnode;
                    update = true;  
                } else {
                    SparseNode tmp = new SparseNode("XX", 0, col);
                    tmp.left = cip;
                    tmp.right = ci;
                    cip.right = tmp;
                    ci.left = tmp;
                    newnode = new SparseNode(data, row, col);
                    tmp.down = newnode;
                    newnode.up = tmp;                                    
                }
                break;
            } else if (ci.right == null) {
                // add at end
                if (row == 0) {
                    newnode = new SparseNode(data, row, col);
                    newnode.left = ci;
                    ci.right = newnode;
                    update = true;
                } else {
                    SparseNode tmp = new SparseNode("XX", 0, col);
                    tmp.left = ci;
                    ci.right = tmp;
                    newnode = new SparseNode(data, row, col);
                    tmp.down = newnode;
                    newnode.up = tmp;
                }
                break;
            }            
            cip = ci;
            ci = ci.right;
        }

        // bind row        
        if (!update) {
            ri = head; // col iterator
            rip = null; // col iterator preview
            while (ri!=null) {
                if (ri.row == row) {
                    // search col
                    ci = ri; // col iterator
                    cip = null; // col iterator preview
                    while (ci!=null) {
                        if (ci.col > col) {
                            // add at middle                            
                            newnode.left = cip;
                            newnode.right = ci;
                            cip.right = newnode;
                            ci.left = newnode;
                            break;
                        } else if (ci.right == null) {
                            // add at end
                            newnode.left = ci;
                            ci.right = newnode;
                            break;
                        }
                        cip = ci;
                        ci = ci.right;
                    }
                    break;
                } else if (ri.row > row) {
                    // add at middle
                    if (col == 0) {
                        newnode.up = cip;
                        newnode.down = ci;
                        cip.down = newnode;
                        ci.up = newnode;
                    } else {
                        SparseNode tmp = new SparseNode("XX", row, 0);
                        tmp.up = cip;
                        tmp.down = ci;
                        cip.down = tmp;
                        ci.up = tmp;
                        // newnode bind
                        tmp.right = newnode;
                        newnode.left = tmp;    
                    }
                    break;
                } else if (ri.down == null) {
                    // add at end
                    if (col == 0) {
                        newnode.up = cip;
                        newnode.down = ci;
                        cip.down = newnode;
                        ci.up = newnode;
                    } else {
                        SparseNode tmp = new SparseNode("XX", row, 0);
                        tmp.up = ri;
                        ri.down = tmp;
                        //newnode bind
                        tmp.right = newnode;
                        newnode.left = tmp;
                    }
                    break;
                }
                rip = ri;
                ri = ri.down;
            }    
        }
    }

    void printRef(int dim) {
        SparseNode r, c;
        r = head;
        for (int i = 0; i < dim; i++) {
            if (r!=null) {
                if (r.row == i) {
                    c = r;
                    for (int j = 0; j < dim; j++) {                        
                        if (c != null) {
                            if (c.col == j) {
                                System.out.print(c.data+" ");
                                c = c.right;
                            } else System.out.print("-- "); // empty col at middle
                        } else System.out.print("-- "); // empty col at end
                    }
                    r = r.down;            
                } else { // empty row at middle
                    for (int j = 0; j < dim; j++) {
                        System.out.print("-- ");
                    }
    
                }                
            } else { //empty row at end
                System.out.print("!");
                for (int j = 0; j < dim; j++) {
                    System.out.print("-- ");
                }
            }
            System.out.println();            
        }

    }

    public static void main(String [] args) {
        SparseMatrix sp = new SparseMatrix();
        //sp.add("00", 0, 0);
        sp.add("02", 0, 2);
        //sp.add("03", 0, 3);
        //sp.add("11", 1, 1);
        //sp.add("11", 1, 3);
        sp.add("20", 2, 0);
        sp.add("22", 2, 2);
        //sp.add("30", 3, 0);
        sp.add("31", 3, 1);
        sp.add("33", 3, 3);
        //sp.add("YY", 1, 3);
        sp.printRef(4);
    }    
}
