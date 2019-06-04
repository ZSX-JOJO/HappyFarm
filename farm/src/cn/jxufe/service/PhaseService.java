package cn.jxufe.service;

import java.util.List;

import org.springframework.data.domain.Pageable;
import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.Phase;
import cn.jxufe.entity.Seed;

public interface PhaseService extends BaseService{

	public EasyUIData<Phase> findPhasesBySeedId(long seedId,Pageable pageable);
	public List<Phase> findPhaseBySeedId(long seedId);
	public Message save(Phase phase);
	public Message delete(Phase phase);
	public void t2p(Phase phase);
	public Phase nextPhase(Phase phase);
	public void fillPhase(Phase phase);
	public Phase firstPhase(Seed seed);
	public boolean wormGrow(double chance);
}
