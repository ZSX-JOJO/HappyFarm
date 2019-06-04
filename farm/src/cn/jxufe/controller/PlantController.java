package cn.jxufe.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.Phase;
import cn.jxufe.entity.Plant;
import cn.jxufe.entity.Seed;
import cn.jxufe.entity.User;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("plant")
public class PlantController extends BaseController{

	@RequestMapping("page")
	public String toPlantPage(HttpSession session) {/*页面跳转*/
		initMap(session);
		return "farm/plant";
	}
	
	@ResponseBody
	@RequestMapping(value="wasteland")/*开垦荒地*/
	public Message wasteland(Plant plant,HttpSession session) {

		User user = (User)session.getAttribute("currentUser");
		plant.setUser(user);
		Message message = plantService.save(plant);
		if(message.getCode() != 0) return message;
		
		message.setMsg("开荒成功");
		return message;
	}
	
	@Transactional(propagation=Propagation.REQUIRED,rollbackForClassName="Exception")
	@ResponseBody
	@RequestMapping("actionPlant")
	public Message actionPlant(Plant plant,HttpSession session) {// 播种，如果发生异常需要回滚
		
		Message message = plantService.fillSowData(plant,plant.getSeed());
		if(message.getCode() != 0) return message;
		
		message = plantService.checkSow(plant, session);
		if(message.getCode() != 0) return message;
		
		message = plantService.save(plant);
		if(message.getCode() != 0) return message;
		
		message.setMsg("播种成功!");
		JSONObject data = new JSONObject();
		data.put("plant", plant);
		message.setData(data);
		return message;
	}
	
	@ResponseBody
	@RequestMapping("actionCleanLand")
	public Message actionCleanLand(Plant plant,HttpSession session) {/*清除枯草，需要plant.id*/
		
		User user = (User) session.getAttribute("currentUser");
		plantService.fillPlant(plant);
		if(user.getId() != plant.getUserId()) return new Message(-10,"只能清除你自己的枯草");
		
		plantService.cleanPlant(plant);
		Message message = plantService.save(plant);
		if(message.getCode()!=0) return message;
		
		message.setMsg("清除成功!");
		return message;
	}
	
	@ResponseBody
	@RequestMapping("actionKillWorm")
	public Message actionKillWorm(Plant plant,HttpSession session) {/*除虫*/
		User user = (User) session.getAttribute("currentUser");
		plantService.fillPlant(plant);
		if(user.getId() != plant.getUserId()) return new Message(-10,"只能为你自己杀虫");
		
		plantService.killWorm(plant);
		Message message = plantService.save(plant);
		if(message.getCode()!=0) return message;
		
		message.setMsg("除虫成功!");
		return message;
	}
	
	@ResponseBody
	@RequestMapping("actionHarvest")
	public Message actionHarvest(Plant plant,HttpSession session) {/*收获*/
		
		plantService.fillPlant(plant);
		Seed seed = plant.getPhaseSeed();
		int exp = seed.getExperience();
		int integral = seed.getIntegral();
		int reduce = plant.getReduce();
		int harvestNum = seed.getHarvestNum()-reduce > 0 ? seed.getHarvestNum() - reduce : 0 ;
		int money = seed.getFruitPrice()*harvestNum;
		
		User user = (User) session.getAttribute("currentUser");
		user = userService
				.reward(user.getId(),exp, integral, money);
		Message message = userService.updateAccount(user, session);
		if(message.getCode() != 0) return message;
		
		message.setMsg("收获"+harvestNum+"个果实!<br><br>"
				+ "金币+"+money+" 经验+"+exp+"积分+"+integral);
		return message;
	}
	
	@ResponseBody
	@RequestMapping("initLands")
	public List<JSONObject> initLands(HttpSession session) {
		User cur = (User) session.getAttribute("currentUser");
		List<Plant> plants = plantService.findByUser(cur);
		List<JSONObject> result = new ArrayList<>();
		for(Plant plant:plants) {
			JSONObject data = new JSONObject();
			data.put("landId", plant.getLandId());
			data.put("landIndex", plant.getLandIndex());
			data.put("plantId", plant.getId());
			data.put("nowSeason", plant.getNowSeason());
			Phase phase = plant.getPhase();
			if(phase != null) {
				data.put("phase", phase);
				data.put("worm", plant.isWorm());
			}
			result.add(data);
		}
		return result;
	}
}
