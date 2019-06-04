package cn.jxufe.controller;

import java.io.File;
import javax.servlet.http.HttpServletRequest;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import cn.jxufe.bean.Message;
import cn.jxufe.utils.FileUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("file")
public class FileController {    
	
    @RequestMapping(value="saveHeadImg",produces=MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Message saveHeadImg(HttpServletRequest request, @RequestParam("filePathName") MultipartFile uploadFile){
    	
    	String originalFilename = uploadFile.getOriginalFilename();
    	String fileFolder = request.getServletContext().getRealPath("images/headImages/");//父级绝对目录
		String fileName = FileUtil.getRandomFileName()+originalFilename.substring(originalFilename.lastIndexOf("."));//随机生成名字
		Message message = new Message();
		
		try {
			uploadFile.transferTo(new File(fileFolder,fileName));
			message.setCode(0);
			message.setMsg("保存成功");
	        JSONObject data = new JSONObject();
	        data.put("fileName", fileName);
	        message.setData(data);
		} catch (Exception e) {
			message.setCode(-10);
	        message.setMsg("文件保存失败");
		} 
		
		return message;
    }   
    
}