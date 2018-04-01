package com.utils;

import java.util.Random;

public class RanDom {
	public static String getRandom() {
		Random random = new Random();  
		String result="";  
		for (int i=0;i<11;i++)  
		{  
		    result+=random.nextInt(10);  
		} 
		return result;
	}
	
	public static String getRandom_18() {
		Random random = new Random();  
		String result="";  
		for (int i=0;i<18;i++)  
		{  
		    result+=random.nextInt(10);  
		} 
		return result;
	}
}
