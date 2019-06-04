package cn.jxufe.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import cn.jxufe.entity.Seed;

public interface SeedDao extends JpaRepository<Seed, Long>{

	public Page<Seed> findByNameLike(String name,Pageable page);
	@Query("select s.seedPurPrice from Seed s where s.id = :id")
	public int findSeedPurPriceById(@Param("id") long id);
	public List<Seed> findBySeedId(long seedId);
	public List<Seed> findById(long id);
}
