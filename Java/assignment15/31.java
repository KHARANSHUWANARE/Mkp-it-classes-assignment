
import java.util.LinkedList;

import java.util.ListIterator;

public class Mylinkedlist {
public static void main(String[] args) {
	  LinkedList<Integer> linkedList=new LinkedList<Integer>();
	  
	  linkedList.add(78);
	  linkedList.add(1);
	  linkedList.add(2);
	  linkedList.add(3);
	  linkedList.add(linkedList.size(),45);
	  
	  linkedList.add(4,99);
	 
	  
	  System.out.println(linkedList);
}
}
