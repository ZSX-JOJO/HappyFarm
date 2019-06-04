package cn.jxufe.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.jxufe.bean.Message;
import cn.jxufe.dao.RepositoryDao;
import cn.jxufe.entity.Repository;
import cn.jxufe.entity.Seed;
import cn.jxufe.entity.User;
import cn.jxufe.service.RepositoryService;

@Service("repositoryService")
public class RepositoryServiceImpl extends BaseServiceImpl implements RepositoryService{

	@Autowired
	private RepositoryDao repositoryDao;
	
	@Override
	public void save(Repository repository) {
		repositoryDao.save(repository);//这里如果发生运行时异常不再进行处理，而是直接抛出，让上层事务进行回滚
	}
	
	@Override
	public Message buy(Repository repository) {
		Repository record = repositoryDao.findByUserAndSeed(repository.getUser(), repository.getSeed());//获得购买记录
		if(record == null ){
			save(repository);
			return new Message(1,"购买成功");
		}else {
			record.setNum(record.getNum()+repository.getNum());
			save(record);
			return new Message(1,"购买成功");
		}
	}
	
	@Override
	public Message sell(Repository repository) {
		Repository record = repositoryDao.findByUserAndSeed(repository.getUser(), repository.getSeed());
		if(record == null) {
			return new Message(-10,"库存不存在");
		}else if(repository.getNum() > record.getNum()) {
			return new Message(-10,"没有这么多库存，无法售出");
		}else {
			record.setNum(record.getNum()-repository.getNum());
			save(record);
			return new Message(1,"成功卖出");
		}
	}
	
	@Override
	public Message useSeed(User user,Seed seed) {
		Repository repository = repositoryDao.findByUserAndSeed(
				user, seed);
		if(repository==null || repository.getNum()<=0) {
			return new Message(-10,"种子库存不足");
		}
		repository.setNum(repository.getNum()-1);
		save(repository);
		return new Message(0,"成功使用一颗种子");
	}
	
	@Override
	public List<Repository> findByUser(User user){
		return repositoryDao.findByUser(user);
	}
}
