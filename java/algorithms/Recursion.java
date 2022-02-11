
public class Recursion {

    int multi(int a, int b) {
        if (b > 0) 
            return a + multi(a, b-1);
        return 0;
    }
    
    int divi(int a, int b) {
        if (a > 1)
            return 1 + divi(a-b, b);
        return 0;
    }
    
    int factorial(int n) {
        if (n > 1)
            return n * factorial(n-1);
        return 1;
    }
    
    int fibonacci(int n) {
        if (n > 1)
            return fibonacci(n-1) + fibonacci(n-2);
        return n;
    }
    
    int ackermann(int m, int n) {
        if (m == 0)
            return n + 1;
        else if (n == 0)
            return ackermann(m-1, 1);
        else
            return ackermann(m-1, ackermann(m, n-1));
    }
    
    boolean par(int n) {
        if (n == 0)
            return true;
        return impar(n - 1);
    }
    
    boolean impar(int n) {
        if (n == 0)
            return false;
        return par(n - 1);
    }
    
    public static void main(String [] args) {
        Recursion r = new Recursion();
        System.out.println("3*2     : "+r.multi(3, 2));
        System.out.println("6/3     : "+r.divi(6, 3));
        System.out.println("fact(5) : "+r.factorial(5));
        System.out.println("fibo(5) : "+r.fibonacci(5));
        System.out.println("ack(2,2): "+r.ackermann(2,2));
        System.out.println("impar(3): "+r.impar(3));
        System.out.println("par(3)  : "+r.par(3));
    }
}
