package cn.jxufe.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.jxufe.bean.Message;
import cn.jxufe.dao.PlantDao;
import cn.jxufe.entity.Phase;
import cn.jxufe.entity.Plant;
import cn.jxufe.entity.Seed;
import cn.jxufe.entity.User;
import cn.jxufe.service.PhaseService;
import cn.jxufe.service.PlantService;
import cn.jxufe.service.RepositoryService;
import cn.jxufe.service.SeedService;
import net.sf.json.JSONObject;

@Service("plantService")
public class PlantServiceImpl extends BaseServiceImpl implements PlantService{

	@Autowired
	PlantDao plantDao;
	@Autowired
	RepositoryService repositoryService;
	@Autowired
	PhaseService phaseService;
	@Autowired
	SeedService seedService;
	
	@Override
	public Message checkSow(Plant plant,HttpSession session) {
		User cur = (User) session.getAttribute("currentUser");
		Message message;
		long uid = plant.getUserId();
		long landId = plant.getLandId();
		Seed seed = plant.getPhaseSeed();
		
		if(uid != cur.getId()) return new Message(-10,"非法操作别人作物");
		
		if(landId != seed.getLandId()) return new Message(-10,"土地类型不匹配");
		
		if(plant.getNowSeason()>1) return new Message(0,"可以播种");//	不需要扣除种子
		
		message = repositoryService.useSeed(cur, seed);//扣除了种子
		if(message.getCode() !=0 ) 	return message;
		
		message.setMsg("可以播种");
		return message;
	}
	
	@Override
	public Message fillSowData(Plant plant,Seed seed) {
		Message message = new Message();
		fillPlant(plant);//填充plant
		Phase firstPhase = phaseService.firstPhase(seed);
		plant.setPhase(firstPhase);
		plant.setTime(0);
		plant.setWorm(false);
		plant.setNowSeason(plant.getNowSeason()+1);
		plant.setReduce(0);
		if(firstPhase == null) {
			message.setCode(-10);
			message.setMsg("请检查种子阶段数据是否缺失");
		}
		return message;
	}
	
	@Override
	public Message toNextPhase(Plant plant) {
		Phase phase = plant.getPhase();
		phaseService.t2p(phase); //这行代码可有可无，加上则万无一失，以防phase只有个id
		Phase nextPhase = phaseService.nextPhase(phase);
		if(nextPhase != null) {
			plant.setPhase(nextPhase);
			plant.setTime(0);//重置为0
			wormGrow(plant);//判断作物是否生虫
			Message message = save(plant);
			if(message.getCode() == 0) 
				message.setMsg("成功进入下一阶段");
			return message;
		}
		return new Message(1,"已经结束生长");
	}
	
	public void wormGrow(Plant plant) {
		if(plant.isWorm() == true) 
			plant.setReduce(plant.getReduce()+1);//如果上一阶段的虫子没有被消灭,减少产量
		
		double chance = plant.getWormChance();
		plant.setWorm(phaseService.wormGrow(chance));
	}
	
	@Override
	public void fillPlant(Plant plant) {
		Plant clone = plantDao.findById(plant.getId()).get(0);
		plant.clone(clone);//一层深克隆
		phaseService.fillPhase(plant.getPhase());
	}
	
	@Override
	public List<Plant> findAll(){
		List<Plant> plants = plantDao.findAll();
		for(Plant plant:plants) {
			phaseService.fillPhase(plant.getPhase());//填充phase.seed
		}
		return plants;
	}
	
	@Override
	public List<Plant> findByUser(User user){
		List<Plant> plants = plantDao.findByUser(user);
		for(Plant plant:plants) {
			phaseService.fillPhase(plant.getPhase());//填充phase.seed
		}
		return plants;
	}
	
	@Override
	public void cleanPlant(Plant plant) {
		plant.setPhase(null);
		plant.setTime(0);
		plant.setNowSeason(0);
		plant.setWorm(false);
		plant.setReduce(0);
	}
	
	@Override
	public void killWorm(Plant plant) {
		plant.setWorm(false);
	}
	
	@Override
	public Message save(Plant plant) {
		/* *
		 * 1.spring-data save方法用的不是引用
		 * 2.即使使用了plant = plant = plantDao.save(plant);调用方的plant还是同样的引用
		 * */
		Message message = new Message();
        try {
        	plant = plantDao.save(plant);
        	JSONObject data = new JSONObject();
        	data.put("plantId", plant.getId());
        	data.put("landIndex", plant.getLandIndex());
        	data.put("landId", plant.getLandId());
            message.setCode(0);
            message.setMsg("保存成功");
            message.setData(data);
        }catch(Exception e) {
        	e.printStackTrace();
            message.setCode(-10);
            message.setMsg("保存失败");
        }
        return message;
	}
	
	@Override
	public Message delete(Plant plant) {
		Message message = new Message();
        try {
        	plantDao.delete(plant);
            message.setCode(0);
            message.setMsg("删除成功");
        }catch(Exception e) {
            message.setCode(-10);
            message.setMsg("删除失败");
        }
        return message;
	}
}
