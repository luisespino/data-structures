class QueueNode {
    Object data;
    QueueNode prev;
    QueueNode next;

    public QueueNode(Object data) {
        this.data = data;
        this.prev = null;
        this.next = null;
    }
}

public class Queue {
    QueueNode head, tail;

    void push (Object data) { // push tail
        if (head==null) {
            head = tail = new QueueNode(data);
        } else {
            tail.next = new QueueNode(data);
            tail.next.prev = tail;            
            tail = tail.next;
        }        
    }

    QueueNode pop () { //pop head
        QueueNode tmp = null;
        if (head!=null) {
            tmp =  new QueueNode(head.data);
            head = head.next;
            if (head!=null) {
                head.prev = null;
            }           
        }
        return tmp;
    }

    public static void main(String [] args) {
        Queue queue = new Queue();
        queue.push(5);
        queue.push(7);
        queue.push(10);
        System.out.println(queue.pop().data);
        System.out.println(queue.pop().data);
        System.out.println(queue.pop().data);
    }
    
}
