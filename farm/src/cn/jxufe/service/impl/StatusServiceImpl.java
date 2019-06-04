package cn.jxufe.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.jxufe.dao.StatusDao;
import cn.jxufe.entity.Status;
import cn.jxufe.service.StatusService;

@Service("statusService")
public class StatusServiceImpl extends BaseServiceImpl implements StatusService{

	@Autowired
	private StatusDao statusDao;

	@Override
	public List<Status> findAll() {
		return statusDao.findAll();
	}
}
