package com.cjeg.mode;

import java.util.List;

/**
 * 
 * @author 曹倩倩
 *
 * 创建时间:2017年2月26日 上午10:39:27
 *
 */
public class TypeBooks {
	private Type type;
	private List<Book> books;
	public Type getType() {
		return type;
	}
	public void setType(Type type) {
		this.type = type;
	}
	public List<Book> getBooks() {
		return books;
	}
	public void setBooks(List<Book> books) {
		this.books = books;
	}
	@Override
	public String toString() {
		return "TypeBooks [type=" + type + ", books=" + books + "]";
	}
	
	
}
