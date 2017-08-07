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
		<div class="register" style="">
			<div class="title">注册界面</div>
			<div class="form">
				<!-- action="${ctx }/user/registerSubmit" -->
				<form  action="${ctx }/user/registerSubmit"  method="post">
					<div>
						<label for="userName">用户名:</label> <input  class="input" type="text" name="name" id="name">
					</div>
					<div>
						<label for="sex">性别:</label> 
						<input class="radio" name="sex" type="radio">男 
						<input class="radio" checked name="sex" type="radio">女
					</div>
					<div>
						<label for="phone">电话:</label> <input class="input" type="text" name="phone" id="phone">
					</div>
					<div>
						<label for="mail">邮箱:</label> <input class="input" type="text" name="mail" id="mail">
					</div>
					<div>
						<label for="password">密码:</label> <input class="input" type="password" name="password" id="password">
					</div>
					<div>
						<label for="repassword">确认码:</label> <input class="input" type="password" name="repassword" id="repassword">
					</div>
					<div>
						<label for="repassword">图像验证码:</label> 
						<input class="input" type="text" name="code" id="code" style=" width:100px;">
						<img alt="" id="imageCode" src="${ctx}/user/img" style="width:100px;height:40px;">
					</div>

					<div class="button">
						<input type="reset" value="重置">
						<input type="submit" value="注册"> 
					</div>
				</form>
				<c:if test="${!empty flag }">
						<script type="text/javascript">
						toast("${msg}");
						</script>
				</c:if>
			</div>
		</div>
		<jsp:include page="../footer.jsp"></jsp:include>
		
		
	</div>
</body>
</html>