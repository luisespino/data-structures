class Node {
	constructor(value) {
		this.value 	= value
		this.left 	= null
		this.right 	= null
	}
}

class BST {
	constructor() {
		this.root = null
        this.dot = ''
	}

	add(value) {
        if (this.root != null) this._add(value, this.root)
        else this.root = new Node(value)
    }

    _add(value, tmp) {
        if (value < tmp.value) {
            if (tmp.left != null) this._add(value,tmp.left)
            else tmp.left = new Node(value)
        } else {
            if (tmp.right != null) this._add(value,tmp.right)
            else tmp.right = new Node(value)
        }
    }

    preorder(tmp) {
        if (tmp != null) {
            document.getElementById("log").innerHTML+=tmp.value+' '
            this.preorder(tmp.left)
            this.preorder(tmp.right)
        }
    }

    inorder(tmp) {
        if (tmp != null) {
            this.inorder(tmp.left)
            document.getElementById("log").innerHTML+=tmp.value+' '
            this.inorder(tmp.right)
        }

    }

    postorder(tmp) {
        if (tmp != null) {
            this.postorder(tmp.left)
            this.postorder(tmp.right)
            document.getElementById("log").innerHTML+=tmp.value+' '
        }
    }

    dotgen(tmp) {
        if (tmp != null) {
            if (tmp.left != null) this.dot += tmp.value+'--'+tmp.left.value+';'
            if (tmp.right != null) this.dot += tmp.value+'--'+tmp.right.value+';'
            this.dotgen(tmp.left)
            this.dotgen(tmp.right)
        }
    }
}

function bst() {
    var bst = new BST()
    bst.add(25)
    bst.add(10)
    bst.add(5)
    bst.add(20)
    bst.add(35)
    bst.add(30)
    bst.add(40)
    document.getElementById("log").innerHTML+='Preorder:  '
    bst.preorder(bst.root)
    document.getElementById("log").innerHTML+='<br>Inorder:   '
    bst.inorder(bst.root)
    document.getElementById("log").innerHTML+='<br>Postorder: '
    bst.postorder(bst.root)
    bst.dot = '{'
    bst.dotgen(bst.root)
    bst.dot += '}'
    return bst.dot
}

