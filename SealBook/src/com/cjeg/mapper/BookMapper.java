package com.cjeg.mapper;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.cjeg.mode.Book;

public interface BookMapper {
    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table book
	 * @mbg.generated
	 */
	int deleteByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table book
	 * @mbg.generated
	 */
	int insert(Book record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table book
	 * @mbg.generated
	 */
	int insertSelective(Book record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table book
	 * @mbg.generated
	 */
	Book selectByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table book
	 * @mbg.generated
	 */
	int updateByPrimaryKeySelective(Book record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table book
	 * @mbg.generated
	 */
	int updateByPrimaryKey(Book record);

	/**
     * 根据给定的条件查询所有列
     * @param record
     * @return
     */
    List<Book> selectBySelective(Book record,RowBounds rowBounds);
    
    /***
     * 统计数量
     * @param record
     * @return
     */
    int countBySelective(Book record);
}