package com.cjeg.controll.fornt;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cjeg.Util.StringUtils;
import com.cjeg.mapper.BookMapper;
import com.cjeg.mapper.TypeMapper;
import com.cjeg.message.MessageVO;
import com.cjeg.mode.Book;
import com.cjeg.mode.Type;

/**
 * 详情页面
 * @author 曹倩倩
 *
 * 创建时间:2017年2月26日 下午2:30:44
 *
 */

@Controller
@RequestMapping("/detail")
public class Details {
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private TypeMapper typeMapper;
	
	
	/**
	 * 根据书籍类型查询书籍
	 * @param type
	 * @return
	 */
	@RequestMapping("/listDetailByTypes")
	public String listDetailByTypes(Integer page,Integer size,String type,HttpServletRequest request){
		MessageVO mv=new MessageVO();
		HttpSession session=request.getSession();
		Book book=new Book();
		book.setType(type);
		RowBounds rowBounds=null;
		//默认分页为20
		if(page==null){
			page=1;
			size=3;
			rowBounds=new RowBounds(0,3);
		}else{
			rowBounds=new RowBounds((page-1)*size,size);
		}
		List<Book> bookList=bookMapper.selectBySelective(book, rowBounds);
		long number=bookMapper.countBySelective(book);
		if(bookList!=null&&bookList.size()>0){
			mv.setFlag(true);
			mv.setData(bookList);
		}else{
			mv.setFlag(false);
			mv.setMessage("暂时还没有数据.");
		}
		session.setAttribute("data", mv);
		session.setAttribute("total", number);
		session.setAttribute("type", type);
		session.setAttribute("page", page);
		session.setAttribute("size", size);
		return "fornt/details";
	}
	
	/**
	 * 根据书籍的id跳转到购书界面
	 * @return
	 */
	@RequestMapping("/findByBookId")
	public String getBookByBookId(String id,HttpServletRequest request){
		HttpSession session=request.getSession();
		MessageVO mv=new MessageVO();
		if(StringUtils.isEmpty(id)){
			mv.setMessage("查询错误");
			mv.setFlag(false);
			session.setAttribute("data", mv);
			return "error";
		}
		try{
			Book book=bookMapper.selectByPrimaryKey(id);
			if(book!=null){
				mv.setMessage("查询成功");
				mv.setFlag(true);
				mv.setObj(book);
				session.setAttribute("data", mv);
				return "fornt/buy";
			}else{
				mv.setMessage("无法查询到该书籍");
				mv.setFlag(false);
				session.setAttribute("data", mv);
				return "error";
			}
		}catch(Exception e){
			mv.setMessage("查询错误");
			mv.setFlag(false);
			session.setAttribute("data", mv);
			return "error";
		}
		
	}
	/**
	 * 获取书籍的类型
	 * @return
	 */
	@RequestMapping("/getBookTypes")
	@ResponseBody
	public MessageVO getBookTypes(){
		MessageVO mv=new MessageVO();
		List<Type> typeList=typeMapper.selectBySelective(new Type(), new RowBounds());
		if(typeList!=null&&typeList.size()>0){
			mv.setFlag(true);
			mv.setData(typeList);
		}else{
			mv.setFlag(false);
			mv.setMessage("类型列表为空");
		}
		return mv;
	}
}
