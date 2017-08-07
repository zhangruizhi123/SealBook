package com.cjeg.controll.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cjeg.Util.StringUtils;
import com.cjeg.message.MessageVO;
import com.cjeg.mode.Type;
import com.cjeg.service.TypeService;

/**
 * 
 * @author 曹倩倩
 *
 * 创建时间:2017年2月22日 下午10:45:16
 *
 */
@Controller
@RequestMapping("/admin/type")
public class TypeController {
	
	@Autowired
	private TypeService typeService;
	/**
	 * 跳转到页面
	 * @return
	 */
	@RequestMapping("/index")
	public String index(){
		return "admin/type";
	}
	
	/**
	 * 添加数据
	 * @param type
	 * @return
	 */
	@RequestMapping("/add")
	@ResponseBody
	public MessageVO add(Type type){
		MessageVO mv=null;
		try{
			type.setId(StringUtils.getUUID32());
			if(type.getSort()==null){
				type.setSort((byte)0);
			}
			mv=typeService.add(type);
		}catch(Exception e){
			mv=new MessageVO();
			mv.setFlag(false);
			mv.setMessage("添加失败");
		}
		return mv;
	}
	
	@RequestMapping("/remove")
	@ResponseBody
	public MessageVO remove(Type type){
		MessageVO mv=null;
		try{
			mv=typeService.remove(type);
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage("删除失败");
		}
		return mv;
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public MessageVO update(Type type){
		MessageVO mv=null;
		try{
			mv=typeService.update(type);
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage("修改失败");
		}
		return mv;
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Map<String,Object> list(int page,int rows,String name){
		Map<String,Object> result = new HashMap<String,Object>();
		Type type=new Type();
		if(name!=null&&!"".equals(name)){
			type.setName(name);
		}
		RowBounds rowBounds=new RowBounds((page-1)*rows, rows);
		try{
			List<Type>list=typeService.list(type, rowBounds);
			long size=typeService.countSize(type);
			result.put("total", size);
			result.put("rows", list);
		}catch(Exception e){
			result.put("total",0);
		}
		
		return result;
	}
	
	@RequestMapping("/allTypes")
	@ResponseBody
	public MessageVO listAllType(){
		MessageVO mv=new MessageVO();
		try{
			RowBounds rowBounds=new RowBounds();
			Type type=new Type();
			List<Type>list=typeService.list(type, rowBounds);
			mv.setFlag(true);
			mv.setData(list);
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		return mv;
	}
	
}
