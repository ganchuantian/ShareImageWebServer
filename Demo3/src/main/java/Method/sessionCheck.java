package Method;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class sessionCheck {
	public static boolean sessionCheck(HttpServletRequest request,HttpServletResponse response){
		String userName = (String) request.getSession().getAttribute("userId");
        if (null == userName) {
            return false;
        }
		return true;
	}
}
