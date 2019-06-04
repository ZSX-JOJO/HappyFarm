package cn.jxufe.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import cn.jxufe.entity.Category;
import cn.jxufe.entity.Land;
import cn.jxufe.entity.Status;
import cn.jxufe.service.CategoryService;
import cn.jxufe.service.LandService;
import cn.jxufe.service.PhaseService;
import cn.jxufe.service.PlantService;
import cn.jxufe.service.RepositoryService;
import cn.jxufe.service.SeedService;
import cn.jxufe.service.StatusService;
import cn.jxufe.service.UserService;

public class BaseController {

	@Autowired
	SeedService seedService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	LandService landService;
	@Autowired
	StatusService statusService;
	@Autowired
	PhaseService phaseService;
	@Autowired
	UserService userService;
	@Autowired
	RepositoryService repositoryService;
	@Autowired
	PlantService plantService;
	
	public void initMap(HttpSession session) {
		//因为EasyUI DataGrid Column 只支持基本数据类型，所以没有使用jpa提供的@JoinColumn，而是直接使用外键id
		//对categoryId,landId,statusId和name的映射
		List<Category> categories = categoryService.findAll();
		List<Land> lands = landService.findAll();
		List<Status> statuslist = statusService.findAll();
		session.setAttribute("categories" , categories);
		session.setAttribute("lands" , lands);
		session.setAttribute("statuslist" , statuslist);
	}
}
