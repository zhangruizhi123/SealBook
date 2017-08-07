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
import com.cjeg.message.MessageVO;
import com.cjeg.mode.Book;
import com.cjeg.service.BookService;

/**
 * 书本的控制类
 * 
 * @author 曹倩倩
 *
 * 创建时间:2017年2月19日 上午10:16:37
 *
 */

@Controller
@RequestMapping("/admin/book")
public class BookController {
	
	@Autowired
	private BookService bookServicep;
	
	//跳转到页面
	@RequestMapping("/index")
	public String index(){
		return "admin/bookmessage";
	}
	
	/**
	 * 添加书籍
	 * @param book
	 * @return
	 */
	@RequestMapping("/add")
	@ResponseBody
	public MessageVO add(Book book){
		MessageVO mv=new MessageVO();
		try{
			book.setId(StringUtils.getUUID32());
			bookServicep.add(book);
			mv.setFlag(true);
			mv.setMessage("添加成功");
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		
		return mv;
	}

	
	/**
	 * 修改书籍
	 */

	@RequestMapping("/update")
	@ResponseBody
	
	public MessageVO update(Book book){
		MessageVO mv=new MessageVO();
		
		try{
			bookServicep.update(book);
			mv.setFlag(true);
			mv.setMessage("修改成功");
		}catch(Exception e){
			e.printStackTrace();
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		return mv;
	}
	
	
	
	/**
	 * 删除列
	 * @param id
	 * @return
	 */
	@RequestMapping("/remove")
	@ResponseBody
	public MessageVO remove(String id){
		MessageVO mv=new MessageVO();
		Book book=new Book();
		book.setId(id);
		bookServicep.remove(book);
		mv.setFlag(true);
		mv.setMessage("删除成功");
		return mv;
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Map<String,Object> list(int page,int rows,String name,String publishingCompany){
		
		Map<String,Object> result = new HashMap<String,Object>();
		Book book=new Book();
		if(name!=null&&!"".equals(name)){
			book.setName(name);
		}
		if(publishingCompany!=null&&!"".equals(publishingCompany)){
			book.setPublishingCompany(publishingCompany);
		}
		RowBounds rowBounds=new RowBounds((page-1)*rows, rows);
		//查询列数
		List<Book> list=bookServicep.listBooks(book, rowBounds);
		long size=bookServicep.countSize(book);
		result.put("total", size);
		result.put("rows", list);
		return result;
	}

}
