package com.cjeg.mode;

/**
 * 书籍和类型
 * @author 曹倩倩
 *
 * 创建时间:2017年3月4日 下午3:33:51
 *
 */
public class TBook {
	private Book book;
	private Type type;
	
	private UserBook userBook;
	
	
	
	public TBook() {
		super();
	}



	

	public TBook(Book book, Type type, UserBook userBook) {
		super();
		this.book = book;
		this.type = type;
		this.userBook = userBook;
	}





	public UserBook getUserBook() {
		return userBook;
	}





	public void setUserBook(UserBook userBook) {
		this.userBook = userBook;
	}





	public Book getBook() {
		return book;
	}


	public void setBook(Book book) {
		this.book = book;
	}


	public Type getType() {
		return type;
	}


	public void setType(Type type) {
		this.type = type;
	}


	@Override
	public String toString() {
		return "TBook [book=" + book + ", type=" + type + ", userBook="
				+ userBook + "]";
	}
	
	
}
