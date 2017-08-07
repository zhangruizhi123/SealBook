package com.cjeg.controll.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cjeg.mode.Book;

/**
 * 
 * @author 曹倩倩
 *
 * 创建时间:2017年2月22日 下午10:06:57
 *
 */
@Controller
@RequestMapping("/test")
public class Test {
	
	
	@RequestMapping("/abc")
	@ResponseBody
	public Book test(Book book){
		return book;
	}
}
