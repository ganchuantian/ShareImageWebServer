package Method;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import org.apache.commons.codec.binary.Base64;

public class FileMethod {
	
	private Base64Method b64m;
	String img_String_base64;
	private byte[] b;
	private String fileName;
	private String suffix;
	
	public FileMethod(String info) {
		String n =new String();
		b64m = new Base64Method(info);
		img_String_base64 = info;
		JudgeFileSuffix();
		while(true) {
			n = RandomName.genUnRepeatRandom();
			if(JudgeFileName(n+suffix))
			{
				fileName =  n + suffix;
				break;
			}
		}
	}
	
	public String New_Img() {		//�����ɵ�ͼƬ 
		try {
			b = b64m.deCode();
	        OutputStream output = new FileOutputStream("D:\\Tomcat\\apache-tomcat-9.0.12\\webapps\\PicBase\\pic\\" + fileName);
	        output.write(b);  
	        output.flush();  
	        output.close();
	        return "pic/"+fileName;
        }catch(Exception e) {
        	e.printStackTrace();
        	return "false";
        }
	}
	
	public void JudgeFileSuffix() {
		if(img_String_base64.charAt(11)=='p')
        	suffix = ".png";
        else if(img_String_base64.charAt(11)=='j')
        	suffix = ".jpg";
        else 
        	suffix = ".gif";
	}
	
	public boolean JudgeFileName(String name) {
		File file = new File("D:\\Tomcat\\apache-tomcat-9.0.12\\webapps\\PicBase\\pic\\"+name);
		if(file.isDirectory())
			return false;
		else
			return true;
	}
	
	public static boolean deleteFile(String name) {
		StringBuilder n = new StringBuilder(name);
		n.replace(0, 3, "");
		File file = new File("D:\\Tomcat\\apache-tomcat-9.0.12\\webapps\\PicBase\\pic\\"+n.toString());
		try {
			file.delete();
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
}
