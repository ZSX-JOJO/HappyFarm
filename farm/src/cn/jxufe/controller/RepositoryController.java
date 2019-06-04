package cn.jxufe.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.Repository;
import cn.jxufe.entity.User;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("repository")
public class RepositoryController extends BaseController{
	
	@Transactional(propagation=Propagation.REQUIRED,rollbackForClassName="Exception")
	@RequestMapping(value = "buy", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message save(Repository repository,HttpSession session) throws Exception {
		User currentUser = (User) session.getAttribute("currentUser");
		Message message = requestCheck(currentUser,repository.getUser().getId());
		int price = seedService.queryPrice(repository.getSeed().getId());
		int pay = price * repository.getNum();
		int currentMoeny = currentUser.getMoney();
		if(currentMoeny < pay) {
			return new Message(-10,"您的余额不足");
		}
		currentUser.setMoney(currentMoeny - pay);
		userService.save(currentUser);
		message = repositoryService.buy(repository);
		JSONObject data = new JSONObject();//使用ajax时页面已经缓存了session，后台代码修改了session，但是page未能及时更新，所以返回data
		data.put("money", currentUser.getMoney());
		message.setData(data);
		return message;
	}
	
	@Transactional(propagation=Propagation.REQUIRED,rollbackForClassName="Exception")
	@RequestMapping(value = "sell", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message sell(Repository repository,HttpSession session) {
		User currentUser = (User) session.getAttribute("currentUser");
		Message message = requestCheck(currentUser,repository.getUser().getId());
		message = repositoryService.sell(repository);
		if(message.getCode()==1) {//库存成功减少
			addMoney(currentUser,repository);//账户的钱增加
		}
		JSONObject data = new JSONObject();
		data.put("money", currentUser.getMoney());
		message.setData(data);
		return message;
	}
	
	public void addMoney(User currentUser,Repository repository) {
		int currentMoeny = currentUser.getMoney();
		int price = seedService.queryPrice(repository.getSeed().getId());
		int incomes = (int)(0.8*price * repository.getNum());
		currentUser.setMoney(currentMoeny+incomes);
		userService.save(currentUser);
	}
	
	public Message requestCheck(User currentUser,long uid) {
		if(currentUser == null) {
			return new Message(-10,"用户信息已失效，请重新登录!");
		}
		if(currentUser.getId() != uid) {
			return new Message(-10,"非法请求!");
		}
		return new Message(0,"确认是当前用户操作");
	}
	
	@ResponseBody
	@RequestMapping(value = "listUserRep" , produces = MediaType.APPLICATION_JSON_VALUE)
	public List<Repository> listLand(HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		return repositoryService.findByUser(user);
	}
}
