package com.cjeg.mode;

/**
 * 
 * @author 曹倩倩
 * 
 *         创建时间:2017年3月4日 下午10:27:15
 * 
 */
public class BookUserType {
	private Book book;
	private User user;
	private Type type;
	private UserBook userBook;

	public BookUserType(Book book, User user, Type type, UserBook userBook) {
		super();
		this.book = book;
		this.user = user;
		this.type = type;
		this.userBook = userBook;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public UserBook getUserBook() {
		return userBook;
	}

	public void setUserBook(UserBook userBook) {
		this.userBook = userBook;
	}

	@Override
	public String toString() {
		return "BookUserType [book=" + book + ", user=" + user + ", type="
				+ type + ", userBook=" + userBook + "]";
	}

}
