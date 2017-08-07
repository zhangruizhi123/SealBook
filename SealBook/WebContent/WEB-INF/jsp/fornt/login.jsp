<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>
<jsp:include page="../_mate.jsp"></jsp:include>
<c:set var="ctx" value="<%=request.getContextPath()%>"/>
<script type="text/javascript">
$(function(){
	//初始化导航菜单选择的栏目
	var lis=$(".head .menu li");
	$(lis[0]).css({"background-color":"#950C09"});	
});
$(function(){
	$("#imageCode").click(function(){
		this.src="${ctx}/user/img?id="+Math.random();
	});
});
</script>
<style type="text/css">
#imageCode:hover{
	background-color:rgba(0,0,0,0.5);
}
</style>
</head>
<body>
	<div class="contain">
		<jsp:include page="../head.jsp"></jsp:include>
		<!-- 正文 -->
		<div class="login" style="">
			<div class="title">登录界面</div>
			<div class="form">
				<form action="${ctx }/user/loginSubmit" method="post">
					<div>
						<label for="userName">用户名:</label> <input  class="input" type="text" name="userName" id="userName">
					</div>
					<div>
						<label for="password">密    码:</label> <input class="input" type="password" name="password" id="password">
					</div>
					<div>
						<label for="repassword">图像验证码:</label> 
						<input class="input" type="text" name="code" id="code" style=" width:100px;">
						<img alt="" id="imageCode" src="${ctx}/user/img" style="width:100px;height:40px;">
					</div>
					<div class="button">
						<input type="reset" value="重置">
						<input type="submit" value="登录"> 
					</div>
				</form>
			</div>
		</div>
		<jsp:include page="../footer.jsp"></jsp:include>
		<c:if test="${!empty flag }">
			<c:if test="${flag == false}">
				<script type="text/javascript">
				toast("${msg}");
				</script>
			</c:if>
		
		</c:if>
	</div>
</body>
</html>