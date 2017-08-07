package com.cjeg.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.cjeg.mode.Book;

/**
 * 书籍的操作的servicee
 * @author 曹倩倩
 *
 * 创建时间:2017年2月19日 上午10:37:12
 *
 */
public interface BookService extends BaseService<Book> {
	
	/**
	 * 查询符合条件的数据
	 * @param book
	 * @param rowBounds
	 * @return
	 */
	List<Book> listBooks(Book book,RowBounds rowBounds);
}
