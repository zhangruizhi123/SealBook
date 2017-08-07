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
					var name=date.name;
					li+="<li><a href='${ctx}/detail/listDetailByTypes?type="+id+"'>"+name+"</a></li>";
				}
				$(".tools .nav ul").empty().append(li);
			}
		}
	});
});

$(function(){
	$("#buy").click(function(){
		var ids=[];
		$(".select_car").each(function(){
			if($(this).is(":checked")){
				var id=$(this).attr("ids");
				ids.push(id);
			}
			
		});
		
		if(ids.length>0){
			var str=ids.toString();
			window.location.href="${ctx}/buyBook/buyCar?ids="+str;
		}else{
			toast("请选择要购买的商品");
		}
	});
});
</script>

</head>
<body>
	<div class="contain">
		<jsp:include page="../head.jsp"></jsp:include>
		
		<div class="buy">
			<div class="details" style="width:100%;">
				<div class="items">
					<div style="font-size:24px;padding:10px;text-align:center;">购物车</div>
					<c:if test="${!empty data}">
							<table border="1" cellpadding="0" cellspacing="0" style="width:100%;border:1px solid #888;border-collapse: collapse;" >
								<thead>
									<tr style="border-bottom:1px solid #999;">
										<td align="center" >111</td>
										<td align="center">书名</td>
										<td align="center" >作者</td>
										<td align="center" >价格(￥)</td>
										<td align="center" >数量</td>
										<td align="center" >金额(￥)</td>
										<td align="center" >购买日期</td>
										<td align="center" >操作</td>
									</tr>
								</thead>
									<tbody >
										<c:forEach var="bk" items="${data}" >
											<c:set var="book" value="${bk.book }"/>
											<c:set var="type" value="${bk.type }"/>
											<c:set var="userBook" value="${bk.userBook }"/>
											<tr style="border-bottom:#00f 1px solid;">
												<td align="center"><img alt="" style="width:70px;height:100px;" src="${book.image }"></td>
												<td align="center">${book.name }</td>
												<td align="center">${book.author }</td>
												<td align="center">${book.currentPrice }</td>
												<td align="center">${userBook.number }</td>
												<td align="center">${userBook.number*book.currentPrice }</td>
												<td align="center"><fmt:formatDate value="${userBook.createTime }"/></td>
												<td align="center">
													<a class="link-btns" href="${ctx}/buyBook/removeCar?id=${userBook.id}">删除</a>
													<input ids="${userBook.id }" type="checkbox" class="select_car">
												</td>
											</tr>
										</c:forEach>
										
									</tbody>
							</table>
					
							
						</c:if>
						<c:if test="${empty data}">
							<div style="font-size:24px;color:#44DBC5;padding:20px;text-align:center;">
						 		购物车暂时还没有商品!
						 	</div>
						</c:if>
						<div style="padding:20px;">
							<div style="float:right;">
								<input class="buy" id="buy" type="button" style="width:100px;height:50px;background-color:#950C09;color:#fff;font-size:18px;" value="购买">
							</div>
							
						</div>
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