package com.cjeg.filter;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cjeg.memcache.MyMemcached;
import com.cjeg.memcache.MySession;

/**
 * Servlet Filter implementation class MyFilter
 */
public class MyFilter implements Filter
{

	/**
	 * Default constructor.
	 */
	public MyFilter()
	{
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy()
	{
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException
	{
		// 获取请求对象,需要借助cookies在客户端保存数据以判断浏览器在一个会话里面
		HttpServletRequest request2 = (HttpServletRequest) request;
		HttpServletResponse response2 = (HttpServletResponse) response;
		System.out.println("----------开始------------");
		Cookie cookie[] = request2.getCookies();
		if (cookie == null)
		{
			// 如果cook不存在,则创建cookie
			String sessionId = MySession.UUID();
			Cookie ck = new Cookie(MySession.SESSIONNAME, sessionId);
			ck.setMaxAge(-1);
			MySession mSession = new MySession();
			mSession.setSessionId(sessionId);
			request2.setAttribute(MySession.SESSIONNAME, mSession);
			response2.addCookie(ck);
		} else
		{
			boolean isExit = false;
			String id = null;
			for (Cookie cookie2 : cookie)
			{
				String name = cookie2.getName();
				if (name.equals("MYSESSION"))
				{
					System.out.println("name:" + name);
					id = cookie2.getValue();
					System.out.println("value:" + id);
					isExit = true;
					break;
				}
			}
			// 如果该cookie不存在，则直接创建
			if (!isExit)
			{
				// 如果cook不存在,则创建cookie
				String sessionId = MySession.UUID();
				Cookie ck = new Cookie(MySession.SESSIONNAME, sessionId);
				// 浏览器从新打开后开始新的cookie
				ck.setMaxAge(-1);
				MySession mSession = new MySession();
				mSession.setSessionId(sessionId);
				request2.setAttribute(MySession.SESSIONNAME, mSession);
				response2.addCookie(ck);
			} else
			{
				// 如果存在则把该id附加到request对象中，便于后面的MySession对象操作
				MySession mSession = new MySession();
				mSession.setSessionId(id);

				String name = (String) mSession.get("name");
				if(name!=null)
				{
					System.out.println("拦截name:" + name);
				}

				request2.setAttribute(MySession.SESSIONNAME, mSession);
			}
		}

		System.out.println("=========结束=============");
		chain.doFilter(request2, response2);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException
	{
		// TODO Auto-generated method stub
	}

}
