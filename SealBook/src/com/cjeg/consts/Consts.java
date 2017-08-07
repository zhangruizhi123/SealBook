package com.cjeg.consts;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

/**
 * 常量类
 * @author 曹倩倩
 *
 * 创建时间:2017年2月24日 下午9:36:14
 *
 */
public class Consts {
	
	//用于生产图片二维码
	public static final String RANDOM_CODE="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	//
	public static final String IMAGE_SESSION ="IMAGE_SESSION";
	//公告提示信息
	public static final String NOTICE_MESSAGE="NOTICE_MESSAGE";
	//首页大图片
	public static final String FIRST_IMG="FIRST_IMG";
	//大图对应书籍名称
	public static final String FIRST_BOOK_NAME="FIRST_BOOK_NAME";
	//大图对应书籍描述
	public static final String FIRST_BOOK_DESCRIPTS="FIRST_BOOK_DESCRIPTS";
	//大图对应书籍链接
	public static final String FIRST_BOOK_LINK="FIRST_BOOK_LINK";
	
	public static final String USER_SESSION="user_session";
	public static final String ADMIN_SESSION="admin_session";
	
	private static Map<String,String>map=new HashMap<String,String>();
	static{
		map.put(NOTICE_MESSAGE, "公告提示信息");
		map.put(FIRST_IMG, "首页大图片");
		map.put(FIRST_BOOK_NAME, "大图对应书籍名称");
		map.put(FIRST_BOOK_DESCRIPTS, "大图对应书籍描述");
		map.put(FIRST_BOOK_LINK, "大图对应书籍链接");
	}
	
	//获取键对应的说明信息
	public static String getDescripts(String key){
		return map.get(key);
	}
}
