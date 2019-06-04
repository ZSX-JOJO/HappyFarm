package cn.jxufe.service.impl;

import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.Plant;
import cn.jxufe.entity.User;
import cn.jxufe.service.GameService;
import cn.jxufe.service.PhaseService;
import cn.jxufe.service.PlantService;
import cn.jxufe.websocket.FarmActionHandler;
import net.sf.json.JSONObject;

@Service("gameService")
public class GameServiceImpl extends BaseServiceImpl implements GameService{

	@Autowired
	PlantService plantService;
	@Autowired
	PhaseService phaseService;
	@Autowired
	FarmActionHandler farmActionHandler;
	
	Timer timer = new Timer();  
	@Override
	public void gameStart() {
	    timer.schedule(
	            new TimerTask() {
	                    @Override
	                     public void run() {
	                            //System.out.println("状态轮询[" + new Date()+"]");
	                            checkCropStatus();
	                        }
	                    }, 0,2000);
	}
	
	/* *
	 * 	检查所有的plant,这些plant代表已经种植了的作物，即使用户没有登录也照样生长
	 * 	如果plant.phase处在该阶段的time大于等于plant.phase.gtime(生长时间)，则进入下一阶段
	 * 	通过WebSocket发送更新后的plant给用户
	 * */
	public void checkCropStatus() {
		List<Plant> plants = plantService.findAll();
		
		for(Plant plant:plants) {
			if(plant.getPhase()==null) continue;
			int time = plant.getTime();
			int gtime = plant.getPhase().getGrowthTime();
			if(time >= gtime) {
				Message message = plantService.toNextPhase(plant);
				sendMessage(message,plant);
			}else {
				plant.setTime(time+2);
				plantService.save(plant);
			}
		}
	}
	
	public void sendMessage(Message message,Plant plant) {
		if(message.getCode()==0) {
			/*进入下一阶段,如果用户在线将会把信息发送给用户*/
			User user = plant.getUser();
			String jsonInf = JSONObject.fromObject(plant).toString();
			System.out.println(jsonInf);
			farmActionHandler.sendMessageToUser(user.getId(), new TextMessage(jsonInf));
		}
		
		if(message.getCode()==1) {//没有下一阶段
			
		}
		
		if(message.getCode()==-10) {
			/*发生异常*/
			System.out.println(message.getMsg());
		}
	}
	
}
