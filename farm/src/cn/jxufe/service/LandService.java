package cn.jxufe.service;

import java.util.List;
import cn.jxufe.entity.Land;

public interface LandService extends BaseService{

	public List<Land> findAll();
}
