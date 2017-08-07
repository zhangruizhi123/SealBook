package com.cjeg.controll.fornt;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cjeg.Util.DateUtils;
import com.cjeg.Util.StringUtils;
import com.cjeg.consts.Consts;
import com.cjeg.mapper.BookMapper;
import com.cjeg.mapper.TypeMapper;
import com.cjeg.mapper.UserBookMapper;
import com.cjeg.message.MessageVO;
import com.cjeg.mode.Book;
import com.cjeg.mode.TBook;
import com.cjeg.mode.Type;
import com.cjeg.mode.User;
import com.cjeg.mode.UserBook;

/**
 * 
 * @author 曹倩倩
 *
 * 创建时间:2017年3月4日 下午1:32:07
 *
 */
@Controller
@RequestMapping("/buyBook")
public class BuyBook {
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private TypeMapper typeMapper;
	
	@Autowired
	private UserBookMapper userBookMapper;
	
	/**
	 * 向购物车中添加商品
	 * @param request
	 * @param id 书籍id
	 * @return
	 */
	@RequestMapping("/addGoodsCar")
	@ResponseBody
	public MessageVO addGoodsCar(HttpServletRequest request,String id,int number){
		MessageVO mv=new MessageVO();
		HttpSession session=request.getSession();
		if(session.getAttribute(Consts.USER_SESSION)==null){
			mv.setFlag(false);
			mv.setMessage("请先登录在添加商品");
		}else if(id==null){
			mv.setFlag(false);
			mv.setMessage("书籍信息不正确!");
		}else{
			User user=(User)session.getAttribute(Consts.USER_SESSION);
			Book book=bookMapper.selectByPrimaryKey(id);
			if(book==null){
				mv.setFlag(false);
				mv.setMessage("无法查询到该书籍!");
			}else{
				try{
					UserBook userBook=new UserBook();
					userBook.setId(StringUtils.getUUID32());
					userBook.setCreateTime(DateUtils.getCurrentDate());
					userBook.setUpdateTime(DateUtils.getCurrentDate());
					userBook.setBookId(book.getId());
					userBook.setUserId(user.getId());
					userBook.setTypeId(book.getType());
					userBook.setNumber(number);
					userBook.setStatus((byte)0);
					userBookMapper.insertSelective(userBook);
					mv.setFlag(true);
					mv.setMessage("添加成功!");
				}catch(Exception e){
					mv.setFlag(false);
					mv.setMessage("添加失败!");
				}
				
			}
		}
		return mv;
	}
	
	/**
	 * 向购物车中添加商品
	 * @param request
	 * @param id 书籍id
	 * @return
	 */
	@RequestMapping("/currentBuy")
	@ResponseBody
	public MessageVO currentBuy(HttpServletRequest request,String id,int number){
		MessageVO mv=new MessageVO();
		HttpSession session=request.getSession();
		if(session.getAttribute(Consts.USER_SESSION)==null){
			mv.setFlag(false);
			mv.setMessage("请先登录在购买商品");
		}else if(id==null){
			mv.setFlag(false);
			mv.setMessage("书籍信息不正确!");
		}else{
			User user=(User)session.getAttribute(Consts.USER_SESSION);
			Book book=bookMapper.selectByPrimaryKey(id);
			if(book==null){
				mv.setFlag(false);
				mv.setMessage("无法查询到该书籍!");
			}else{
				try{
					UserBook userBook=new UserBook();
					userBook.setId(StringUtils.getUUID32());
					userBook.setCreateTime(DateUtils.getCurrentDate());
					userBook.setUpdateTime(DateUtils.getCurrentDate());
					userBook.setBookId(book.getId());
					userBook.setUserId(user.getId());
					userBook.setTypeId(book.getType());
					userBook.setNumber(number);
					userBook.setStatus((byte)1);
					userBookMapper.insertSelective(userBook);
					mv.setFlag(true);
					mv.setMessage("您已经购买成功，我们将会在最短时间内和你取得联系!");
				}catch(Exception e){
					mv.setFlag(false);
					mv.setMessage("购买失败!");
				}
				
			}
		}
		return mv;
	}
	
