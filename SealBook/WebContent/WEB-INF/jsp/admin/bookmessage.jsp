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
<script type="text/javascript">
var typeObj="";
$(function(){
	//加载书籍类型
	typeObj=loadType();
	var $type=$("#type");
	var option="<option value='-1'>--请选择类型--</option>";
	for(var i=0;i<typeObj.length;i++){
		var item=typeObj[i];
		option+="<option value='"+item.id+"'>"+item.name+"</option>";
	}
	$type.append(option);
});
function converType(id){
	for(var i=0;i<typeObj.length;i++){
		var item=typeObj[i];
		if(id==item.id){
			return item.name;
		}
	}
}
function bookStatus(statu){
	if(statu==1){
		return "<span style='color:#00f;'>上架</span>";
	}else{
		return "<span color='color:#f00;'>下架</span>";
	}
}
//加载后台书籍类型
function loadType(){
	var object="";
	$.ajax({
		async:false,/*同步加载*/
		url:'${ctx}/admin/type/allTypes',
		type:'post',
		success:function(result){
			if(result.flag){
				object=result.data;
			}
		}
	});
	return object;
}
//价格
function prices(price){
	return "￥"+price;
}
//添加一列
function add(){
	submitUrl="${ctx}/admin/book/add";
	$("#ids").val("");
	$("#type").val("-1");
	$("#nameAdd").val("");
	$("#author").val("");
	$('#publishData').datebox('setValue',"");
	$("#publishingCompanyAdd").val("");
	$("#primeCost").val("");
	$("#currentPrice").val("");
	$("#tempImage").val("");
	$("#shows").attr("src","");
	$("#descripts").val("");
	$('#winAdd').window('open');
}
//删除列
function remove(){
	var row = $('#tt').datagrid('getSelected');
	if(!row){
		alertMsg("请选择要删除的行");
		return false;
	}
	var id=row.id;
	$.ajax({
		url:'${ctx}/admin/book/remove?id='+id,
		type:'get',
		success:function(result){
			if(result.flag){
				$('#tt').datagrid('reload');  
				alertMsg("删除成功");
			}else{
				alertMsg("删除失败");
			}
		}
	});
}

var submitUrl="";
//修改列
function update(){
	debugger;
	submitUrl="${ctx}/admin/book/update";
	var row = $('#tt').datagrid('getSelected');
	if(!row){
		alertMsg("请选择要修改的行");
		return false;
	}
	var id=row.id;
	$("#ids").val(id);
	$("#type").val(row.type);
	$("#nameAdd").val(row.name);
	$("#author").val(row.author);
	$('#publishData').datebox('setValue',dateFormat(row.publishData));
	$("#publishingCompanyAdd").val(row.publishingCompany);
	$("#primeCost").val(row.primeCost);
	$("#currentPrice").val(row.currentPrice);
	$("#tempImage").val(row.image);
	$("#shows").attr("src",row.image);
	$("#descripts").val(row.descripts);
	$('#winAdd').window('open');
	
}

//查询
function searchs(){
	
	var name=$("#name").val();
	
	var publishingCompany=$("#publishingCompany").val();
	$('#tt').datagrid('load',{
		name: name,
		publishingCompany: publishingCompany
	});
}

function selectFiles(){
	$("#tempImage").val("");
	$("#fileHide").trigger("click");
}

function uploads(){
	if($("#fileHide").val()==""){
		alertMsg("请选择文件");
		return false;
	}
	$("#fm").ajaxSubmit({
		success:function(data)
		{
			if(data.flag){
				
				$("#fileHide").val("");
				$("#shows")[0].src="${ctx}/"+data.src;
				$("#tempImage").val("${ctx}/"+data.src);
				toast("上传成功");
			}else{
				toast("上传失败");
			}
		}
	});
}

