package com.cjeg.controll.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cjeg.Util.StringUtils;
import com.cjeg.consts.Consts;
import com.cjeg.mapper.DicMapper;
import com.cjeg.message.MessageVO;
import com.cjeg.mode.Dic;

/**
 * 
 * @author 曹倩倩
 * 
 *         创建时间:2017年2月24日 下午7:57:18
 * 
 */

@Controller
@RequestMapping("/admin/first")
public class FirstShow {
	// 注入字典类
	@Autowired
	private DicMapper dicMapper;

	@RequestMapping("/index")
	public String index() {
		return "admin/firstshow";
	}

	//保存通知信息
	@RequestMapping("/saveNotice")
	@ResponseBody
	public MessageVO setNotice(String notice) {
		MessageVO mv = new MessageVO();
		Dic dic = new Dic();
		try {
			isUpdate(Consts.NOTICE_MESSAGE,notice);
			mv.setFlag(true);
			mv.setMessage("提交成功");
		} catch (Exception e) {
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		return mv;
	}

	// 获取公告信息
	@RequestMapping("/notice")
	@ResponseBody
	public MessageVO getNotice() {
		MessageVO mv = new MessageVO();
		String notice=getValues(Consts.NOTICE_MESSAGE);
		mv.setFlag(true);
		mv.setObj(notice);
		return mv;
	}
	
	/**
	 * 设置图片信息
	 * @return
	 */
	@RequestMapping("/setImages")
	@ResponseBody
	public MessageVO setImages(String src,String name,String descripts,String link){
		MessageVO mv = new MessageVO();
		try{
			
			isUpdate(Consts.FIRST_IMG,src);
			isUpdate(Consts.FIRST_BOOK_DESCRIPTS,descripts);
			isUpdate(Consts.FIRST_BOOK_LINK,link);
			isUpdate(Consts.FIRST_BOOK_NAME,name);
			mv.setFlag(true);
			mv.setMessage("更新成功");
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		return mv;
	}
	
	/**
	 * 查询图片相关的信息
	 * @return
	 */
	@RequestMapping("/getImage")
	@ResponseBody
	public MessageVO getImages(){
		MessageVO mv = new MessageVO();
		Map<String,String>result=new HashMap<String,String>();
		try{
			result.put("name", getValues(Consts.FIRST_BOOK_NAME));
			result.put("src", getValues(Consts.FIRST_IMG));
			result.put("descripts", getValues(Consts.FIRST_BOOK_DESCRIPTS));
			result.put("link", getValues(Consts.FIRST_BOOK_LINK));
			mv.setFlag(true);
			mv.setMessage("查询成功");
			List<Map<String,String>> list=new ArrayList<Map<String,String>>();
			list.add(result);
			mv.setData(list);
			mv.setFlag(true);
		}catch(Exception e){
			mv.setFlag(false);
			mv.setMessage(e.getMessage());
		}
		
		return mv;
	}
	/**
	 * 更加名字设置或者更新某个值
	 * @param name 要设置字段的名字
	 * @param value 要设置的值
	 * @return 如果是更新返回true 
	 */
	private boolean isUpdate(String name,String value){
		List<Dic> list = dicMapper.selectByName(name);
		Dic dic=new Dic();
		if(list!=null&&list.size()>0){
			dic.setId(list.get(0).getId());
			dic.setValue(value);
			dicMapper.updateByPrimaryKeySelective(dic);
			return true;
		}else{
			dic.setId(StringUtils.getUUID32());
			dic.setName(name);
			dic.setValue(value);
			dic.setDescripts(Consts.getDescripts(name));
			dicMapper.insertSelective(dic);
		}
		return false;
	}
	/**
	 * 根据name属性获取值,当为空时返回 ""
	 * @param name
	 * @return
	 */
	private String getValues(String name){
		List<Dic> list = dicMapper.selectByName(name);
		if (list != null && list.size() > 0) {
			String value = list.get(0).getValue();
			return value;
		}
		return "";
	}
}
