package cn.jxufe.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.dao.UserDao;
import cn.jxufe.entity.User;
import cn.jxufe.service.UserService;
import net.sf.json.JSONObject;

@Service("userService")
public class UserServiceImpl extends BaseServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;
	
	@Override
	public EasyUIData<User> findUsersByName(String username, Pageable pageable) {
		Page<User> page = userDao.findByUsernameLike(username,pageable);
        EasyUIData<User> easyUIData = new EasyUIData<User>();
        easyUIData.setTotal(page.getTotalElements());
        easyUIData.setRows(page.getContent());
		return easyUIData;
	}
	
	@Override
	public User findUsersById(long id){
		User user = userDao.findById(id);
		return user;
	}

	@Override
	public EasyUIData<User> findAll(Pageable pageable) {
		Page<User> page = userDao.findAll(pageable);
        EasyUIData<User> easyUIData = new EasyUIData<User>();
        easyUIData.setTotal(page.getTotalElements());
        easyUIData.setRows(page.getContent());
        return easyUIData;
	}
	
	@Override
	public Message rewardOfClean(User user,HttpSession session) {//清理枯草的奖励
		User newuser = reward(user.getId(),5,5,0);
		Message message = updateAccount(newuser,session);
		message.setMsg("清除成功!<br><br>经验+5   积分+5");
		return message;
	}

	@Override
	public Message rewardOfKill(User user,HttpSession session) {//杀虫奖励
		User newuser = reward(user.getId(),1,1,0);
		Message message = updateAccount(newuser,session);
		message.setMsg("杀虫成功!<br><br>经验+1   积分+1");
		return message;
	}
	
	@Override
	public User reward(long userId,int experinece,int integral,int money) {
		User user = findUsersById(userId);
		user.setExperience(user.getExperience()+experinece);
		user.setIntegral(user.getIntegral()+integral);
		user.setMoney(user.getMoney()+money);
		return user;
	}
	
	@Override
	public Message updateAccount(User user,HttpSession session) {
		Message message = save(user);
		if(message.getCode() != 0) return message;
		
		message.setMsg("账户更新成功!");
		session.setAttribute("currentUser", user);
		JSONObject data = new JSONObject();
		data.put("user", user);
		message.setData(data);
		return message;
	}
	
	@Override
	public Message save(User user) {
		Message message = new Message();
        try {
        	userDao.save(user);
            message.setCode(0);
            message.setMsg("保存成功");
        }catch(Exception e) {
            message.setCode(-10);
            message.setMsg("保存失败");
        }
        return message;
	}

	@Override
	public Message delete(User user) {
		Message message = new Message();
        try {
        	userDao.delete(user);
            message.setCode(0);
            message.setMsg("删除成功");
        }catch(Exception e) {
            message.setCode(-10);
            message.setMsg("删除失败");
        }
        return message;
	}

	@Override
	public List<User> findAll() {
		return userDao.findAll();
	}

}
