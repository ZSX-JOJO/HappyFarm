package cn.jxufe.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.dao.SeedDao;
import cn.jxufe.entity.Seed;
import cn.jxufe.service.SeedService;

@Service("seedService")
public class SeedServiceImpl extends BaseServiceImpl implements SeedService {

	@Autowired
	private SeedDao seedDao;
	
	public EasyUIData<Seed> findSeedsByName(String name,Pageable pageable){
		Page<Seed> page = seedDao.findByNameLike(name,pageable);
        EasyUIData<Seed> easyUIData = new EasyUIData<Seed>();
        easyUIData.setTotal(page.getTotalElements());
        easyUIData.setRows(page.getContent());
        return easyUIData;
	}
	
	public EasyUIData<Seed> findAll(Pageable pageable) {
        Page<Seed> page = seedDao.findAll(pageable);
        EasyUIData<Seed> easyUIData = new EasyUIData<Seed>();
        easyUIData.setTotal(page.getTotalElements());
        easyUIData.setRows(page.getContent());
        return easyUIData;
    }
	
	@Override
	public List<Seed> findAll(){
		return seedDao.findAll();
	}
	
	@Override
	public void fillSeed(Seed seed) {
		Seed clone = seedDao.findById(seed.getId()).get(0);
		seed.clone(clone);
	}

	@Override
	public int queryPrice(long id) {
		return  seedDao.findSeedPurPriceById(id);
	}
	
	@Override
	public Message save(Seed seed) {
		Message message = new Message();
        try {
        	seedDao.save(seed);
            message.setCode(0);
            message.setMsg("保存成功");
        }catch(Exception e) {
            message.setCode(-10);
            message.setMsg("保存失败");
        }
        return message;
	}

	@Override
	public Message delete(Seed seed) {
		Message message = new Message();
        try {
        	seedDao.delete(seed);
            message.setCode(0);
            message.setMsg("删除成功");
        }catch(Exception e) {
            message.setCode(-10);
            message.setMsg("删除失败");
        }
        return message;
	}
}
