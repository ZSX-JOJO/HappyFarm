package cn.jxufe.dao;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import cn.jxufe.entity.Phase;

public interface PhaseDao extends JpaRepository<Phase, Long>{

	public Page<Phase> findBySeedId(long seedId,Pageable page);
	public List<Phase> findBySeedId(long seedId);
	public List<Phase> findBySeedIdAndPhase(long seedId,int phase);
	public List<Phase> findById(long id);
	@Query("FROM Phase p WHERE p.seedId = :seedId ORDER BY p.phase ASC")
	public List<Phase> findFirstPhase(@Param("seedId")long seedId);
}
