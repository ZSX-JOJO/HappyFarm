package cn.jxufe.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.EasyUIDataPageRequest;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.User;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("user")
public class UserController extends BaseController{
	
	
	@RequestMapping(value = "grid")
	public String grid() {
		return "user/grid";
	}
	
	@RequestMapping(value = "gridData", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public EasyUIData<?> gridData(EasyUIDataPageRequest pageRequest,
			@RequestParam(defaultValue = "allName") String username){
		
		List<Sort.Order> orders = new ArrayList<Sort.Order>();
		if (pageRequest.getOrder().equals("asc"))
			orders.add(new Sort.Order(Direction.ASC, pageRequest.getSort()));
		else
			orders.add(new Sort.Order(Direction.DESC, pageRequest.getSort()));

		Pageable pageable = new PageRequest(pageRequest.getPage() - 1, 
				pageRequest.getRows(), new Sort(orders));
		
		if(username.equals("allName"))
			return userService.findAll(pageable);
		
		return userService.findUsersByName("%"+username+"%", pageable);
	}
	
	@RequestMapping(value = "getUserInfoById")
	@ResponseBody
	public User getUserInfoById(long id, HttpSession session) {
		User user = userService.findUsersById(id);
		session.setAttribute("currentUser", user);
		return user;
		
	}
	
	@RequestMapping("login")
	public String listUser() {
		return "user/login";
	}
	
	@ResponseBody
	@RequestMapping("listUser")
	public List<User> findAll(){
		return userService.findAll();
	}
	
	@ResponseBody
	@RequestMapping("rewardForClean")
	public Message rewardForClean(HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		return userService.rewardOfClean(user,session);
	}
	
	@ResponseBody
	@RequestMapping("rewardForKill")
	public Message rewardForKill(HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		return userService.rewardOfKill(user,session);
	}
	
	@RequestMapping(value = "save", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message save(User user,HttpSession session) {
		
		Message message = userService.save(user);
		
		User currentUser = (User) session.getAttribute("currentUser");
		if(currentUser!=null //判断用户是否登录
			&& currentUser.getId() == user.getId()) {
			session.setAttribute("currentUser", user);
			JSONObject u = new JSONObject();
			u.put("newUserInf", user);
			message.setCode(2);//需要更新top-frame的用户信息
			message.setData(u);//Ajax请求,虽然更新了session但是page缓存的session没有更新
		}
		
		return message;
	}

	@RequestMapping(value = "delete", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message delete(User user) {
		return userService.delete(user);
	}
}
