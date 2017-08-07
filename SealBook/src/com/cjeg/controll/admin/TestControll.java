package com.cjeg.controll.admin;
//package com.cjeg.controll;
//
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.ibatis.session.RowBounds;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.cjeg.mapper.PeopleMapper;
//import com.cjeg.mode.People;
//import com.google.gson.Gson;
//
//@Controller
//@RequestMapping("/testControll")
//public class TestControll
//{
//	@Autowired
//	private PeopleMapper pm;
//	//呵呵
//	
//	@RequestMapping("/test")
//	@ResponseBody
//	public Map<String,Object>test()
//	{
//		Map<String,Object>map=new HashMap<String,Object>();
//		map.put("zhang","曹倩倩");
//		List<String>ls=new ArrayList<String>();
//		ls.add("hh");
//		ls.add("tt");
//		map.put("ls",ls);
//		return map;
//	}
//	@RequestMapping("/init")
//	public String  init(HttpServletRequest request,HttpServletResponse response) throws IOException
//	{
//		
//		HttpSession session=request.getSession();
//		if(pm==null)
//		{
//			System.out.println("==============");
//		}
//		else
//		{
//			//List<People>ls=pm.selectAll();
//			//session.setAttribute("result", ls);
//		}
//		return "jsp/Success";
//	}
//	@RequestMapping("/query")
//	@ResponseBody
//	public String query(HttpServletResponse response,int page,int rows) throws IOException
//	{
////		System.out.println("::::::::::::::::query");
////		//response.setCharacterEncoding("utf-8");
////		//PrintWriter out=response.getWriter();
////		//分页page,rows
////		long columns=pm.getDataColumn();
////		Map<String,Object>map=new HashMap<String,Object>();
////		RowBounds rowBounds=new RowBounds((page-1)*rows, rows);
////		List<People>ls=pm.selectAll(rowBounds);
////		map.put("rows",ls);
////		map.put("total", columns);
//		
//		Gson gson=new Gson();
//		String json=gson.toJson(map);
//		return json;
//		//out.write(json);
//		/*------------------�������*/
//		/*
//		zhang z=new zhang();
//		z.setId(7);
//		z.setName("sfsdfs");
//		zm.insert(z);
//		Product p=new Product();
//		p.setId((int)(Calendar.getInstance().getTimeInMillis()));
//		p.setNumber((int)(Math.random()*100));
//		p.setCreateTime(Calendar.getInstance().getTime());
//		int t=tm.insertItem(p);
//		if(t>0)
//		{
//			System.out.println("---------�ɹ�----------");
//		}
//		else
//		{
//			System.out.println("---------ʧ��----------");
//		}
//		*/
//		/*------------���Խ���-----------------*/
//		
//	}
//	@RequestMapping("/add")
//	public void add(HttpServletRequest request,People people,PrintWriter out) throws IOException
//	{
//		System.out.println("::::::::::::::::addd:"+people);
//		int result=pm.insertItem(people);
//		if(result==0)
//		{
//			out.write("error");
//		}
//		else
//		{
//			out.write("success");
//		}
//	}
//	@RequestMapping("/delete")
//	public void delete(HttpServletRequest request,HttpServletResponse response) throws IOException
//	{
//		response.setCharacterEncoding("utf-8");
//		PrintWriter out=response.getWriter();
//		String ids=request.getParameter("id");
//		System.out.println("::::::::::::::::delete:"+ids);
//		int id=Integer.parseInt(ids);
//		int row=pm.deleteItem(id);
//		if(row<=0)
//		{
//			out.write("error");
//		}
//		else
//		{
//			out.write("success");
//		}
//	}
//	@RequestMapping("/update")
//	public void update(PrintWriter out,People people) throws Exception
//	{
//		System.out.println("::::::::::::::::update:"+people);
//		int result=pm.updateItem(people);
//		if(result<=0)
//		{
//			out.write("error");
//		}
//		else
//		{
//			out.write("success");
//		}
//		
//	}
//}