function submitss(){
	var jsonData={};
	
	//添加id便于修改时提交
	var id=$("#ids").val();
	jsonData.id=id;
	debugger;
	var name=$("#nameAdd").val();
	if(name==""){
		alertMsg("请输入书名");
		return false;
	}
	jsonData.name=name;
	var author=$("#author").val();
	if(author==""){
		alertMsg("请输入作者");
		return false;
	}
	jsonData.author=author;
	
	var publishData=$('#publishData').datebox('getValue');
	if(publishData==""){
		alertMsg("请输入出版日期");
		return false;
	}
	jsonData.publishData=publishData;
	
	var type=$("#type").val();
	if(type=="-1"){
		alertMsg("请选择书籍类型");
		return false;
	}
	jsonData.type=type;
	
	
	var publishingCompany=$("#publishingCompanyAdd").val();
	if(publishingCompany==""){
		alertMsg("请输入出版社");
		return false;
	}
	jsonData.publishingCompany=publishingCompany;
	
	var primeCost=$("#primeCost").val();
	if(primeCost==""){
		alertMsg("请输入原价");
		return false;
	}
	jsonData.primeCost=primeCost;
	
	var currentPrice=$("#currentPrice").val();
	if(currentPrice==""){
		alertMsg("请输入现价");
		return false;
	}
	jsonData.currentPrice=currentPrice;
	
	var image=$("#tempImage").val();
	//图片进行校验
	if(image==""){
		alertMsg("请选择要上传的图片");
		return false;
	}
	jsonData.image=image;
	
	var descripts=$("#descripts").val();
	if(descripts==""){
		alertMsg("请选择要上传的图片");
		return false;
	}
	jsonData.descripts=descripts;
	
	$.ajax({
		url:submitUrl,
		data:jsonData,
		type:'post',
		success:function(result){
			if(!result.flag){
				toast(result.message);
			}else{
				$('#tt').datagrid('reload');  
				toast(result.message);
			}
		},
		error:function(){
			toast("请查看你的数据格式是否正确");
		}
	});
}

</script>
</head>
<body>
	<div class="table">
		<table id="tt" class="easyui-datagrid" style="width:100%;"
			url="${ctx}/admin/book/list"
			title="书籍信息" iconCls="icon-save"
			toolbar="#tb"
			singleSelect="true"
			rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="id" hidden="true" width="150" align="center">id</th>
					<th field="name" width="130" align="center">书名</th>
					<th field="author" width="100" align="center">作者</th>
					<th field="type" width="100" align="center" formatter="converType" >书籍分类</th>
					<th field="publishingCompany" width="150" align="center">出版社</th>
					<th field="status" width="50" align="center" formatter="bookStatus">状态</th>
					<th field="primeCost" width="70" align="center" formatter="prices">原价</th>
					<th field="currentPrice" width="70" align="center" formatter="prices">现价</th>
					<th field="publishData" width="100" align="center" formatter="dateFormat">出版日期时间</th>
					<th field="createDate" width="150" align="center" formatter="dateTimeFormat">创建日期</th>
					<th field="updateDate" width="150" align="center" formatter="dateTimeFormat">修改日期</th>
				</tr>
			</thead>
		</table>
		
		<div id="tb">
			<div>
			<span>书名: </span><input type="text" name="name" id="name">
			<span>出版社: </span><input type="text" name="publishingCompany" id="publishingCompany" >
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchs()" >查询</a>
			</div>
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="update()">修改</a>
		</div>
	</div>
	
	<!-- 添加数据窗口 -->

	
	<div id="winAdd" closed="true" class="easyui-dialog" style="padding:20px;width:700px;height:500px;"
			title="My Dialog" iconCls="icon-ok"
			buttons="#dlg-buttons" >
		<form id="fmtt" action="${ctx}/admin/book/add" method="post">
			<input type="text" value="-1" style="display:none;" id="ids" name="id"> 
			<div class="padding5">
				<label>书名: </label><input id="nameAdd" name="name" type="text" class="easyui-validatebox">
				<label>作者: </label><input id="author" name="author" type="text" class="easyui-validatebox">
			</div>
			<div class="padding5">
				<label>出版日期: <label><input id="publishData"  name="publishData" class="easyui-datebox">
				<label>出版社: </label><input id="publishingCompanyAdd" name="publishingCompany" type="text" class="easyui-validatebox">
			</div>
			
			<div class="padding5">
				<label>原价: </label><input id="primeCost" name="primeCost" class="easyui-validatebox" type="text">
				<label>现价: </label><input id="currentPrice" name="currentPrice" type="text" class="easyui-validatebox">
			</div>
			
			<div class="padding5">
				<label>书籍类型: </label>
				<select id="type" style="width:150px"></select>
			</div>
			<div>
				<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="selectFiles()">请选择文件</a> 
				<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="uploads()">上传</a> 
			</div>
			<div class="showImg" style="padding:10px;">
				<div style="float:left;width:250px;height:200px;">
					<input type="text" id="tempImage" name="image" style="display:none"> 
					<img id="shows" style="width:200px;height:200px;" src="">
				</div>
				<div style="float:left;">
					<div>请输入对本书的描述</div>
					<textarea  class="easyui-validatebox"id="descripts" name="descripts" style="width:400px;height:200px;max-width:350px;max-height:200px;" rows="5" cols="60"></textarea>
				</div>	
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitss()">提交</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#winAdd').dialog('close')">取消</a>
	</div>
	
	<form id="fm" style="display:none;" action="${ctx}/file/upload" method="post" enctype="multipart/form-data">
		<input type="file" id="fileHide" name="abc" onchange="preImg(this.id,'shows');" >
	</form>
	
</body>
</html>