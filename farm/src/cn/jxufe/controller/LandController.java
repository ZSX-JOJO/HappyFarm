package cn.jxufe.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.jxufe.entity.Land;

@Controller
@RequestMapping("land")
public class LandController extends BaseController{
	
	@ResponseBody
	@RequestMapping("listLand")
	public List<Land> listLand(Model model) {
		List<Land> lands = landService.findAll();
		model.addAttribute("lands", lands);
		return lands;
	}
}
