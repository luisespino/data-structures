// Luis Espino 2022

class Node {
	int value;
	Node left;
	Node right;
	
	Node(int value){
		this.value = value;
		left = null;
		right = null;
	}
}


public class BST {
	Node root = null;
	
	void add(int value) {
		if (root != null)
			add(value, root);
		else
			root = new Node(value);
	}
	
	void add(int value, Node tmp) {
		if (value < tmp.value) {
			if (tmp.left != null)
				add(value, tmp.left);
			else
				tmp.left = new Node(value);
		}
		else {
			if (tmp.right != null)
				add(value, tmp.right);
			else
				tmp.right = new Node(value);
		}
	}
	
	void preorder(Node tmp) {
		if (tmp != null) {
			System.out.print(tmp.value+" ");
			preorder(tmp.left);
			preorder(tmp.right);
		}
	}

	void enorder(Node tmp) {
		if (tmp != null) {			
			enorder(tmp.left);
			System.out.print(tmp.value+" ");
			enorder(tmp.right);
		}
	}
	
	void postorder(Node tmp) {
		if (tmp != null) {			
			postorder(tmp.left);
			postorder(tmp.right);
			System.out.print(tmp.value+" ");			
		}
	}
	
	public static void main(String[] args) {
		BST bst = new BST();
		bst.add(25);bst.add(10);
        bst.add(35);bst.add(5);
        bst.add(20);bst.add(30);
        bst.add(40);
		bst.preorder(bst.root);
		System.out.println();
		bst.enorder(bst.root);
		System.out.println();
		bst.postorder(bst.root);
	}   
}
