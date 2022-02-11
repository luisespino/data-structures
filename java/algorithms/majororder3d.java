
public class majororder3d {

    public static void main(String [] args) {
        int [][][] m = {{{0, 1}, {2, 3}}, {{4, 5}, {6, 7}}};
        int [] rowmajor = new int[8];
        int [] colmajor = new int[8];

        // java 3d array access: [Array][Row][Col]
        for (int k = 0; k < 2; k++) {
            System.out.println("array: "+k);
            for (int i = 0; i < 2; i++){
                for (int j = 0; j < 2; j++){
                    System.out.print(m[k][i][j]+" ");
                    rowmajor[j+2*(i+2*k)] = m[k][i][j];
                    colmajor[i+2*(j+2*k)] = m[k][i][j];    
                }
                System.out.println();
            }
        }
        System.out.println("Row Major 3D:");
        for (int i = 0; i < 8; i++)
            System.out.print (rowmajor[i]+" ");
        System.out.println("\nCol Major 3D:");
        for (int i = 0; i < 8; i++)
            System.out.print (colmajor[i]+" ");
    }
}
