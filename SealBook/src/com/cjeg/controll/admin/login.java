package com.cjeg.controll.admin;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.ibatis.session.RowBounds;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import sun.font.FontDesignMetrics;

import com.cjeg.Util.DateUtils;
import com.cjeg.Util.StringUtils;
import com.cjeg.consts.Consts;
import com.cjeg.core.Configs;
import com.cjeg.mapper.BookMapper;
import com.cjeg.mapper.UserMapper;
import com.cjeg.mode.User;

@Controller
public class login
{
	private Logger logger=Logger.getLogger(login.class);
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private PropertyPlaceholderConfigurer configBean;
	
	@Autowired
	private Configs configs;
	
	//将根目录重定向到index页面
	@RequestMapping("/")
	public String init(){
		logger.debug("页面从定向到bindex页面");
		return "redirect:/index";
	}
	
	
	@RequestMapping("/{path}")
	public String  index(@PathVariable String path){
		//对后台进行从定向
		if(path.equals("admin")){
			return "redirect:/admin/login";
		}
		logger.info("页面从定向到"+path+"页面");
		return path;
	}
	
	/**
	 * 用户登录界面
	 * @return
	 */
	@RequestMapping("/user/login")
	public String login(){
		return "fornt/login";
	}
	
	/**
	 * 用户退出
	 * @return
	 */
	@RequestMapping("/user/logout")
	public String logout(HttpServletRequest request){
		HttpSession session=request.getSession();
		session.setAttribute(Consts.USER_SESSION, null);
		return "redirect:/index";
	}
	
	
	/**
	 * 提交表单用户登录
	 * @return
	 */
	@RequestMapping("/user/loginSubmit")
	public String loginSubmit(String userName,String password,String code,HttpServletRequest request){
		HttpSession session=request.getSession();
		String codeMem=(String)session.getAttribute(Consts.IMAGE_SESSION);
		if(StringUtils.isEmpty(userName)){
			session.setAttribute("flag", false);
			session.setAttribute("msg", "用户名不能为空");
		} else if(StringUtils.isEmpty(password)){
			session.setAttribute("flag", false);
			session.setAttribute("msg", "密码不能为空");
		}else if(StringUtils.isEmpty(code)){
			session.setAttribute("flag", false);
			session.setAttribute("msg","图像验证码不能为空!");
		}else if(!isEquals(code, codeMem)){
			session.setAttribute("flag", false);
			session.setAttribute("msg","图像验证码不正确!");
		}else{
			
			User user=new User();
			user.setName(userName);
			user.setPassword(StringUtils.getMD5(password));
			List<User> list=userMapper.selectBySelective(user, new RowBounds());
			if(list!=null&&list.size()>0){
				session.setAttribute("flag", true);
				session.setAttribute("msg", "登录成功");
				User us=list.get(0);
				session.setAttribute(Consts.USER_SESSION, us);
				return "redirect:/index";
			}else{
				session.setAttribute("flag", false);
				session.setAttribute("msg", "用户名或密码错误！");
			}
			
		}
		return "redirect:/user/login";
	}
	
	/**
	 * 用户注册界面
	 * @return
	 */
	@RequestMapping("/user/register")
	public String register(HttpServletRequest request){
		return "fornt/register";
	}
	
	
	/**
	 * 注册信息
	 * @return
	 */
	@RequestMapping("/user/registerSubmit")
	public String registerSubmit(User user,String code,String repassword,HttpServletRequest request){
		HttpSession session=request.getSession();
		String codeMem=(String)session.getAttribute(Consts.IMAGE_SESSION);
		if(user!=null){
			String name=user.getName();
			//验证该用户名是否存在
			if(name!=null){
				User us=new User();
				us.setName(name);
				List<User> userList=userMapper.selectBySelective(us,new RowBounds());
				if(userList!=null&&userList.size()>0){
					session.setAttribute("flag", false);
					session.setAttribute("msg","该用户名已经存在!");
					return "redirect:/user/register";
				}
			}
			
			//判断该手机号是否存在
			String phone=user.getPhone();
			if(phone!=null){
				User us=new User();
				us.setName(phone);
				List<User> userList=userMapper.selectBySelective(us,new RowBounds());
				if(userList!=null&&userList.size()>0){
					session.setAttribute("flag", false);
					session.setAttribute("msg","该电话号码已经存在!");
					return "redirect:/user/register";
				}
			}
		}
		
		if(StringUtils.isEmpty(user.getName())){
			session.setAttribute("flag", false);
			session.setAttribute("msg","用户名不能为空!");
			return "redirect:/user/register";
		}else if(StringUtils.isEmpty(user.getMail())){
			session.setAttribute("flag", false);
			session.setAttribute("msg","邮箱不能为空!");
			return "redirect:/user/register";
		}else if(StringUtils.isEmpty(code)){
			session.setAttribute("flag", false);
			session.setAttribute("msg","图像验证码不能为空!");
			return "redirect:/user/register";
		}else if(!isEquals(code, codeMem)){
			session.setAttribute("flag", false);
			session.setAttribute("msg","图像验证码不正确!");
			return "redirect:/user/register";
		}
		//设置用户id
		user.setId(StringUtils.getUUID32());
		String password=user.getPassword();
		if(password!=null&&repassword!=null){
			if(!password.equals(repassword)){
				session.setAttribute("flag", false);
				session.setAttribute("msg","密码和确认码不相同!");
				return "redirect:/user/register";
			}
		}else{
			session.setAttribute("flag", false);
			session.setAttribute("msg","密码或者确认码不能为空!");
			return "redirect:/user/register";
		}
		
		try{
			user.setPassword(StringUtils.getMD5(password));
			user.setCreateTime(DateUtils.getCurrentDate());
			user.setUpdateTime(DateUtils.getCurrentDate());
			userMapper.insertSelective(user);
		}catch(Exception e){
			e.printStackTrace();
			session.setAttribute("flag", false);
			session.setAttribute("msg",e.getMessage());
			return "redirect:/user/register";
		}
		
		session.setAttribute("flag", true);
		session.setAttribute("msg","注册成功");
		return "redirect:/user/login";
	}
	
	/**
	 * 图片验证码
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/user/img")
	public void getImage(HttpServletRequest request,HttpServletResponse response) throws Exception{
		HttpSession session = request.getSession();
		OutputStream output=response.getOutputStream();
		String code=writeImage(output);
		//图片验证码
		session.setAttribute(Consts.IMAGE_SESSION, code);
		output.close();
	}
	
	private String writeImage(OutputStream output) throws IOException{
		Font font=new Font("",Font.BOLD, 60);
		FontMetrics fm=FontDesignMetrics.getMetrics(font);
		BufferedImage bufferedImage=new BufferedImage(200, 100, BufferedImage.TYPE_4BYTE_ABGR);
		Graphics2D g2=(Graphics2D)bufferedImage.getGraphics();
		g2.setFont(font);
		String str=RandomStringUtils.random(4, Consts.RANDOM_CODE);
		g2.setColor(Color.BLACK);
		g2.drawString(str, 30,fm.getHeight());
		ImageIO.write(bufferedImage, "png", output);
		return str;
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
