package cn.jxufe.service;

import java.util.List;

import org.springframework.data.domain.Pageable;
import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.Seed;

public interface SeedService extends BaseService{
	public EasyUIData<Seed> findSeedsByName(String name,Pageable pageable);
	public EasyUIData<Seed> findAll(Pageable pageable);
	public List<Seed> findAll();
	public Message save(Seed seed);
	public Message delete(Seed seed);
	public int queryPrice(long id);
	public void fillSeed(Seed seed);
}
