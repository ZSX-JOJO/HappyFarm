package cn.jxufe.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.jxufe.entity.Category;

@Controller
@RequestMapping("category")
public class CategoryController extends BaseController{
	
	@ResponseBody
	@RequestMapping("listCategory")
	public List<Category> listCategory() {
		List<Category> categories = categoryService.findAll();
		return categories;
	}
	
}
