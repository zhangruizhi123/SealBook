package com.cjeg.service.serviceImp;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cjeg.Util.DateUtils;
import com.cjeg.mapper.BookMapper;
import com.cjeg.message.MessageVO;
import com.cjeg.mode.Book;
import com.cjeg.service.BookService;

/**
 * 
 * @author 曹倩倩
 *
 * 创建时间:2017年2月19日 上午10:38:29
 *
 */
@Service("bookService")
public class BookServiceImp implements BookService {

	@Autowired
	private BookMapper bookMapper;
	@Override
	public MessageVO add(Book book) {
		MessageVO vo=new MessageVO();
		book.setStatus((byte)(1));
		book.setCreateDate(DateUtils.getCurrentDate());
		book.setUpdateDate(DateUtils.getCurrentDate());
		bookMapper.insert(book);
		vo.setFlag(true);
		vo.setMessage("添加书籍成功");
		return vo;
	}

	@Override
	public MessageVO remove(Book book) {
		MessageVO vo=new MessageVO();
		bookMapper.deleteByPrimaryKey(book.getId());
		vo.setFlag(true);
		vo.setMessage("删除成功");
		return vo;
	}

	@Override
	public MessageVO update(Book book) {
		MessageVO vo=new MessageVO();
		book.setUpdateDate(DateUtils.getCurrentDate());
		bookMapper.updateByPrimaryKeySelective(book);
		vo.setFlag(true);
		vo.setMessage("修改成功");
		return vo;
	}

	@Override
	public List<Book> listBooks(Book book, RowBounds rowBounds) {
		List<Book> list=bookMapper.selectBySelective(book, rowBounds);
		return list;
	}

	@Override
	public long countSize(Book book) {
		return bookMapper.countBySelective(book);
	}

	@Override
	public List<Book> list(Book book, RowBounds rowBounds) {
		List<Book> list=bookMapper.selectBySelective(book, rowBounds);
		return list;
	}

}
