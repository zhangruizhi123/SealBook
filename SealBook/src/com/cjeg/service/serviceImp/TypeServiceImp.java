package com.cjeg.service.serviceImp;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cjeg.Util.DateUtils;
import com.cjeg.mapper.TypeMapper;
import com.cjeg.message.MessageVO;
import com.cjeg.mode.Type;
import com.cjeg.service.TypeService;

/**
 * 
 * @author 曹倩倩
 *
 * 创建时间:2017年2月22日 下午10:38:02
 *
 */
@Service("typeService")
public class TypeServiceImp implements TypeService {

	@Autowired
	private TypeMapper typeMapper;
	
	@Override
	public MessageVO add(Type type) {
		MessageVO mv=new MessageVO();
		type.setCreateTime(DateUtils.getCurrentDate());
		type.setUpdateTime(DateUtils.getCurrentDate());
		typeMapper.insert(type);
		mv.setFlag(true);
		mv.setMessage("添加成功");
		return mv;
	}

	@Override
	public MessageVO remove(Type type) {
		MessageVO mv=new MessageVO();
		typeMapper.deleteByPrimaryKey(type.getId());
		mv.setFlag(true);
		mv.setMessage("删除成功");
		return mv;
	}

	@Override
	public MessageVO update(Type type) {
		MessageVO mv=new MessageVO();
		type.setUpdateTime(DateUtils.getCurrentDate());
		typeMapper.updateByPrimaryKeySelective(type);
		mv.setFlag(true);
		mv.setMessage("修改成功");
		return mv;
	}

	@Override
	public List<Type> list(Type type, RowBounds rowBounds) {
		return typeMapper.selectBySelective(type, rowBounds);
	}

	@Override
	public long countSize(Type type) {
		return typeMapper.countBySelective(type);
	}

}
