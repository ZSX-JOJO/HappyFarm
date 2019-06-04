package cn.jxufe.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import cn.jxufe.dao.LandDao;
import cn.jxufe.entity.Land;
import cn.jxufe.service.LandService;

@Service("landService")
public class LandServiceImpl extends BaseServiceImpl implements LandService{

	@Autowired
	LandDao landDao;
	
	public List<Land> findAll(){
		return landDao.findAll();
	}
}
