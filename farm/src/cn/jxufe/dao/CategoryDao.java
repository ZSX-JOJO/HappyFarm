package cn.jxufe.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import cn.jxufe.entity.Category;

public interface CategoryDao extends JpaRepository<Category, Long>{

}
