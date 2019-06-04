package cn.jxufe.controller;

import java.util.ArrayList;
import java.util.List;

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
import cn.jxufe.entity.Phase;

@Controller
@RequestMapping("phase")
public class PhaseController extends BaseController{
	
	@RequestMapping(value = "findBySeedId", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<Phase> findBySeedId(long seedId){
		return phaseService.findPhaseBySeedId(seedId);
	}

	@RequestMapping(value = "gridData", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public EasyUIData<?> gridData(EasyUIDataPageRequest pageRequest,
			@RequestParam(defaultValue = "0")long seedId) {
		List<Sort.Order> orders = new ArrayList<Sort.Order>();
		if (pageRequest.getOrder().equals("asc"))
			orders.add(new Sort.Order(Direction.ASC, pageRequest.getSort()));
		else
			orders.add(new Sort.Order(Direction.DESC, pageRequest.getSort()));

		Pageable pageable = new PageRequest(pageRequest.getPage() - 1, 
				pageRequest.getRows(), new Sort(orders));
		
		return phaseService.findPhasesBySeedId(seedId, pageable);
	}
	
	@RequestMapping(value = "save", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message save(Phase phase) {
		return phaseService.save(phase);
	}

	@RequestMapping(value = "delete", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message delete(Phase phase) {
		return phaseService.delete(phase);
	}
}
