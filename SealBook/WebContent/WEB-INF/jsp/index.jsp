<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网上购书管理系统</title>
<jsp:include page="_mate.jsp"></jsp:include>
<c:set var="ctx" value="<%=request.getContextPath()%>"/>


<script type="text/javascript">
	$(function(){
		//初始化导航菜单选择的栏目
		var lis=$(".head .menu li");
		$(lis[0]).css({"background-color":"#950C09"});	
		
	});
	$(function(){
		var images=loadImage();
		if(images!=""&&images.flag){
			var obj=images.data[0];
			$("#shows").attr("src",obj.src);
			$("#d_name").html(obj.name);
			$("#d_descripts").html(obj.descripts);
			$("#d_link").attr("href",obj.link);
		}
		
		var books=loodBooks();
		if(books.flag){
			var bookDataList=books.data;
			var listItems="";
			for(var i=0;i<bookDataList.length;i++){
				var bookDataItem=bookDataList[i];
				var typeName=bookDataItem.type.name;
				var typeId=bookDataItem.type.id;
				console.log(typeName+":"+typeId);
				
				listItems+='<div class="items">';
				listItems+='<div class="title">';
				listItems+='<span class="type">'+typeName+'</span>';
				listItems+='<a href="${ctx}/detail/listDetailByTypes?type='+typeId+'">所有书籍<span></span></a>';
				listItems+='</div>';
				listItems+='<ul>';
                	
				
				var bookArray=bookDataItem.books;
				for(var j=0;j<bookArray.length;j++){
					var book=bookArray[j];
					
					listItems+='<li>';
					listItems+='<a href="${ctx}/detail/findByBookId?id='+book.id+'">';
					listItems+='<img src="'+book.image+'"/>';
					listItems+='<div class="name">'+book.name+'</div>';
					listItems+='<div class="author">作者：'+book.author+'</div>';
					listItems+='<div class="time">出版时间：'+book.publishData+'</div>';
					listItems+='<div>';
					listItems+='<span class="money1">￥ '+book.currentPrice+'</span>';
					listItems+='<span class="money2">￥ '+ book.primeCost+'</span>';
					listItems+='</div>';
					listItems+='</a>';
					listItems+='</li>';
				}
				
				listItems+='</ul>';
				listItems+='</div>';
			}
			debugger;
			$("#booklistAll").empty().append(listItems);
		}
	});
	//加载图片信息
	function loadImage(){
		var result="";
		$.ajax({
			async:false,/*同步加载*/
			url:'${ctx}/first/getImage',
			success:function(data){
				result=data;
			},
			error:function(){
				toast("加载通知信息失败");
			}
		});
		return result;
	}
	//加载书籍列表
	function loodBooks(){
		var result="";
		$.ajax({
			async:false,/*同步加载*/
			url:'${ctx}/first/listBookTypes',
			data:{number:20},
			success:function(data){
				result=data;
			},
			error:function(){
				toast("加载通知信息失败");
			}
		});
		return result;
	}
	
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
					$(".show .classfiy ul").empty().append(li);
				}
			}
		});
	});
	
</script>
</head>
<body>
	<div class="contain">
		<jsp:include page="head.jsp"></jsp:include>
		
		 <!--展示信息-->
        <div class="show">
        	<!--分类-->
        	<div class="classfiy">
            	<div class="title">
                	分类
                </div>
                <div class="list">
                	<ul>
	                	<li>游戏</li>
	                    <li>操作系统</li>
	                    <li>图形学</li>
	                    <li>多媒体</li>
	                    <li>网络通信</li>
	                    <li>嵌入式</li>
                	</ul>
                </div>
                
            </div>
            <div class="detail">
            	<div class="img">
            		<img id="shows" src="${ctx}/img/book1.png"/>
            	</div>
            	<div class="msg">
            		<div id="d_name" class="name">名称</div>
            		<div id="d_descripts" class="descripts">说明</div>
            		<a href="#" id="d_link" class="link">详情</a>
            	</div>
            	
            </div>
        </div>
        <div class="list" id="booklistAll">
        	<!-- 
        	<div class="items">
            	<div class="title">
                	<span class="type">新书上架</span>
                    <a href="#">所有书籍<span></span></a>
                </div>
                
                <ul>
                	<li>
                		<a href="#">
                			<img src="${ctx}/img/book2.png"/>
                        	<div class="name">疯狂java讲义</div>
                        	<div class="author">作者：李刚</div>
                        	<div class="time">出版时间：2015-1-10</div>
                        	<div>
                        		<span class="money1">￥ 58</span>
                            	<span class="money2">￥ 88</span>
                        	</div>
                		</a>
                    </li>

                </ul>
            </div>
             -->
        </div>
		
		
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>