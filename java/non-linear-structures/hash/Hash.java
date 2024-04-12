// Luis Espino 2020

public class Hash {
	int n, m;
	int [] h;
	int min, max;
	
	public Hash(int m, int min, int max) {
		this.m = m;
		this.min = min;
		this.max = max;
		init();
	}
	
	int division(int k) { 
		return (k % m); 
		}

	int linear(int k) { 
		return ((k+1) % m); 
	}

	void init() {
		n = 0;
		h = new int[m];
		for(int i=0; i<m; i++) 
			h[i] = -1;		
	}

	void insert(int k) {
		int i = division(k);
		while (h[i] != -1)
			i = linear (i);
		h[i] = k;
		n++;
		rehashing();
	}	
	
	void rehashing() {
		if ((n*100/m)>=max) {
			//array copy
			int [] temp = h;
			print();
			//rehashing
			int mprev = m;		
			m = n*100/min;
			init();
			for (int i=0; i<mprev; i++)
				if (temp[i]!=-1)
					insert(temp[i]);			
		}
		else print();
	}

	void print() {
		System.out.print("[");
		for(int i=0; i<m; i++)
			System.out.print(" "+h[i]);
		System.out.println(" ] "+(n*100/m)+"%");
	}
	
	public static void main(String[] args) {
		Hash hash = new Hash(3, 50, 60); // m, min, max
		hash.insert(1);
		hash.insert(2);
		hash.insert(3);
		hash.insert(4);
		hash.insert(5);
		hash.insert(6);
	}

}
