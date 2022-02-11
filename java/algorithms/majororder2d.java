
public class majororder2d {

    public static void main(String [] args) {
        int [][] m = {{0, 1, 2, 3}, {4, 5, 6, 7}, {8, 9, 10, 11}, {12, 13, 14, 15}};
        int [] rowmajor = new int[16];
        int [] colmajor = new int[16];
    
        for (int i = 0; i < 4; i++)
            for (int j = 0; j < 4; j++){
                rowmajor[j+4*i] = m[i][j];
                colmajor[i+4*j] = m[i][j];
            }
    
        for (int i = 0; i < 16; i++)
            System.out.print (rowmajor[i]+" ");
        System.out.println();
        for (int i = 0; i < 16; i++)
            System.out.print (colmajor[i]+" ");
    }
}
