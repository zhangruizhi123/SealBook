package com.cjeg.listener;

import java.util.Calendar;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class MyListener implements ServletContextListener, Runnable
{
	private static final long DELAY=10;
	private static ScheduledExecutorService schedule=Executors.newScheduledThreadPool(1);
	private SqlSession session=null;
	@Override
	public void contextDestroyed(ServletContextEvent arg0)
	{
		if(session!=null)
		{
			session.close();
		}
		System.out.println("监听器关闭");
	}

	@Override
	public void contextInitialized(ServletContextEvent contextEvent)
	{
		/*
		System.out.println("[监听器开启]");
		schedule.scheduleAtFixedRate(this, 0, DELAY, TimeUnit.SECONDS);
		WebApplicationContext webContent=WebApplicationContextUtils.getWebApplicationContext(contextEvent.getServletContext());
		if(webContent!=null)
		{
			SqlSessionFactory factory=(SqlSessionFactory)webContent.getBean("sqlSessionFactory");
			if(factory!=null)
			{
				session = factory.openSession();
			}
	
		}
		*/
	}
	
	//这里编写需要添加的操作
		public synchronized void run()
		{
			
			Calendar cal=Calendar.getInstance();
			String time=cal.get(Calendar.YEAR)+"/"+cal.get(Calendar.MONTH)+"/"+cal.get(Calendar.DAY_OF_MONTH)+"\t"+cal.get(Calendar.HOUR_OF_DAY)+":"+cal.get(Calendar.MINUTE)+":"+cal.get(Calendar.SECOND);
			System.out.println("[-----开始一次任务----]"+time);
			try
			{
				if(session!=null)
				{
					//后台操作数据库例子
					//PeopleMapper peopleMapper=session.getMapper(PeopleMapper.class);
					//int size=peopleMapper.getDataColumn();
					//System.out.println("数据库当前数据量  "+ size);
					session.commit();
					System.out.println("[-----一次任务结束----]");
				}
				
			}
			catch(Exception e)
			{
				System.out.println("[本次任务失败]  "+time);
			}
		}

}
