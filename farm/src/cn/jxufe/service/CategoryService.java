package cn.jxufe.service;

import java.util.List;
import cn.jxufe.entity.Category;

public interface CategoryService extends BaseService{

	public List<Category> findAll();
}
