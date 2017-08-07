<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>
<jsp:include page="../_mate.jsp"></jsp:include>
<c:set var="ctx" value="<%=request.getContextPath()%>"/>
<c:set var="book" value="${data.obj}"/>
<script type="text/javascript">
$(function(){
	//初始化导航菜单选择的栏目
	var lis=$(".head .menu li");
	$(lis[0]).css({"background-color":"#950C09"});	
});

//加载右侧导航栏
$(function(){
	$.ajax({
		url:'${ctx}/detail/getBookTypes',
		type:'post',
		success:function(result){
			if(result.flag){
				var dates=result.data;
				var li="";
				for(var i=0;i<dates.length;i++){
					var date=dates[i];
					var id=date.id;
					debugger;
					var name=date.name;
					li+="<li><a href='${ctx}/detail/listDetailByTypes?type="+id+"'>"+name+"</a></li>";
				}
				$(".tools .nav ul").empty().append(li);
			}
		}
	});
});

$(function(){
	//分页
	var total="${total}";
	var size="${size}";
	var page="${page}";
	$(".pages .pre").click(function(){
		if(page==1){
			toast("已经是首页了");
			return false;
		}
		page=parseInt(page)-1;
		$(".pages input[name=page]").val(page);
		$("#fm").submit();
	});
	$(".pages .next").click(function(){
		if(size*page>total){
			toast("已经是最后一页了");
			return false;
		}
		page=parseInt(page)+1;
		$(".pages input[name=page]").val(page);
		$("#fm").submit();
	});
	
});
</script>

</head>
<body>
	<div class="contain">
		<jsp:include page="../head.jsp"></jsp:include>
		
		<div class="buy">
			<div class="details">
				<div class="items">
					 <ul>
						<c:if test="${!empty data.data}">
							<c:forEach var="book" items="${data.data }">
					 			<li>
			                		<a href="${ctx}/detail/findByBookId?id=${book.id}">
			                			<img src="${book.image}"/>
			                        	<div class="name">${book.name}</div>
			                        	<div class="author">作者：${book.author}</div>
			                        	<div class="time">出版时间：<fmt:formatDate value="${book.publishData }"/></div>
			                        	<div>
			                        		<span class="money1">￥ ${book.currentPrice}</span>
			                            	<span class="money2">￥${book.primeCost}</span>
			                        	</div>
			                		</a>
			                    </li>
					 		</c:forEach>
						</c:if>
					 	<c:if test="${empty data.data}">
					 		<div style="font-size:24px;color:#44DBC5;padding:20px;text-align:center;">
					 		暂时还没有书籍
					 		</div>
					 	</c:if>
	                </ul>
				</div>
				<!-- 当不为空时显示分页 -->
				<c:if test="${!empty data.data}">
					<div class="pages" style="text-align:center;">
						<form id="fm" method="post" action="${ctx}/detail/listDetailByTypes">
							<input type="text" style="display:none;" name="total" value="${total}">
							<input type="text" style="display:none;" name="type" value="${type}">
							<input type="text" style="display:none;" name="page" value="${page}">
							<input type="text" style="display:none;" name="size" value="${size}">
							<input type="button" class="pre" value="上一页">
							<input type="button" class="next" value="下一页">
						</form>
					</div>
				</c:if>
				
			</div>
			<div class="tools">
				<div class="nav">
					<ul>
						<li><a href="#">计算机编程</a></li>
						<li><a href="#">计算机网络</a></li>
						<li><a href="#">考试认证</a></li>
						<li><a href="#">工具书籍</a></li>
					</ul>
				</div>
				
				<div style="padding:10px;font-size:24px;color:#aaa;">联系我们</div>
				<div class="msg" >
					<ul>
					<li>电话：123456789</li>
					<li>QQ： 121234325</li>
					<li>邮箱：1212324@qq.com</li>
					<li>地址：武汉市洪山区</li>
				</ul>
				</div>
				
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