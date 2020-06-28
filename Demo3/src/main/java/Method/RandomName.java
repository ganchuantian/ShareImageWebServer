package Method;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;

public class RandomName {
	
	public RandomName() {
		
	}
	
	public static String genUnRepeatRandom(){
		String result = new String();
		Random ran=new Random();
		int i = 0;
		while(i<10){
			i++;
			result = result + ran.nextInt(20)+1;
		}
		return result;
	}
}