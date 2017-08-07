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
<c:set var="book" value="${data.obj}"/>
<script type="text/javascript">
$(function(){
	//初始化导航菜单选择的栏目
	var lis=$(".head .menu li");
	$(lis[0]).css({"background-color":"#950C09"});	
	var publishDate=dateFormat('${book.publishData}');
	$(".publishDate").html(publishDate);
	$("input[name=number]").val(1);
	
	$(".num .sub").click(function(){
		var num=$("input[name=number]").val();
		if(num!=""&&num>1){
			num--;
			$("input[name=number]").val(num);
		}
	});
	$(".num .add").click(function(){
		var num=$("input[name=number]").val();
		if(num!=""){
			num++;
			$("input[name=number]").val(num);
		}
	});
});
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
//购物按钮
$(function (){
	$(".btn .add").click(function(){
		var number=$(".num input[name=number]").val();
		var id="${book.id }";
		$.ajax({
			url:'${ctx}/buyBook/addGoodsCar',
			data:{id:id,number:number},
			type:'post',
			success:function(result){
				toast(result.message);
			},
			error:function(){
				toast("网络故障!");
			}
		});
	});
	$(".btn .goBuy").click(function(){
		var number=$(".num input[name=number]").val();
		var id="${book.id }";
		$.ajax({
			url:'${ctx}/buyBook/currentBuy',
			data:{id:id,number:number},
			type:'post',
			success:function(result){
				alertMsg(result.message);
			},
			error:function(){
				toast("网络故障!");
			}
		});
	});
});
</script>

</head>
<body>
	<div class="contain">
		<jsp:include page="../head.jsp"></jsp:include>
		
		<div class="buy">
			<div class="details">
				<input type="text" name="id" value="${book.id }" style="display:none">
				<img src="${book.image}" style="width:330px;height:400px;" >
				<div class="name"> ${book.name}</div>
				<div class="price">
					<span>现价：</span>
					<span class="current">￥${book.currentPrice }</span>
					<span>原价：</span>
					<span class="prime">￥${book.primeCost }</span>
				</div>
				<div class="msg">
					<div>作者：${book.author }</div>
					<div>出版社：${book.publishingCompany }</div>
					<div>出版日期：<span class="publishDate"></span></div>
					<div class="count">销量：<span>100</span>件</div>
					<div class="num">
						<span>数量</span>
						<span class="sub">－  </span>
						<input type="text"  name="number" />
						<span class="add">＋</span>
					</div>
				</div>
				<div class="btn">
					<input class="goBuy" type="button" value="立即购买">
					<input class="add" type="button" value="加入购入车">
				</div>
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