class ListNode {
    int data;
    ListNode next;
    public ListNode(int data) {
        this.data = data;
        this.next = null;
    }
}

public class List {
    ListNode head;

    void add(int val) {
        ListNode tmp =  new ListNode(val);
        tmp.next = head;
        head = tmp;
    }

    void show() {
        ListNode tmp = head;
        while(tmp!=null) {
            System.out.print(tmp.data+" ");
            tmp = tmp.next;
        }
    }
    
    public static void main(String [] args){
        List list = new List();
        list.add(5);
        list.add(10);
        list.show();
    }

}
