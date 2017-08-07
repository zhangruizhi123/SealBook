package com.cjeg.controll.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cjeg.mapper.BookMapper;
import com.cjeg.mapper.TypeMapper;
import com.cjeg.mapper.UserBookMapper;
import com.cjeg.mapper.UserMapper;
import com.cjeg.mode.Book;
import com.cjeg.mode.BookUserType;
import com.cjeg.mode.Type;
import com.cjeg.mode.User;
import com.cjeg.mode.UserBook;

/**
 * 
 * @author 曹倩倩
 * 
 *         创建时间:2017年3月4日 下午10:00:44
 * 
 */
@Controller
@RequestMapping("/admin/userBook")
public class UserBookController {

	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserBookMapper userBookMapper;
	@Autowired
	private TypeMapper typeMapper;
	@Autowired
	private BookMapper bookMapper;

	@RequestMapping("/index")
	public String index() {
		return "admin/userbook";
	}

	@RequestMapping("/list")
	@ResponseBody
	public Map<String, Object> list(int page, int rows, String name,
			Integer number,Byte status) {
		Map<String,Type> typeMap=new HashMap<String,Type>();
		Map<String,Book> bookMap=new HashMap<String,Book>();
		Map<String, Object> result = new HashMap<String, Object>();
		RowBounds rowBounds=new RowBounds((page-1)*rows,rows);
		UserBook userBook=new UserBook();
		if(number!=null){
			userBook.setNumber(number);
		}
		if(status!=null){
			userBook.setStatus(status);
		}
		List<UserBook> userBookList=userBookMapper.selectBySelective(userBook, rowBounds);
		long total=userBookMapper.countSelective(userBook);
		List<BookUserType> tbList=new ArrayList<BookUserType>();
		if(userBookList!=null&&userBookList.size()>0){
			for(UserBook ub : userBookList){
				String userId=ub.getUserId();
				String typeId=ub.getTypeId();
				String bookId=ub.getBookId();
				User user=userMapper.selectByPrimaryKey(userId);
				Type type=typeMap.get(typeId);
				if(type==null){
					type=typeMapper.selectByPrimaryKey(typeId);
					typeMap.put(typeId, type);
				}
				Book book=bookMap.get(bookId);
				if(book==null){
					book=bookMapper.selectByPrimaryKey(bookId);
					bookMap.put(bookId, book);
				}
				BookUserType but=new BookUserType(book, user, type, ub);
				tbList.add(but);
			}
			result.put("total", total);
			result.put("rows", tbList);
		}
		
		return result;
	}
}
