package com.utils;

import java.util.Random;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Random random = new Random();  
		String result="";  
		for (int i=0;i<9;i++)  
		{  
		    result+=random.nextInt(10);  
		} 
		
		String str = "123";
		try {
		    int b = Integer.parseInt(result.trim());
		    System.out.println(b);
		} catch (NumberFormatException e) {
		    e.printStackTrace();
		}
		//System.out.println(a);
	}

}
