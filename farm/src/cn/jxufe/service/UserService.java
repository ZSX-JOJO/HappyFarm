package cn.jxufe.service;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.data.domain.Pageable;
import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.User;

public interface UserService extends BaseService{

	public EasyUIData<User> findUsersByName(String username,Pageable pageable);
	public User findUsersById(long id);
	public EasyUIData<User> findAll(Pageable pageable);
	public Message save(User user);
	public Message delete(User user);
	public List<User> findAll();
	public Message rewardOfClean(User user,HttpSession session);
	public Message rewardOfKill(User user,HttpSession session);
	public User reward(long userId,int experinece,int integral,int money);
	public Message updateAccount(User user,HttpSession session);
}
