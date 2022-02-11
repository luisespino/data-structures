class StackNode {
    Object data;
    StackNode next;    

    public StackNode(Object data) {
        this.data = data;
        this.next = null;
    }
}

public class Stack {
    StackNode head;

    void push (Object data) {
        StackNode tmp =  new StackNode(data);
        tmp.next = head;
        head = tmp;            
    }

    StackNode pop () {
        StackNode tmp = null;
        if (head!=null) {
            tmp =  new StackNode(head.data);
            head = head.next;
        }
        return tmp;
    }

    public static void main(String [] args) {
        Stack stack = new Stack();
        stack.push(5);
        stack.push(7);
        stack.push(10);
        System.out.println(stack.pop().data);
        System.out.println(stack.pop().data);
        System.out.println(stack.pop().data);
    }
    
}
