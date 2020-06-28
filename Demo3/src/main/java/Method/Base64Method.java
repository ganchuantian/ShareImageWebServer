package Method;

import java.io.*;

import org.apache.commons.codec.binary.Base64;

public class Base64Method {
	private Base64 base64;
	private StringBuilder b64;
	private byte[] b;
	
	public Base64Method(String info) {
		base64 = new Base64();
		b64 = new StringBuilder(info);
		b=new byte[1024];
		b64.replace(0,22, "");
	}
	
	public byte[] deCode() {
		try {
				b = base64.decodeBase64(b64.toString());
				for(int i=0;i<b.length;++i)  
	            {  
	                if(b[i]<0)  
	                {
	                    b[i]+=256;  
	                }  
	            } 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return b;
	}
	
	
	
}
