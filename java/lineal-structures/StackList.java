
public class StackList {

    public static void main(String [] args) {
        Stack stacklist = new Stack();
        List list1 = new List();
        list1.add(3);
        list1.add(2);
        list1.add(1);
        stacklist.push(list1);
        List list2 = new List();
        list2.add("c");
        list2.add("b");
        list2.add("a");        
        stacklist.push(list2);
        ((List) stacklist.pop().data).show();
        ((List) stacklist.pop().data).show();
    }
    
}
