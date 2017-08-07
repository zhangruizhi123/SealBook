package com.cjeg.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.cjeg.message.MessageVO;
import com.cjeg.mode.Book;
import com.cjeg.mode.Type;

/**
 * 
 * @author 曹倩倩
 *
 * 创建时间:2017年2月19日 上午10:32:22
 *
 */
public interface BaseService <T> {
	/*
	 * 添加
	 */
	MessageVO add(T t);
	
	/**
	 * 删除
	 * @param t
	 * @return
	 */
	MessageVO remove(T t);
	
	/**
	 * 更新
	 * @param t
	 * @return
	 */
	MessageVO update(T t);
	
	/**
	 * 查询对象
	 * @param t
	 * @param rowBounds
	 * @return
	 */
	List<T> list(T t,RowBounds rowBounds);
	
	/**
	 * 统计对象
	 * @param t
	 * @return
	 */
	long countSize(T t);
}
