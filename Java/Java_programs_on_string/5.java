public class SimplerUniqueWordsCounter {
	public static void main(String args[]) {
		String str;
		int i, len;
		int counter[] = new int[256];
		
 
		str = "my name is khan";

		len = str.length();
 
		for (i = 0; i < len; i++) {
			counter[(int) str.charAt(i)]++;
		}

		for (i = 0; i < 256; i++) {
			if (counter[i] ==1) {
  
				System.out.println((char) i + " --> " + counter[i]);
			}
		}
	}
}
