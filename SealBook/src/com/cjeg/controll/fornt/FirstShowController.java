package com.cjeg.controll.fornt;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cjeg.consts.Consts;
import com.cjeg.mapper.BookMapper;
import com.cjeg.mapper.DicMapper;
import com.cjeg.mapper.TypeMapper;
import com.cjeg.message.MessageVO;
import com.cjeg.mode.Book;
import com.cjeg.mode.Dic;
import com.cjeg.mode.Type;
import com.cjeg.mode.TypeBooks;

/**
 * 
 * @author 曹倩倩
 * 
 *         创建时间:2017年2月25日 下午9:48:24
 * 
 */
@Controller
@RequestMapping("/first")
public class FirstShowController {
	// 注入字典类
	@Autowired
	private DicMapper dicMapper;
	
	@Autowired
	private TypeMapper typeMapper;
	
	@Autowired
	private BookMapper bookMapper;

	// 获取公告信息
	@RequestMapping("/notice")
	@ResponseBody
	public MessageVO getNotice() {
		MessageVO mv = new MessageVO();
		String notice = getValues(Consts.NOTICE_MESSAGE);
		mv.setFlag(true);
		mv.setObj(notice);
		return mv;
	}

	/**
	 * 根据name属性获取值,当为空时返回 ""
	 * 
	 * @param name
	 * @return
	 */
	private String getValues(String name) {
		List<Dic> list = dicMapper.selectByName(name);
		if (list != null && list.size() > 0) {
			String value = list.get(0).getValue();
			return value;
		}
		return "";
	}
	
	/**
	 * 查询图片相关的信息
	 * @return
	 */
	@RequestMapping("/getImage")
	@ResponseBody
	public MessageVO getImages(){
		MessageVO mv = new MessageVO();
		Map<String,String>result=new HashMap<String,String>();
		try{
			result.put("name", getValues(Consts.FIRST_BOOK_NAME));
			result.put("src", getValues(Consts.FIRST_IMG));
			result.put("descripts", getValues(Consts.FIRST_BOOK_DESCRIPTS));
			result.put("link", getValues(Consts.FIRST_BOOK_LINK));
			mv.setFlag(true);
			mv.setMessage("查询成功");
			List<Map<String,String>> list=new ArrayList<Map<String,String>>();
			list.add(result);
			mv.setData(list);
			mv.setFlag(true);
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 前台根据记查询出首页要展示的数据
	 * @param number 每个栏目要显示多少条
	 * @return
	 */
	@RequestMapping("/listBookTypes")
	@ResponseBody
	public MessageVO listBookTypes(int number){
		MessageVO mv = new MessageVO();
		RowBounds rowBounds=new RowBounds(0, number);
		Type type=new Type();
		type.setShows(true);
		type.setSort((byte)1);
		List<TypeBooks> typeBooks=new ArrayList<TypeBooks>();
		List<Type> typeList=typeMapper.selectBySelective(type, rowBounds);
		if(typeList!=null){
			for(Type tp:typeList){
				TypeBooks typeBook=new TypeBooks();
				typeBook.setType(tp);
				String typeId = tp.getId();
				Book book=new Book();
				book.setType(typeId);
				List<Book> bookList=bookMapper.selectBySelective(book, rowBounds);
				typeBook.setBooks(bookList);
				typeBooks.add(typeBook);
			}
		}
		
		mv.setFlag(true);
		mv.setData(typeBooks);
		return mv;
	}
	
	

}
