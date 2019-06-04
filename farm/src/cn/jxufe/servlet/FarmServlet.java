package cn.jxufe.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.WebApplicationContextUtils;
import cn.jxufe.service.GameService;

public class FarmServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	@Autowired
	GameService gameService;
	
	public void init() throws ServletException {
        super.init();
        WebApplicationContextUtils
               .getWebApplicationContext(getServletContext())
               .getAutowireCapableBeanFactory().autowireBean(this);      
        System.out.println("/******************** 后台游戏服务开始启动 ***************************/");
        gameService.gameStart();
        System.out.println("/******************** 后台游戏服务启动完成 ***************************/");
    }   
}
