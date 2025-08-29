// Luis Espino 2022

class NodeAVL {
	int value;
	NodeAVL left;
	NodeAVL right;
    int alt;
	
	NodeAVL(int value){
		this.value = value;
		left = null;
		right = null;
        alt = 0;
	}
}


public class AVL {
	NodeAVL root = null;
	
	void add(int value) {
		root = add(value, root);
	}
	
	NodeAVL add(int value, NodeAVL tmp) {
        if (tmp == null) tmp = new NodeAVL(value);
		else if (value < tmp.value) {
            tmp.left = add(value, tmp.left);
            if ((altura(tmp.left)-altura(tmp.right))==2) {
                if (value<tmp.left.value) tmp = srl(tmp);
                else tmp = drl(tmp);
            }            
		}
		else {
            tmp.right = add(value, tmp.right);
            if ((altura(tmp.right)-altura(tmp.left))==2) {
                if (value>tmp.right.value) tmp = srr(tmp);
                else tmp = drr(tmp);
            }            

		}
        int d, i, m;
        d = altura(tmp.right);
        i = altura(tmp.left);
        m = maxi(d,i);
        tmp.alt = m + 1;
        return tmp;
	}

    int altura(NodeAVL tmp) {
        if (tmp == null) return -1;
        else return tmp.alt;
    }

    int maxi(int val1, int val2) {
        return ((val1 > val2) ? val1 : val2);
    }

    NodeAVL srl(NodeAVL t1) {
        NodeAVL t2;
        t2 = t1.left;
        t1.left = t2.right;
        t2.right = t1;
        t1.alt = maxi(altura(t1.left), altura(t1.right))+1;
        t2.alt = maxi(altura(t2.left),t1.alt)+1;
        return t2;
    }

    NodeAVL srr(NodeAVL t1) {
        NodeAVL t2;
        t2 = t1.right;
        t1.right = t2.left;
        t2.left = t1;
        t1.alt = maxi(altura(t1.left), altura(t1.right))+1;
        t2.alt = maxi(altura(t2.right),t1.alt)+1;
        return t2;
    }

    NodeAVL drl(NodeAVL tmp) {
        tmp.left = srr(tmp.left);
        return srl(tmp);
    }

    NodeAVL drr(NodeAVL tmp) {
        tmp.right = srl(tmp.right);
        return srr(tmp);
    }
	
	void preorder(NodeAVL tmp) {
		if (tmp != null) {
			System.out.print(tmp.value+" ");
			preorder(tmp.left);
			preorder(tmp.right);
		}
	}

	void enorder(NodeAVL tmp) {
		if (tmp != null) {			
			enorder(tmp.left);
			System.out.print(tmp.value+" ");
			enorder(tmp.right);
		}
	}
	
	void postorder(NodeAVL tmp) {
		if (tmp != null) {			
			postorder(tmp.left);
			postorder(tmp.right);
			System.out.print(tmp.value+" ");			
		}
	}
	
	public static void main(String[] args) {
		AVL a = new AVL();
        a.add(5);a.add(10);
        a.add(20);a.add(25);
		a.add(30);a.add(35);              
        a.add(40);
		a.preorder(a.root);
		System.out.println();
		a.enorder(a.root);
		System.out.println();
		a.postorder(a.root);
	}   
}
