
public class ArrayListMod {

    public static void main (String [] args) {
        List [] a = new List[5];
        for (int i=0; i<5; i++) // O(n) unnecessary for the instantiation
            a[i] = new List();
        a[1%5].add(1);
        a[3%5].add(3);
        a[6%5].add(6);
        a[8%5].add(8);
        a[14%5].add(14);
        for (int i=0; i<5; i++) {
            System.out.print(i+" -> ");
            a[i].show();
            System.out.println();
        }
    }
}
