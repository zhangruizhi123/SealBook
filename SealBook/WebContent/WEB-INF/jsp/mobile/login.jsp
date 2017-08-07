<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>WeUI</title>
<link rel="stylesheet" href="css/weui.min.css" />
<script src="js/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#dialogs').on('click', '.weui-dialog__btn', function(){
            $(this).parents('.js_dialog').fadeOut(200);
        });
		$("#showTooltips").click(function() {
			var userName = $("#userName").val();
			var password = $("#password").val();
			$.ajax({
				url : 'login',
				type : 'post',
				data : {
					userName : userName,
					password : password
				},
				success : function(data) {
					if (data.status < 1) {
						alertMsg("警告",data.msg);
					} else {
						window.location.href = 'indexMobile';
						alertMsg("提示","登录成功");
					}
				},
				error : function(xx, error) {

				}
			});
		});
	});
	function alertMsg(title,msg){
		$('#iosDialog1').fadeIn(200);
		$('#iosDialog1').find(".weui-dialog__title").html(title);
		$('#iosDialog1').find(".weui-dialog__bd").html(msg);
	}
</script>
</head>

<body ontouchstart>
	<div class="page">
		<div class="page__hd">
			<h1 class="page__title">登录</h1>
			<!-- <p class="page__desc">对话框</p> -->
		</div>
		<div id="dialogs">
			<!--BEGIN dialog1-->
			<div class="js_dialog" id="iosDialog1" style="display: none;">
				<div class="weui-mask"></div>
				<div class="weui-dialog">
					<div class="weui-dialog__hd">
						<strong class="weui-dialog__title">弹窗标题</strong>
					</div>
					<div class="weui-dialog__bd">弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内</div>
					<div class="weui-dialog__ft">
						<a href="javascript:;"
							class="weui-dialog__btn weui-dialog__btn_default">取消</a> <a
							href="javascript:;"
							class="weui-dialog__btn weui-dialog__btn_primary">确定</a>
					</div>
				</div>
			</div>
		</div>
		
		<script>
		
		
		</script>
		<div class="weui-cells weui-cells_form">
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">用户名</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" type="text" id="userName"
						placeholder="请输入用户名" />
				</div>
			</div>
			<div class="weui-cell weui-cell_warn">
				<div class="weui-cell__hd">
					<label class="weui-label">密码</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" type="password" id="password"
						placeholder="请输入密码" />
				</div>
				<div class="weui-cell__ft">
					<i class="weui-icon-warn"></i>
				</div>
			</div>

			<div class="weui-cell weui-cell_vcode">
				<div class="weui-cell__hd">
					<label class="weui-label">验证码</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" type="text" placeholder="请输入验证码" />
				</div>
				<div class="weui-cell__ft">
					<img class="weui-vcode-img" src="Image/vcode.jpg" />
				</div>
			</div>

			<div class="weui-btn-area">
				<a class="weui-btn weui-btn_primary" href="javascript:"
					id="showTooltips">确定</a>
			</div>

			<div class="page__ft">
				<a href="javascript:home()">底部信息</a>
			</div>

		</div>
	</div>
</body>
</html>
