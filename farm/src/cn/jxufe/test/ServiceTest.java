package cn.jxufe.test;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.jxufe.entity.Plant;
import cn.jxufe.entity.User;
import cn.jxufe.service.PlantService;

public class ServiceTest {

	static ApplicationContext ctx ;
	
	static {
		ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
	}
	
	@Test
	public void test() {
		PlantService plantService = (PlantService) ctx.getBean("PlantService");
		User user = new User();
		user.setId(1);
		List<Plant> plants = plantService.findAll();
		System.out.println(plants.size());
	}
}
