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

function sexs(show){
	if(show){
		return "男";
	}else{
		return "女";
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
		url:'${ctx}/admin/user/remove?id='+id,
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

//重置密码
function update(){
	var row = $('#tt').datagrid('getSelected');
	if(!row){
		alertMsg("请选择要删除的行");
		return false;
	}
	var id=row.id;
	$.ajax({
		url:'${ctx}/admin/user/update?id='+id,
		type:'get',
		success:function(result){
			if(result.flag){
				alertMsg("密码重置成功，新密码为123456");
			}else{
				alertMsg("密码重置失败");
			}
		}
	});
}
</script>
</head>
<body>
	<div class="table">
		<table id="tt" class="easyui-datagrid" style="width:100%;"
			url="${ctx}/admin/user/list"
			title="书籍类型" iconCls="icon-save"
			toolbar="#tb"
			singleSelect="true"
			rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="id" hidden="true" width="150" align="center">id</th>
					<th field="name" width="100" align="center">用户名</th>
					<th field="sex" width="50" align="center" formatter="sexs">性别</th>
					<th field="phone" width="200" align="center">电话</th>
					<th field="mail" width="200" align="center">邮箱</th>
					<th field="createTime" width="150" align="center" formatter="dateTimeFormat">创建日期</th>
					<th field="updateTime" width="150" align="center" formatter="dateTimeFormat">修改日期</th>
				</tr>
			</thead>
		</table>
		
		<div id="tb">
			<div>
			<span>用户名称: </span><input type="text" name="name" id="name">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchs()" >查询</a>
			</div>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="update()">重置密码</a>
		</div>
	</div>

</body>
</html>