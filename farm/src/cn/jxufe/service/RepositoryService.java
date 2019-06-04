package cn.jxufe.service;

import java.util.List;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.Repository;
import cn.jxufe.entity.Seed;
import cn.jxufe.entity.User;

public interface RepositoryService extends BaseService{

	public void save(Repository repository);
	public Message buy(Repository repository);
	public Message sell(Repository repository);
	public List<Repository> findByUser(User user);
	public Message useSeed(User user,Seed seed);
}
