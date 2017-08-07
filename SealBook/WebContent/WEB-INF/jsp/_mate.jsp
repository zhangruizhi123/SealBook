<!-- 放入引入的库和 css文件-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<c:set var="ctx" value="<%=request.getContextPath()%>"/>

<link rel="icon" href="${ctx}/img/logo.ico" type="img/x-ico" />
<link  rel="stylesheet" href="${ctx}/csss/comm.css"  />
<link  rel="stylesheet" href="${ctx}/csss/mcomm.css"  />
<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/js/comm.js"></script>
<script type="text/javascript" src="${ctx}/js/mcomm.js"></script>
<script>
//带有前下划线
var ctx="<%=request.getContextPath()%>";
//body的宽度
var bodyWidth=0;
//body的高度
var bodyHeight=0;
$(function(){
	bodyWidth=$("body").width();
	bodyHeight=$("body").height();
});
//弹出提示都用这个后期便于修改样式
function  alertMsg(msg){
	alert(msg);
}

//加载通告信息
function loadNotice(){
	var result="";
	$.ajax({
		async:false,/*同步加载*/
		url:'${ctx}/first/notice',
		success:function(data){
			result=data.obj;
		},
		error:function(){
			toast("加载通知信息失败");
		}
	});
	return result;
}

/*弹出提示然后在2.5秒内消失*/
function toast(msg){
	var can="<span style='z-index:9999;position:fixed;left:50%;top:50%;transform:translate(-50%,-50%);-webkit-transform:translate(-50%,-50%);padding:10px;border-radius:5px;color:#fff;background-color:rgba(0,0,0,0.7);'>";
	can+=msg+"</span>";
	var $toast=$(can);
	$('body').append($toast);
	setTimeout(function(){$toast.remove()},2000);
	/*$toast.animate({opacity:'0'},2500,function(){
		$(this).remove();
	});*/
}

function dateFormat(date){
	var mydate=new Date(date);
	var myyear=mydate.getYear()+1900; 
	var mymonth=mydate.getMonth()+1;//注：月数从0~11为一月到十二月 
	var mydat=mydate.getDate(); 
	return myyear+"-"+mymonth+"-"+mydat;
}
</script>