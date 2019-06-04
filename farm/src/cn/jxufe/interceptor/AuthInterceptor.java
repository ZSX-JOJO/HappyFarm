package cn.jxufe.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import cn.jxufe.entity.User;

public class AuthInterceptor extends HandlerInterceptorAdapter{
	
	 public boolean preHandle(HttpServletRequest request,  
             HttpServletResponse response, Object handler) throws IOException {

		 User currentUser = (User) request.getSession().getAttribute("currentUser");
		 String contextPath = request.getContextPath();
		 if(currentUser == null) {
			 response.sendRedirect(contextPath + "/user/login");  
			 return false;
		 }
		 return true;
	 }
}
