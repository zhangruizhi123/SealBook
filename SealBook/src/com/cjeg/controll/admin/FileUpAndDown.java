package com.cjeg.controll.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.cjeg.Util.StringUtils;
import com.cjeg.core.Configs;
import com.cjeg.memcache.MySession;

@Controller
@RequestMapping("/file")
public class FileUpAndDown
{
	@Autowired
	private  Configs configs;
	/**
	 * 进入文件上传界面
	 * @return
	 */
	@RequestMapping("/init")
	public String init()
	{
		return "file/upload";
	}
	
	/**
	 * 进入文件上传,成功返回文件的路径前面加一个file便于从新定向
	 * @param files 
	 * @param sex
	 * @param response
	 * @return
	 */
	@RequestMapping("/upload")
	@ResponseBody
	public Map<String,Object> uploadFile(@RequestParam(value="abc") MultipartFile files,String sex,HttpServletResponse response)
	{
		Map<String,Object> result=new HashMap<String, Object>();
		String basePath=configs.getValue("fileUploadPath");
		CommonsMultipartFile cFiles=(CommonsMultipartFile) files;

		//图片的名字
		String org=cFiles.getOriginalFilename();
		//.png
		String end =org.substring(org.lastIndexOf("."),org.length());
		String name=StringUtils.getUUID32()+end;
		
		try {
			//保存文件
			cFiles.transferTo(new File(basePath,name));
			result.put("flag", true);
			result.put("src", "files/"+name);
		} catch (Exception e) {
			result.put("flag", false);
		}
		
		return result;
	}
	
	
	@RequestMapping("/regester")
	@ResponseBody
	public String regester(HttpServletRequest request,String name)
	{
		System.out.println("注册成功");
		MySession session=(MySession) request.getAttribute(MySession.SESSIONNAME);
		session.add("name", name);
		return "ok";
	}
	@RequestMapping("/download")
	public void download(HttpServletRequest request,HttpServletResponse response)
	{
	}
}
