package com.sabpaisa.qforms.WebXmlFile;

import java.util.ArrayList;

public class DemoClass {

	public static void main(String[] args) {
		ArrayList<String> l1=new ArrayList<String>();
		ArrayList<String> l2=new ArrayList<String>();
		ArrayList<String> l3=new ArrayList<String>();
		l1.add("A");
		l1.add("B");
		l1.add("C");
		l1.add("D");
		System.out.println("value of l1 "+l1.toString());
		l2.add("A");
		l2.add("E");
		l2.add("F");
		l2.add("D");
		System.out.println("value of l2 "+l2.toString());
		
		for(String x :l2 ) {
			if(!l1.contains(x)) {
				l1.add(x);
			}
		}
		
		System.out.println("NEW value of l1 "+l1.toString());
		
		/*for(int i=0;i<l1.size();i++) {
			for(int j=0;j<l2.size();j++) {
				if(l1.get(i).toString()==l2.get(j).toString())
				{
					l3.add(l2.get(j).toString());
				}else {
					l1.add(l2.get(j).toString());
				}
			}
		}
		
		System.out.println("value of l3 "+l3.toString());
		*/

	}

}
