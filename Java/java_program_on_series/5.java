public class MySeries {
	
	public long square(int no) {
		return no*no;
	}
	
	public void squareSeries(int n) {
		
		long sum=0;
		for (int i = 1; i < n+1; i++) {
			long sq=this.square(i);
			sum=sum+sq;
		}
		System.out.println("sum is "+sum);
	}
}
