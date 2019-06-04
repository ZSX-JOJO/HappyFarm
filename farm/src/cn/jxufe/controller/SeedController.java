package cn.jxufe.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.EasyUIDataPageRequest;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.Seed;

@Controller
@RequestMapping("seed")
public class SeedController extends BaseController{

	@RequestMapping(value = "grid")
	public String grid(HttpSession session) {
		initMap(session);
		return "seed/grid";
	}

	@RequestMapping(value = "gridData", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public EasyUIData<?> gridData(EasyUIDataPageRequest pageRequest,
			@RequestParam(defaultValue = "allSeed") String name) {
		List<Sort.Order> orders = new ArrayList<Sort.Order>();
		if (pageRequest.getOrder().equals("asc"))
			orders.add(new Sort.Order(Direction.ASC, pageRequest.getSort()));
		else
			orders.add(new Sort.Order(Direction.DESC, pageRequest.getSort()));

		Pageable pageable = new PageRequest(pageRequest.getPage() - 1, 
				pageRequest.getRows(), new Sort(orders));
		
		if(name.equals("allSeed"))
			return seedService.findAll(pageable);
		
		return seedService.findSeedsByName("%"+name+"%", pageable);
	}

	@RequestMapping(value = "save", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message save(Seed seed) {
		return seedService.save(seed);
	}

	@RequestMapping(value = "delete", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message delete(Seed seed) {
		return seedService.delete(seed);
	}
}
