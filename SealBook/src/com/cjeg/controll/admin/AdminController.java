package com.cjeg.controll.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cjeg.Util.StringUtils;
import com.cjeg.consts.Consts;
import com.cjeg.mapper.AdminUserMapper;
import com.cjeg.mode.AdminUser;

/**
 * 后台页面的管理
 * @author 曹倩倩
 *
 * 创建时间:2017年2月19日 上午10:56:04
 *
 */

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminUserMapper  adminUserMapper;
	/**
	 * 页面重定向到登录页面
	 * @return
	 */
	@RequestMapping("/login")
	public String login(){
		return "fornt/adminlogin";
	}
	@RequestMapping("/index")
	public String index(HttpServletRequest request){
		
		return "admin/home";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		HttpSession session = request.getSession();
		session.setAttribute(Consts.ADMIN_SESSION, null);
		return "redirect:/admin/login";
	}
	@RequestMapping("/loginSubmit")
	public String loginSubmit(String userName,String password,String code,HttpServletRequest request){
		HttpSession session=request.getSession();
		String img=(String) session.getAttribute(Consts.IMAGE_SESSION);
		//清空图像验证码
		session.setAttribute(Consts.IMAGE_SESSION,null);
		if(StringUtils.isEmpty(userName)){
			session.setAttribute("flag", false);
			session.setAttribute("msg", "用户名不能为空!");
		}else if(StringUtils.isEmpty(userName)){
			session.setAttribute("flag", false);
			session.setAttribute("msg", "密码不能为空!");
		}else if(StringUtils.isEmpty(code)){
			session.setAttribute("flag", false);
			session.setAttribute("msg", "图像验证码不能为空!");
		}else if(img==null||!isEquals(img,code)){
			session.setAttribute("flag", false);
			session.setAttribute("msg", "图像验证码不正确!");
		}else{
			AdminUser user=new AdminUser();
			user.setName(userName);
			user.setPassword(StringUtils.getMD5(password));
			try{
				AdminUser sessionUser=adminUserMapper.login(user);
				if(sessionUser==null){
					session.setAttribute("flag", false);
					session.setAttribute("msg", "用户名或密码错误!");
				}else{
					session.setAttribute("flag", true);
					session.setAttribute("msg", "登录成功!");
					session.setAttribute(Consts.ADMIN_SESSION, sessionUser);
					return "redirect:/admin/index";
				}
			}catch(Exception e){
				session.setAttribute("flag", false);
				session.setAttribute("msg", "登录失败!");
			}
		}
		return "redirect:/admin/login";
	}
	
	private boolean isEquals(String code,String code2){
		code=code.toLowerCase();
		code2=code2.toLowerCase();
		if(code2.equals(code)){
			return true;
		}
		return false;
	}
}
