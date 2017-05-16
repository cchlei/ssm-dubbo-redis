<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><head>
<title>欢迎首页</title>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-header"></i> 账 号 信 息
			</h4>
		</div>
		<table class="table table-bordered table-hover">
			<tr>
				<td>登录账号：</td>
				<td>${userOnline.loginName}</td>
			</tr>
			<tr>
				<td>姓名：</td>
				<td>${userOnline.name}</td>
			</tr>
			<tr>
				<td>邮箱：</td>
				<td>${userOnline.email}</td>
			</tr>
			<tr>
				<td>上次登录时间：</td>
				<td>${userOnline.createDate}</td>
			</tr>
			<tr>
				<td>上次登录IP：</td>
				<td>${userOnline.host}</td>
			</tr>
			<tr>
				<td>本次登录时间：</td>
				<td></td>
			</tr>
			<tr>
				<td>本次登录IP：</td>
				<td></td>
			</tr>
			<tr>
				<td>修改密码：</td>
				<td>
				<input type="password" id="password" name="password" value="" autocomplete="off" onfocus="this.type='password'">
				</td>
			</tr>
		</table>
	</div>

	<div align="right">
	<a onclick="changepwd('${userOnline.userId}');" href="javascript:void(0);" target="mainFrame">修改</a>
	</div>

<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
});

function changepwd(userId){
	var password = hex_encrypt($("#password").val());
	if(userId==""||password==""){
		alert("请输入密码");
		return false;
	}else{
		var url = ctx+"/account/changepwd";
		$.post(url,{'userId':userId,'password':password},function (data){
			json = eval(data);
			alert(json.message);
		});
	}
}
</script>
</body>
</html>