class Node:
    def __init__(self, value):
        self.value = value
        self.previous = None
        self.next = None
        self.right = None
        self.left = None


class Branch:
    def __init__(self):
        self.count = 0
        self.leaf = True
        self.root = None

    def insert(self, node):
        if self.root is None:
            self.root = node
            self.count += 1
        else:
            temp = self.root
            while temp is not None:
                if node.value <= temp.value:
                    self.count += 1
                    if temp == self.root:
                        self.root.previous = node
                        self.root.left = node.right
                        self.root = node
                        break
                    else:
                        node.previous = temp.previous
                        node.next = temp
                        temp.previous.next = node
                        temp.previous.right = node.left
                        temp.previous = node
                        temp.left = node.right
                        break
                elif temp.next is None:
                    self.count += 1
                    temp.next = node
                    temp.right = node.left
                    node.previous = temp
                    node.next = None
                    break
                temp = temp.next

    def traversal(self):
        result = []
        temp = self.root
        while temp is not None:
            result.append(temp.value)
            temp = temp.next
        return result


class BTree:
    def __init__(self, order):
        self.root = None
        self.order = order

    def insert(self, value):
        node = Node(value)
        if self.root is None:
            self.root = Branch()
            self.root.insert(node)
        else:
            temp = self._add(node, self.root)
            if isinstance(temp, Node):
                new_root = Branch()
                new_root.insert(temp)
                new_root.leaf = False
                self.root = new_root

    def _add(self, node, branch):
        if branch.leaf:
            branch.insert(node)
            if branch.count == self.order:
                return self._split_branch(branch)
            else:
                return branch
        else:
            temp = branch.root
            while temp is not None:
                if node.value == temp.value:
                    return branch
                elif node.value < temp.value:
                    aux = self._add(node, temp.left)
                    if isinstance(aux, Node):
                        branch.insert(aux)
                        if branch.count == self.order:
                            return self._split_branch(branch)
                    return branch
                elif temp.next is None:
                    aux = self._add(node, temp.right)
                    if isinstance(aux, Node):
                        branch.insert(aux)
                        if branch.count == self.order:
                            return self._split_branch(branch)
                    return branch
                temp = temp.next
        return branch

    def _split_branch(self, branch):
        right_branch = Branch()
        left_branch = Branch()
        middle = None
        temp = branch.root

        # Calculate middle position
        middle_index = self.order // 2
        current_index = 0
        
        # Collect all values and children
        values = []
        left_children = []
        right_children = []
        
        while temp is not None:
            values.append(temp.value)
            left_children.append(temp.left)
            right_children.append(temp.right)
            temp = temp.next
        
        # Create new branches without the middle value
        for i in range(len(values)):
            if i == middle_index:
                middle = Node(values[i])
            elif i < middle_index:
                new_node = Node(values[i])
                new_node.left = left_children[i]
                new_node.right = right_children[i]
                left_branch.insert(new_node)
            else:
                new_node = Node(values[i])
                new_node.left = left_children[i]
                new_node.right = right_children[i]
                right_branch.insert(new_node)

        # Set up the middle node connections
        middle.left = left_branch
        middle.right = right_branch
        
        # Update leaf status
        left_branch.leaf = branch.leaf
        right_branch.leaf = branch.leaf
        
        return middle

    def traversal_hierarchy(self, branch=None, level=0):
        if branch is None:
            if self.root is None:
                return []
            branch = self.root
        
        result = []
        temp = branch.root
        
        while temp is not None:
            result.append('  ' * level + str(temp.value))
            
            if temp.left:
                result.extend(self.traversal_hierarchy(temp.left, level + 1))
            
            # Only process right child of the last node to avoid duplicates
            if temp.next is None and temp.right:
                result.extend(self.traversal_hierarchy(temp.right, level + 1))
            
            temp = temp.next
        
        return result

    def inorder_traversal(self, branch=None):
        if branch is None:
            branch = self.root
        
        result = []
        temp = branch.root
        
        while temp is not None:
            if temp.left:
                result.extend(self.inorder_traversal(temp.left))
            
            result.append(temp.value)
            
            if temp.next is None and temp.right:
                result.extend(self.inorder_traversal(temp.right))
                break
                
            temp = temp.next
        
        return result


# Test
if __name__ == "__main__":
    print("B-Tree implementation (order = 3):")
    btree = BTree(order=3)
    
    test_values = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
    
    for i, v in enumerate(test_values):
        btree.insert(v)
        #print(f"\nAfter inserting {v}:")
        #for line in btree.traversal_hierarchy():
        #    print(line)
    
    print("\nFinal B-Tree structure:")
    for line in btree.traversal_hierarchy():
        print(line)
    
    final_result = btree.inorder_traversal()
    print(f"\nIn-order: {final_result}")
