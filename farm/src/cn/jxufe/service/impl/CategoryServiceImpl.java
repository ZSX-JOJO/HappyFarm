package cn.jxufe.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.jxufe.dao.CategoryDao;
import cn.jxufe.entity.Category;
import cn.jxufe.service.CategoryService;

@Service("categoryService")
public class CategoryServiceImpl extends BaseServiceImpl implements CategoryService{

	@Autowired
	CategoryDao categoryDao;
	
	public List<Category> findAll(){
		return categoryDao.findAll();
	}
}
