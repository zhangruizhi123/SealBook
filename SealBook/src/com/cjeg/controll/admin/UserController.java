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
import com.cjeg.mapper.UserMapper;
import com.cjeg.message.MessageVO;
import com.cjeg.mode.Type;
import com.cjeg.mode.User;

/**
 * 用户信息管理
 * @author 曹倩倩
 *
 * 创建时间:2017年2月28日 下午8:39:53
 *
 */

@Controller
@RequestMapping("/admin/user")
public class UserController {
	
	@Autowired
	private UserMapper userMapper;
	
	
	@RequestMapping("/index")
	public String index(){
		return "admin/user";
	}
	

	@RequestMapping("/list")
	@ResponseBody
	public Map<String,Object> list(int page,int rows,String name){
		Map<String,Object> result = new HashMap<String,Object>();
		User user=new User();
		if(name!=null&&!"".equals(name)){
			user.setName(name);
		}
		RowBounds rowBounds=new RowBounds((page-1)*rows, rows);
		try{
			List<User> list = userMapper.selectBySelective(user, rowBounds);
			long size = userMapper.countSelective(user);
			result.put("total", size);
			result.put("rows", list);
		}catch(Exception e){
			result.put("total",0);
		}
		
		return result;
	}
	@RequestMapping("/update")
	@ResponseBody
	public MessageVO update(User user){
		MessageVO mv=new MessageVO();
		try{
			if(user.getPassword()==null){
				user.setPassword(StringUtils.getMD5("123456"));
			}
			userMapper.updateByPrimaryKeySelective(user);
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
			userMapper.deleteByPrimaryKey(id);
			mv.setFlag(true);
			mv.setMessage("删除成功");
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		return mv;
	}
	
}