	/**
	 * 删除还没有付款的订单
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("/removeUserBook")
	public String removeUserBook(HttpServletRequest request,String id){
		HttpSession session=request.getSession();
		if(session.getAttribute(Consts.USER_SESSION)==null){
			return "fornt/login";
		}
		if(!StringUtils.isEmpty(id)){
			userBookMapper.deleteByPrimaryKey(id);
		}
		
		//跳转到用户订单页面
		return "redirect:/buyBook/getAllOrder";
	}
	/**
	 * 删除购物车的商品
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("/removeCar")
	public String removeCar(HttpServletRequest request,String id){
		HttpSession session=request.getSession();
		if(session.getAttribute(Consts.USER_SESSION)==null){
			return "fornt/login";
		}
		userBookMapper.deleteByPrimaryKey(id);
		return "redirect:/buyBook/goShopingCar";
	}
	
	/**
	 * 将购物车中的商品状态变成购买状态
	 * @param request
	 * @param ids
	 * @return
	 */
	@RequestMapping("/buyCar")
	public String buyCar(HttpServletRequest request,String ids){
		HttpSession session=request.getSession();
		if(session.getAttribute(Consts.USER_SESSION)==null){
			return "fornt/login";
		}
		if(!StringUtils.isEmpty(ids)){
			String[] id=ids.split(",");
			for (String string : id) {
				UserBook books=new UserBook();
				books.setId(string);
				books.setStatus((byte)1);
				books.setCreateTime(DateUtils.getCurrentDate());
				userBookMapper.updateByPrimaryKeySelective(books);
			}
		}
		return "redirect:/buyBook/goShopingCar";
	}
	
	/**
	 * 获取购物车里的商品
	 * @param request
	 * @return
	 */
	@RequestMapping("/goShopingCar")
	public String goShopingCar(HttpServletRequest request){
		HttpSession session=request.getSession();
		if(session.getAttribute(Consts.USER_SESSION)==null){
			return "fornt/login";
		}
		User user=(User) session.getAttribute(Consts.USER_SESSION);
		UserBook book=new UserBook();
		book.setStatus((byte)0);
		book.setUserId(user.getId());
		List<UserBook> list=userBookMapper.selectBySelective(book, new RowBounds());
		List<TBook>bl=new ArrayList<TBook>();
		//连表查询
		if(list!=null&&list.size()>0){
			for(UserBook ub : list){
				Book bk=bookMapper.selectByPrimaryKey(ub.getBookId());
				Type tp=typeMapper.selectByPrimaryKey(ub.getTypeId());
				TBook tt=new TBook(bk, tp,ub);
				bl.add(tt);
			}
		}
		session.setAttribute("data", bl);
		return "fornt/shopcar";
	}
	
	
	/**
	 * 获取所有订单信息
	 * @return
	 */
	@RequestMapping("/getAllOrder")
	public String getAllOrder(HttpServletRequest request){
		HttpSession session=request.getSession();
		if(session.getAttribute(Consts.USER_SESSION)==null){
			return "fornt/login";
		}
		User user=(User) session.getAttribute(Consts.USER_SESSION);
		UserBook book=new UserBook();
		book.setStatus((byte)0);
		book.setUserId(user.getId());
		List<UserBook> list=userBookMapper.selectByStatus(book,(byte)1, new RowBounds());
		List<TBook>bl=new ArrayList<TBook>();
		//连表查询
		if(list!=null&&list.size()>0){
			for(UserBook ub : list){
				Book bk=bookMapper.selectByPrimaryKey(ub.getBookId());
				Type tp=typeMapper.selectByPrimaryKey(ub.getTypeId());
				TBook tt=new TBook(bk, tp,ub);
				bl.add(tt);
			}
		}
		session.setAttribute("data", bl);
		return "fornt/allorder";
	}
	
	/**
	 * 确认收货
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("/goodsOk")
	public String goodsOk(HttpServletRequest request,String id){
		HttpSession session=request.getSession();
		if(session.getAttribute(Consts.USER_SESSION)==null){
			return "fornt/login";
		}
		UserBook book=new UserBook();
		book.setId(id);
		UserBook Temp=userBookMapper.selectByPrimaryKey(id);
		if(Temp.getStatus()==3){
			book.setStatus((byte)4);
			userBookMapper.updateByPrimaryKeySelective(book);
		}
		//跳转到用户订单页面
		return "redirect:/buyBook/getAllOrder";
	}
}
