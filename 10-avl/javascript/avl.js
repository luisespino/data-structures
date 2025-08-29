// MIT License
// Copyright (c) 2021 Luis Espino

class Node {
	constructor(value) {
		this.value 	= value
		this.left 	= null
		this.right 	= null
		this.height = 0
	}
}

class AVL {
	constructor() {
		this.root = null
        this.dot = ''
	}

	add(value) {
		this.root = this._add(value, this.root)
    }

    _add(value, tmp) {
		if (tmp == null) return new Node(value)
		else if (value < tmp.value) {
			tmp.left = this._add(value, tmp.right)
			if ((this.height(tmp.left)-this.height(tmp.right))==2) {
				if (value < tmp.left.value) tmp = this.srl(tmp)
				else tmp = this.drl(tmp)
			}
		} else if (value > tmp.value) {
			tmp.right = this._add(value, tmp.right)
			if ((this.height(tmp.right)-this.height(tmp.left))==2) {
				if (value > tmp.right.value) tmp = this.srr(tmp)
				else tmp = this.drr(tmp)
			} 
		}
		
		var r = this.height(tmp.right)
		var l = this.height(tmp.left)		
		var m = this.max(r, l)
		tmp.height = m + 1
		return tmp		
    }

	height(tmp) {
		if (tmp == null) return -1
		return tmp.height
	}

	max(val1, val2) {
		if (val1 > val2) return val1
		return val2
	}

	srl(t1) {
		var t2
		t2 = t1.left
		t1.left = t2.right
		t2.right = t1
		t1.height = max(this.height(t1.left), this.height(t1.right)) + 1
		t2.height = max(this.height(t2.left), t1.height) + 1
		return t2
	}
	
	drl(tmp) {
		tmp.left = this.srr(tmp.left)		
		return this.srl(tmp)
	}

	srr(t1) {
		var t2
		t2 = t1.right
		t1.right = t2.left
		t2.left = t1		
		t1.height = this.max(this.height(t1.left), this.height(t1.right)) + 1
		t2.height = this.max(this.height(t2.right), t1.height) + 1
		return t2
	}
	
	drr(tmp) {
		tmp.right = this.srl(tmp.right)
		return this.srr(tmp)
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

			
			/*
			if (tmp.left == null)
				this.dot += tmp.value+'-- '+tmp.right.value+';'
			if (tmp.right != null && tmp.left !=null) 
				this.dot += tmp.value+'-- {'+tmp.left.value+' '+temp.right.value+'};'
			
			else if (tmp.right == null)
				this.dot += tmp.value+'-- {'+tmp.left.value+' null};'
				*/
            this.dotgen(tmp.left)
            this.dotgen(tmp.right)
        }
    }
}

function avl() {
    var avl = new AVL()
    avl.add(5)
    avl.add(10)	
    avl.add(20)
    avl.add(25)
    avl.add(30)
    avl.add(35)
    avl.add(40)
    document.getElementById("log").innerHTML+='Preorder:  '
    avl.preorder(avl.root)
    document.getElementById("log").innerHTML+='<br>Inorder:   '
    avl.inorder(avl.root)
    document.getElementById("log").innerHTML+='<br>Postorder: '
    avl.postorder(avl.root)
    avl.dot = '{'
    avl.dotgen(avl.root)
    avl.dot += '}'
    return avl.dot
}
