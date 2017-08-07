<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String path=request.getContextPath();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/themes/icon.css">
	<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
	var m_type; 
	/*
	$(function()
	{
		$('#tt').datagrid({
			title:"123",
			pagination:true,
			url:"<%=path%>/menu/getMenu",
			columns:[[
			          {field:'error',title:'错误',width:'200px'}
			          ]],
			onLoadSuccess:function(data)
			{
				$('#tt').datagrid("appendRow",{
					error:'错误。。。。。。。'
				});
			}
		});
	});*/
	function menu_add(type)
	{
		m_type=type;
		var row=$("#menu").treegrid("getSelected");
		if(row)
		{
			if(row.isDir)
			{
				if(type==11)
				{
					openDlg("#dir_menu");
				}
				else if(type==12)
				{
					openDlg("#dir_menu");
				}
				else if(type==1)
				{
					openDlg("#func_menu");
				}
			}
			else
			{
				$.messager.alert("提示","功能菜单下不能添加子菜单");
				return 0;
			}
			//$("#menu").treegrid("reload");
		}
		else
		{
			$.messager.alert("温馨提示","请选择行");
		}
		
	}
	
	function menu_save()
	{
		var row=$("#menu").treegrid("getSelected");
		var name;
		var url;
		var id=row.id;
		var parentId=row.parentId;
		if(m_type==1)
		{
			name=$("#menuName").val();
			url=$("#menuUrl").val();
			if(name==""||url=="")
			{
				return false;
			}
		}
		else 
		{
			name=$("#dirName").val();
			if(name=="")
			{
				return false;
			}
		}
		$.ajax({
			  type:"post",
			  url:"<%=path%>/menu/add",
			  dataType: "json",
			  data:{name:name,url:url,id:id,parentId:parentId,type:m_type},
			  success:function(result){
				  if(result.state=="success")
					{
					  $.messager.alert("提示","添加成功");
					  $("#menu").treegrid("reload");
					}
				  else
					{
					  $.messager.alert("提示","添加失败");
					}
				  if(m_type==1)
					{
					  closeDlg("#func_menu");
					}
				  else
					{
					  closeDlg("#dir_menu");
					}
				  
				}
			});

	}
	
	function menu_delete()
	{
		var row=$("#menu").treegrid("getSelected");
		if(row)
		{
			$.ajax({
				  type:"post",
				  url:"<%=path%>/menu/delete",
				  dataType: "json",
				  data:{id:row.id},
				  success:function(result){
					  $.messager.alert("提示",result.message);
					  if(result.state=="success")
						{
						  $("#menu").treegrid("reload");
						}
					}
				});
		}
		else
		{
			$.messager.alert("提示","请选择一行");
		}
	}
	function openDlg(id)
	{
		$(id).dialog("open");
	}
	function closeDlg(id)
	{
		$(id).dialog('close');
	}
</script>
</head>
<body>
	<table id="tt"></table>
	<table class="easyui-treegrid" fit="true" width="100%"
		idField="id" treeField="text"
		url="<%=path%>/menu/getMenu"
		id="menu"
		title="菜单管理"
		rownumbers="true"
		toolbar="#bar"
		>
		<thead>
			<tr>
				<th field="text" width="40%">名称</th>
				<th field="url" width="40%">url</th>
			</tr>
		</thead>
	</table>
	
	<div id="bar">
	<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="menu_add(11)">添加同级目录</a>
	<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="menu_add(12)">添加下级目录</a>
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="menu_add(1)">添加功能菜单</a>
		<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="menu_delete()">删除</a>
		<a class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	</div>
	
	<!-- 添加功能菜单 -->
	<div id="func_menu" class="easyui-dialog" 
		style="width:300px;height:200px;padding:20px" 
		title="添加功能菜单" 
		modal="true" 
		buttons="#func_menu_bar"
		closed="true"
		align="center">
		菜单名称:<input type="text" id="menuName" class="easyui-textbox" required="true"><br>
		<br>
		菜单连接:<input type="text" id="menuUrl" class="easyui-textbox" required="true"><br>
		<div id="func_menu_bar">
			<a class="easyui-linkbutton" iconCls="icon-save" onclick="menu_save()">保存</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="closeDlg('#func_menu')">取消</a>
		</div>
	</div>
	<!-- 添加目录 -->
	<div id="dir_menu" class="easyui-dialog" 
		style="width:300px;height:200px;padding:20px" 
		title="添加目录" 
		modal="true" 
		buttons="#dir_menu_bar"
		closed="true"
		align="center">
		目录名称:<input type="text" id="dirName" class="easyui-textbox" required="true">
		<div id="dir_menu_bar">
			<a class="easyui-linkbutton" iconCls="icon-save" onclick="menu_save()">保存</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="closeDlg('#dir_menu')">取消</a>
		</div>
	</div>
</body>
</html>