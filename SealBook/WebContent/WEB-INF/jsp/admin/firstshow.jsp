<!-- 首页标题通告，图片信息展示 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>书籍管理</title>
<jsp:include page="_mate.jsp"></jsp:include>
<script type="text/javascript" src="${ctx}/js/jquery.form.js"></script>
<style type="text/css">

.width-100{
	width:100px;
}
.width-150{
	width:150px;
}
.width-200{
	width:200px;
}
.padding-20{
	padding:20px;
}
.inline{
	display:inline-block;
}
.padding-10{
	padding:10px;
}
.padding-5{
	padding:5px;
}
.margin-10{
	margin:10px;
}
.margin-5{
	margin:5px;
}
</style>

<script type="text/javascript">
//加载初始化信息
$(function(){
	var notice=loadNotice();
	$("#notice").val(notice);
	var images=loadImage();
	if(images!=""&&images.flag){
		var obj=images.data[0];
		$("#shows").attr("src",obj.src);
		$("#name").val(obj.name);
		$("#descripts").val(obj.descripts);
		$("#link").val(obj.link);
	}
});
//加载通告信息
function loadNotice(){
	var result="";
	$.ajax({
		async:false,/*同步加载*/
		url:'${ctx}/admin/first/notice',
		success:function(data){
			result=data.obj;
		},
		error:function(){
			toast("加载通知信息失败");
		}
	});
	return result;
}

//加载图片信息
function loadImage(){
	var result="";
	$.ajax({
		async:false,/*同步加载*/
		url:'${ctx}/admin/first/getImage',
		success:function(data){
			result=data;
		},
		error:function(){
			toast("加载通知信息失败");
		}
	});
	return result;
}
//点击选择图片时
function selectPic(){
	$("#fileHide").trigger("click");
}

//保存图片
function savePic(){
	var src=$("#fileHide").val();
	if(src==""){
		toast("请选择要上传的图片");
		return false;
	}
	
	$("#fm").ajaxSubmit({
		success:function(data)
		{
			if(data.flag){
				
				$("#fileHide").val("");
				$("#shows")[0].src="${ctx}/"+data.src;
				toast("上传成功");
			}else{
				toast("上传失败");
			}
		}
	});
}

//保存公告
function saveNotice(){
	var notice=$("#notice").val();
	if(notice==""){
		alertMsg("请输入公告内容");
		return false;
	}
	
	$.ajax({
		url:'${ctx}/admin/first/saveNotice',
		data:{notice:notice},
		type:'post',
		success:function(data){
			if(data.flag){
				alertMsg("保存成功");
			}else{
				alertMsg("保存失败");
			}
		},
		error:function(){
			toast("连接错误，保存信息失败");
		}
	});
}
//保存书籍信息
function saveBook(){
	var json={};
	var image=$("#shows").attr("src");
	if(image==""){
		alertMsg("请选择图片");
		return false;
	}
	json.src=image;
	var name=$("#name").val();
	if(name==""){
		alertMsg("请输入书籍名称");
		return false;
	}
	json.name=name;
	
	var descripts=$("#descripts").val();
	if(descripts==""){
		alertMsg("请输入描述信息");
		return false;
	}
	json.descripts=descripts;
	
	var link=$("#link").val();
	if(link==""){
		alertMsg("请输入链接");
		return false;
	}
	json.link=link;
	
	$.ajax({
		url:'${ctx}/admin/first/setImages',
		data:json,
		type:'post',
		success:function(data){
			if(data.flag){
				alertMsg("保存成功");
			}else{
				alertMsg("保存失败");
			}
		},
		error:function(){
			toast("连接错误，保存信息失败");
		}
	});
}
</script>
</head>
<body>	
		
		<div style="width:800px;padding:0 auto;margin:0 auto;">
			<div style="width:800px;border:1px solid #ccc;padding:10px;">
				<label>公告显示:</label><br>
				<textarea id="notice" style="width:300px;height:100px;max-height:100px;max-width:300px;" ></textarea>
				<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="saveNotice()">保存</a>
			</div>
			<div style="width:800px;border:1px solid #ccc;padding:10px;overflow:auto;">
				<div style="width:300px;float:left;">
					<label  class="padding-5 inline">展示大图:</label>
					<a href="#" class="easyui-linkbutton" iconCls="icon-large-picture" onclick="selectPic()">选择图片</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="savePic()">上传</a><br>
					<img src="${ctx}/img/image.png" id="shows" style="width:300px;height:300px;" />
				</div>
				
				<div style="float:left;padding:20px;width:400px;">
					<label class="padding-5 width-100 inline">书籍名称:</label><input id="name" class="margin-5 width-200" type="text"><br>
					<label class="padding-5 width-100 inline" >说明:</label><input id="descripts" class="margin-5 width-200" type="text"><br>
					<label class="padding-5 width-100 inline" >详情链接:</label><input id="link" class="margin-5 width-200" type="text"><br>
					<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="saveBook()">保存</a>
				</div>
				
			</div>
		</div>
		
		<form id="fm" style="display:none;" action="${ctx}/file/upload" method="post" enctype="multipart/form-data">
			<input type="file" id="fileHide" name="abc" onchange="preImg(this.id,'shows');" >
		</form>
		
</body>
</html>