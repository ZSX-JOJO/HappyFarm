package cn.jxufe.dao;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import cn.jxufe.entity.Plant;
import cn.jxufe.entity.User;

public interface PlantDao extends JpaRepository<Plant, Long>{

	public List<Plant> findById(long id);
	public List<Plant> findByUser(User user);
}
