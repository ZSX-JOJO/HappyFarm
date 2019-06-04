package cn.jxufe.service;

import java.util.List;

import cn.jxufe.entity.Status;

public interface StatusService extends BaseService{

	public List<Status> findAll();
}
