package Bean;

import org.apache.commons.codec.binary.Base64;
public class Photograph {
	private  String p_id;
	private String u_id;
	private String p_path;
	private String headline;
	private String info;
	
	public String getP_id() {
		return p_id;
	}
	
	public String getU_id() {
		return u_id;
	}
	
	public String getP_path() {
		return p_path;
	}
	
	public String getheadline() {
		return headline;
	}
	
	public String getInfo() {
		return info;
	}
	
	public void setP_id(String p_id) {
		this.p_id=p_id;
	}
	
	public void setU_id(String u_id) {
		this.u_id=u_id;
	}
	
	public void setP_path(String p_path) {
		this.p_path=p_path;
	}
	
	public void setheadline(String headline) {
		this.headline=headline;
	}
	
	public void setInfo(String info) {
		this.info=info;
	}
}
