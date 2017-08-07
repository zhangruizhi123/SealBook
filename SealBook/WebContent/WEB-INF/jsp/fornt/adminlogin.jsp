<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>
<jsp:include page="../_mate.jsp"></jsp:include>
<c:set var="ctx" value="<%=request.getContextPath()%>" />
<script type="text/javascript">
	$(function() {
		$(".logins img").click(function(){
			this.src="${ctx}/user/img?id="+Math.random();
		});
	});
</script>
<style type="text/css">
body {
	-webkit-background-size: 100% 100%;
	-moz-background-size: 100% 100%;
	background-size: 100% 100%;
	background: url("${ctx}/img/login_bg.jpg");
}
.logins{
	width:400px;
	left:440px;
	top:240px;
	padding:10px;
	position:absolute;
	overflow:auto;
}
.logins label{
	height:50px;
	display:inline-block;
	width:80px;
	color:#fff;
}
.logins .input{
	color:#fff;
	font-size:18px;
	background-color:rgba(0,0,0,0.0);
	border:0px;
	border-radius:5px;
	height:30px;
	width:200px;
	border-bottom:1px dashed #FFCC66;
}
.logins .code{
	color:#fff;
	font-size:18px;
	background-color:rgba(0,0,0,0.0);
	border:0px;
	border-radius:5px;
	height:30px;
	width:100px;
	border-bottom:1px dashed #FFCC66;
}

.logins img{
	cursor:pointer;
	width:80px;
	height:30px;
}
.logins img:hover{
	background-color:rgba(0,0,0,0.5);
}

.logins .button .reset{
	display:inline-block;
	margin-left:20px;
	width:90px;
	height:30px;
	font-size:20px;
	background-image:url("${ctx}/img/reset.jpg");
}

.logins .button .logs{
	margin-left:40px;
	display:inline-block;
	width:90px;
	height:30px;
	font-size:20px;
	background-image:url("${ctx}/img/login.jpg");
}
</style>
</head>
<body>
	<!-- 正文 -->
	<div class="logins" style="">
		<div class="form">
			<form action="${ctx }/admin/loginSubmit" method="post">
				<div>
					<label for="userName">用户名:</label> <input class="input" type="text"
						name="userName" id="userName">
				</div>
				<div>
					<label for="password">密 码:</label> <input class="input"
						type="password" name="password" id="password">
				</div>
				<div>
					<label for="password">验证码:</label> <input class="code"
						type="text" name="code" id="code">
						<img alt="" src="${ctx}/user/img">
				</div>
				<div class="button">
					<input type="reset" class="reset" value=""> 
					<input type="submit" class="logs" value="">
				</div>
			</form>
		</div>
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