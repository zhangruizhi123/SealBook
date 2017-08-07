<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="<%=request.getContextPath()%>"/>
<c:set var="userName" value="${user_session.name}"/>
<script type="text/javascript">
$(function(){
	var notice=loadNotice();
	$(".notices").html(notice);
	//获取用户信息
	var userName="${userName}";
	//用户还没有登录
	if(userName!=""){
		$("#logina").html("退出");
		$("#nicheng").html(userName+"  你好");
	}
	//当点击需要退出时
	$("#logina").click(function(){
		if(userName!=""){
			window.location.href="${ctx}/user/logout";
		}
	});
	if($("#logina").html()=="登录"){
		$("#loginspan").hover(function(){
			$("#logs").show();
			
		},function(){
			$("#logs").hide();
		});
	}
	
});
</script>
<div class="head">
        	<div>
            	<div class="connect">联系我们 
                	<span>tel:15172442298</span>
             	</div>
             	<div class="own">
                	<span class="mg-5" ><a href="#" id="nicheng">昵称</a></span>|
                   	<span id="loginspan" class="mg-5" style="position:relative;" >
                   	<a id="logina" href="#">登录</a>
                   	<ul id="logs" style="display:none;top:18px;padding:5px;width:60px;left:0px;position:absolute;background-color:#333;color:#fff;">
		                   <li><a href="${ctx }/user/login">我有账号</a></li>
		                   <li><a href="${ctx }/user/register">注册</a></li>
		            </ul>
	                   	
                   	</span>|
                  	<span class="mg-5" >
                  	<a href="${ctx}/buyBook/getAllOrder">我的订单</a>
                  	</span>|
                  	<span class="mg-5" >
                  		<a href="${ctx}/buyBook/goShopingCar">购物车</a>
                  	</span>
           	 	</div>
       	 	</div>
            <div class="logo">
            	<div class="img">
            		<img alt="" src="${ctx}/img/logo.png">
            	</div>
           	 	<div class="msg notices">
           	 	提示信息
           	 	</div>
            </div>
            
            <div class="menu">
            	<ul>
                	<li><a href="${ctx}/index">首页</a></li>
                    <li><a href="#">关于我</a></li>
                    <li><a href="#">书记发货</a></li>
                    <li><a href="#">新闻</a></li>
                    <li><a href="#">联系我们</a></li>
                    <span></span>
                    <input  type="text" placeholder="清输入搜索内容"/>
                    
                </ul>
            </div>
        	
        </div>