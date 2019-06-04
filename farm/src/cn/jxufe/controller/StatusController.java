package cn.jxufe.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.jxufe.entity.Status;

@Controller
@RequestMapping("status")
public class StatusController extends BaseController{
	
	@ResponseBody
	@RequestMapping("listStatus")
	public List<Status> listStatus() {
		List<Status> status = statusService.findAll();
		return status;
	}
}
