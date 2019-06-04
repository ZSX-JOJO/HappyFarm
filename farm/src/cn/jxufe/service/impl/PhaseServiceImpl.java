package cn.jxufe.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.dao.PhaseDao;
import cn.jxufe.dao.SeedDao;
import cn.jxufe.entity.Phase;
import cn.jxufe.entity.Seed;
import cn.jxufe.service.PhaseService;
import cn.jxufe.service.SeedService;

@Service("phaseService")
public class PhaseServiceImpl extends BaseServiceImpl implements PhaseService{

	@Autowired
	private PhaseDao phaseDao;
	@Autowired
	private SeedDao seedDao;
	@Autowired
	SeedService seedService;
	
	@Override
	public EasyUIData<Phase> findPhasesBySeedId(long seedId,Pageable pageable){
		Page<Phase> page = phaseDao.findBySeedId(seedId,pageable);
        EasyUIData<Phase> easyUIData = new EasyUIData<Phase>();
        easyUIData.setTotal(page.getTotalElements());
        easyUIData.setRows(page.getContent());
        return easyUIData;
	}
	
	@Override
	public List<Phase> findPhaseBySeedId(long seedId) {
		Seed seed = seedDao.findBySeedId(seedId).get(0);
		List<Phase> phases = phaseDao.findBySeedId(seedId);
		for(Phase p : phases) {
			p.setSeed(seed);
		}
		return phases;
	}
	
	@Override
	public void t2p(Phase phase) {//根据id填充完整数据
		long id = phase.getId();
		Phase ph = phaseDao.findById(id).get(0);
		phase.clone(ph);//一层深克隆
		fillPhase(phase);
	}
	
	@Override
	public void fillPhase(Phase phase) {
		if(phase == null) return;
		Seed seed = seedDao.findBySeedId(phase.getSeedId()).get(0);
		phase.setSeed(seed);
	}
	
	@Override
	public Phase firstPhase(Seed seed) {
		seedService.fillSeed(seed);
		List<Phase> ps = phaseDao.findFirstPhase(seed.getSeedId());
		if(ps.size()>0) {
			Phase phase = ps.get(0);
			fillPhase(phase);
			return phase;
		}
		return null;
	}
	
	@Override
	public Phase nextPhase(Phase phase) {
		List<Phase> ps = phaseDao.findBySeedIdAndPhase(
				phase.getSeedId(), phase.getPhase()+1);
		if(ps.size()>0) {
			Phase nextPhase = ps.get(0);
			fillPhase(nextPhase);
			return nextPhase;
		}
		return null;
	}
	
	@Override
	public boolean wormGrow(double chance) {
		double rand = Math.random();
		if(rand <= chance)
			return true;
		return false;
	}
	
	@Override
	public Message save(Phase phase) {
		Message message = new Message();
        try {
        	phaseDao.save(phase);
            message.setCode(0);
            message.setMsg("保存成功");
        }catch(Exception e) {
            message.setCode(-10);
            message.setMsg("保存失败");
        }
        return message;
	}

	@Override
	public Message delete(Phase phase) {
		Message message = new Message();
        try {
        	phaseDao.delete(phase);
            message.setCode(0);
            message.setMsg("删除成功");
        }catch(Exception e) {
            message.setCode(-10);
            message.setMsg("删除失败");
        }
        return message;
	}
}
