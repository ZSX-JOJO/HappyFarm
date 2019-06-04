package cn.jxufe.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import cn.jxufe.entity.Repository;
import cn.jxufe.entity.Seed;
import cn.jxufe.entity.User;

public interface RepositoryDao extends JpaRepository<Repository, Long>{

	public Repository findByUserAndSeed(User user,Seed seed);
	public List<Repository> findByUser(User user);
}
