package cn.jxufe.service;

import java.util.List;
import javax.servlet.http.HttpSession;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.Plant;
import cn.jxufe.entity.Seed;
import cn.jxufe.entity.User;

public interface PlantService extends BaseService{
	public Message save(Plant plant);
	public Message delete(Plant plant);
	public Message toNextPhase(Plant plant);
	public Message checkSow(Plant plant,HttpSession session);
	public List<Plant> findAll();
	public void fillPlant(Plant plant);
	public Message fillSowData(Plant plant,Seed seed);
	public List<Plant> findByUser(User user);
	public void cleanPlant(Plant plant);
	public void killWorm(Plant plant);
}
