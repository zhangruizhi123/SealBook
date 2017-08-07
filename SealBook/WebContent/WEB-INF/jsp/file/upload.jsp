<%@page import="com.cjeg.mode.People"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String path=request.getContextPath();
System.out.println(request.getRealPath(""));
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/themes/icon.css">
	<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=path%>/js/locale/easyui-lang-zh_CN.js"></script>
<title>文件上传</title>
<script type="text/javascript">
	$(function()
	{
		$("#btn").click(function()
			{
				$("#fm").ajaxSubmit({
					success:function(data)
					{
						if(data=="success")
						{
							alert("上传成功");
						}
						else
						{
							alert("上传失败");
						}
					}
				});
			});
		
	});
	
	function reg()
	{
		$.ajax({
			url:'<%=path %>/file/regester',
			type:'post',
			data:{name:$("#name").val()},
			success:function(data)
			{
				alert(data);
			}
		});
	}
</script>
</head>
<body>
	<form id="fm" action="<%=path %>/file/upload" method="post" enctype="multipart/form-data">
		<input type="file" name="abc">
		<input type="text" name="sex">
	</form>
	<input id="btn" type="button" value="提交"> 
	<a href="<%=path %>/file/download">下载</a>
	<hr>
	请输入姓名:<input type="text" name="name" id="name">
	<input type="button" value="注册" onclick="reg()">
</body>
</html>