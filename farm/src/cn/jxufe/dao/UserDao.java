package cn.jxufe.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import cn.jxufe.entity.User;

public interface UserDao extends JpaRepository<User, Long>{

	Page<User> findByUsernameLike(String username, Pageable pageable);
	User findById(long id);
	
}
