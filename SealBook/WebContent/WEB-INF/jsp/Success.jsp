<%@page import="com.cjeg.mode.People"%>
<%@page import="java.util.List"%>
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
<title>Insert title here</title>
</head>
<body>
成功
<%
List<People>ls=(List<People>)session.getAttribute("result");
if(ls!=null)
{
	for(People p:ls)
	{
		out.write("<p>"+p+"</p>");
	}
	
}

%>
<div id="win" class="easyui-window" style="width:100px;height:100px;background-color:red" title="窗口">
</div>
</body>
</html>