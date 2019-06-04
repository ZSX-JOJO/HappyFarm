package cn.jxufe.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("shop")
public class ShopController extends BaseController{

	@RequestMapping(value = "grid")
	public String grid(HttpSession session) {
		initMap(session);
		return "shop/grid";
	}
}
