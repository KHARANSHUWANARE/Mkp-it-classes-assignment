
import java.util.Collections;
import java.util.LinkedList;

import java.util.ListIterator;

public class Mylinkedlist {
public static void main(String[] args) {
	  LinkedList<Integer> linkedList=new LinkedList<Integer>();
	  
	  linkedList.add(78);
	  linkedList.add(1);
	  linkedList.add(1);
	  linkedList.add(2);
	  linkedList.add(1);
	  linkedList.add(3);
	  linkedList.add(1);
	  linkedList.add(1);	  
	  linkedList.add(linkedList.size(),45);
	
	  Collections.swap(linkedList, 1, 4);
	  
	  System.out.println(linkedList);
	  
	  
}
}
