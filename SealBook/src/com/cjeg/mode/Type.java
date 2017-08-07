package com.cjeg.mode;

import java.util.Date;

public class Type {
    /**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column type_t.id
	 * @mbg.generated
	 */
	private String id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column type_t.name
	 * @mbg.generated
	 */
	private String name;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column type_t.create_time
	 * @mbg.generated
	 */
	private Date createTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column type_t.update_time
	 * @mbg.generated
	 */
	private Date updateTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column type_t.descripts
	 * @mbg.generated
	 */
	private String descripts;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column type_t.sort
	 * @mbg.generated
	 */
	private Byte sort;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column type_t.shows
	 * @mbg.generated
	 */
	private Boolean shows;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column type_t.id
	 * @return  the value of type_t.id
	 * @mbg.generated
	 */
	public String getId() {
		return id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column type_t.id
	 * @param id  the value for type_t.id
	 * @mbg.generated
	 */
	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column type_t.name
	 * @return  the value of type_t.name
	 * @mbg.generated
	 */
	public String getName() {
		return name;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column type_t.name
	 * @param name  the value for type_t.name
	 * @mbg.generated
	 */
	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column type_t.create_time
	 * @return  the value of type_t.create_time
	 * @mbg.generated
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column type_t.create_time
	 * @param createTime  the value for type_t.create_time
	 * @mbg.generated
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column type_t.update_time
	 * @return  the value of type_t.update_time
	 * @mbg.generated
	 */
	public Date getUpdateTime() {
		return updateTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column type_t.update_time
	 * @param updateTime  the value for type_t.update_time
	 * @mbg.generated
	 */
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column type_t.descripts
	 * @return  the value of type_t.descripts
	 * @mbg.generated
	 */
	public String getDescripts() {
		return descripts;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column type_t.descripts
	 * @param descripts  the value for type_t.descripts
	 * @mbg.generated
	 */
	public void setDescripts(String descripts) {
		this.descripts = descripts == null ? null : descripts.trim();
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column type_t.sort
	 * @return  the value of type_t.sort
	 * @mbg.generated
	 */
	public Byte getSort() {
		return sort;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column type_t.sort
	 * @param sort  the value for type_t.sort
	 * @mbg.generated
	 */
	public void setSort(Byte sort) {
		this.sort = sort;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column type_t.shows
	 * @return  the value of type_t.shows
	 * @mbg.generated
	 */
	public Boolean getShows() {
		return shows;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column type_t.shows
	 * @param shows  the value for type_t.shows
	 * @mbg.generated
	 */
	public void setShows(Boolean shows) {
		this.shows = shows;
	}

	@Override
	public String toString() {
		return "Type [id=" + id + ", name=" + name + ", createTime="
				+ createTime + ", updateTime=" + updateTime + ", descripts="
				+ descripts + ", sort=" + sort + ", shows=" + shows + "]";
	}

	
}