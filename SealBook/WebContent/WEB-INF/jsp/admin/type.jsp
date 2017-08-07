<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>书籍类型管理</title>
<jsp:include page="_mate.jsp"></jsp:include>
<script type="text/javascript" src="${ctx}/js/jquery.form.js"></script>
<script type="text/javascript">

function isShows(show){
	if(show){
		return "<font color='#00f'>显示</font>";
	}
	else{
		return "<font color='#f00'>隐藏</font>";
	}
}
//查询
function searchs(){
	
	var name=$("#name").val();
	
	$('#tt').datagrid('load',{name: name});
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
		url:'${ctx}/admin/type/remove?id='+id,
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
var id="";
//修改列
function update(){
	submitUrl="${ctx}/admin/type/update";
	var row = $('#tt').datagrid('getSelected');
	if(!row){
		alertMsg("请选择要修改的行");
		return false;
	}
	if(row.shows){
		$("#shows").attr("checked","checked");
	}else{
		$("#shows").removeAttr("checked");
	}
	id=row.id;
	$("#sort").val(row.sort);
	$("#nameAdd").val(row.name);
	$("#descripts").val(row.descripts);
	$('#winAdd').window('open');
}
//添加数据
function add(){
	$("#shows").attr("checked","checked");
	$("#nameAdd").val("");
	$("#sort").val("");
	$("#descripts").val("");
	submitUrl="${ctx}/admin/type/add";
	$('#winAdd').window('open');
}
//提交表单
function submits(){
	var jsonData={};
	jsonData.id=id;
	var name=$("#nameAdd").val();
	if(name==""){
		alertMsg("请输入类型名");
		return false;
	}
	jsonData.name=name;
	
	var sort=$("#sort").val();
	jsonData.sort=sort;
	var shows=$("#shows").is(":checked");
	jsonData.shows=shows;
	var descripts=$("#descripts").val();
	if(descripts==""){
		alertMsg("请输入描述");
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
			url="${ctx}/admin/type/list"
			title="书籍类型" iconCls="icon-save"
			toolbar="#tb"
			singleSelect="true"
			rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="id" hidden="true" width="150" align="center">id</th>
					<th field="name" width="250" align="center">类型名</th>
					<th field="descripts" width="300" align="center">描述</th>
					<th field="sort" width="50" align="center">排序</th>
					<th field="shows" width="50" align="center" formatter="isShows">首页是否显示</th>
					<th field="createTime" width="150" align="center" formatter="dateTimeFormat">创建日期</th>
					<th field="updateTime" width="150" align="center" formatter="dateTimeFormat">修改日期</th>
				</tr>
			</thead>
		</table>
		
		<div id="tb">
			<div>
			<span>类型名称: </span><input type="text" name="name" id="name">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchs()" >查询</a>
			</div>
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="update()">修改</a>
		</div>
	</div>
	
	
	<!-- 添加数据窗口 -->

	
	<div id="winAdd" closed="true" class="easyui-dialog" style="padding:20px;width:400px;height:300px;"
			title="My Dialog" iconCls="icon-ok"
			buttons="#dlg-buttons" >
		<form id="fmtt" action="${ctx}/book/add" method="post">
			<div class="padding5">
				<label>类型名: </label><input id="nameAdd" name="name" type="text" style="width:180px;" class="easyui-validatebox">
			</div>
			<div class="padding5">
				<label>是否在首页显示:</label><input id="shows" type="checkbox" checked>
				<label style="margin-left:30px;">排序:</label><input id="sort" type="text" style="width:50px;">
			</div>
			<div class="padding5">
				<div>类型描述</div>
				<textarea id="descripts" style="width:300px;height:100px;max-height:100px;"></textarea>
			</div>
		
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="submits()">提交</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#winAdd').dialog('close')">取消</a>
	</div>

</body>
</html>