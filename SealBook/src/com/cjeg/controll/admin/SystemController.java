package com.cjeg.controll.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cjeg.Util.DateUtils;
import com.cjeg.Util.StringUtils;
import com.cjeg.mapper.AdminUserMapper;
import com.cjeg.message.MessageVO;
import com.cjeg.mode.AdminUser;

/**
 * 系统管理
 * @author 曹倩倩
 *
 * 创建时间:2017年3月1日 下午10:21:26
 *
 */
@Controller
@RequestMapping("/admin/system")
public class SystemController {
	
	@Autowired
	private AdminUserMapper adminUserMapper;
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String index(){
		System.out.println("系统管理");
		return "admin/system";
	}
	
	
	@RequestMapping("/list")
	@ResponseBody
	public Map<String,Object> list(int page,int rows,String name){
		Map<String,Object> result = new HashMap<String,Object>();
		AdminUser user=new AdminUser();
		if(name!=null&&!"".equals(name)){
			user.setName(name);
		}
		RowBounds rowBounds=new RowBounds((page-1)*rows, rows);
		try{
			List<AdminUser> list=adminUserMapper.selectBySelective(user, rowBounds);
			long size = adminUserMapper.countSelective(user);
			result.put("total", size);
			result.put("rows", list);
		}catch(Exception e){
			result.put("total",0);
		}
		
		return result;
	}
	@RequestMapping("/update")
	@ResponseBody
	public MessageVO update(AdminUser user,String repassword){
		MessageVO mv=new MessageVO();
		if(!repassword.equals(user.getPassword())){
			mv.setFlag(false);
			mv.setMessage("确认码和密码不相同.");
			return mv;
		}
		if(user.getPassword()!=null){
			user.setPassword(StringUtils.getMD5(user.getPassword()));
		}
		try{
			user.setUpdateTime(DateUtils.getCurrentDate());
			adminUserMapper.updateByPrimaryKeySelective(user);
			mv.setFlag(true);
			mv.setMessage("修改成功");
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		return mv;
	}
	@RequestMapping("/remove")
	@ResponseBody
	public MessageVO remove(String id){
		MessageVO mv=new MessageVO();
		try{
			adminUserMapper.deleteByPrimaryKey(id);
			mv.setFlag(true);
			mv.setMessage("删除成功");
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		return mv;
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public MessageVO add(AdminUser user,String repassword){
		MessageVO mv=new MessageVO();
		if(!repassword.equals(user.getPassword())){
			mv.setFlag(false);
			mv.setMessage("确认码和密码不相同.");
			return mv;
		}
		user.setId(StringUtils.getUUID32());
		user.setPassword(StringUtils.getMD5(user.getPassword()));
		user.setCreateTime(DateUtils.getCurrentDate());
		user.setUpdateTime(DateUtils.getCurrentDate());
		try{
			adminUserMapper.insertSelective(user);
			mv.setFlag(true);
			mv.setMessage("插入成功");
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		return mv;
	}
}
