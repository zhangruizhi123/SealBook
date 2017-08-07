package com.cjeg.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.cjeg.consts.Consts;

/**
 * 控制后台登录权限问题
 * @author 曹倩倩
 *
 * 创建时间:2017年2月23日 下午9:52:43
 *
 */
public class MyAuthorInterceptor implements HandlerInterceptor{
	
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		String url=request.getRequestURI();
		url=url.replaceAll(request.getContextPath(), "");
		//除去登录的链接
		if(url.equals("/admin")||url.equals("/admin/login")||url.equals("/admin/loginSubmit")){
			return true;
		}else{
			//当session中存在数据时直接登录，否者就从定向到登录页面
			if(request.getSession().getAttribute(Consts.ADMIN_SESSION)==null){
				//暂时先注释掉，便于开发
				response.sendRedirect(request.getContextPath() + "/admin"); 
				return true;
			}
		}
		//response.sendRedirect(request.getContextPath() + "/index"); 
		return true;
	}
}
