<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>预注册白名单用户列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">预注册白名单用户列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/preregistrationwhitelist/whitelist" method="GET">
	用户名：<input type="text"  id="username" name="username"  value="<c:out value='${params.username}'/>"/>&nbsp;&nbsp;&nbsp;
	<%-- 身份证号：<input type="text"  id="cardNo" name="cardNo"   value="${params.cardNo}"/>&nbsp;&nbsp;&nbsp; --%>
	&nbsp;&nbsp;&nbsp;<input type="button"  onclick="searchBut();" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="${ctx}/preregistrationwhitelist/toAddWhitelist">添加预注册白名单</a>
	</form>
	
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 预注册白名单用户列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">用户ID</th>
			    <th class="text-center">用户名</th>
				<th class="text-center">角色名称</th>
				<th class="text-center">手机号</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${whiteList}" var="whiteList" varStatus="status">
			<tr>
				<td>${whiteList.user.uid}</td>
				<td>${whiteList.user.username}</td>
				<td>${whiteList.roleName}</td>
				<td>${whiteList.user.phone}</td>
				<td><a href="#" del_id="${whiteList.user.uid}">删除</a></td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/preregistrationwhitelist/whitelist?cardNo=${params.cardNo}&username=${params.username}"/>
<script type="text/javascript">
$(document).ready(function() {
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			$.confirm("确定要此用户从白名单中删除吗？删除后不可恢复！", function() {
				$.get("${ctx}/preregistrationwhitelist/delete/"+id, function(json) {
					var msg = "";
					if (json.message) {
						msg = json.message;
					}
					$.alert(msg, function() {
						window.location.reload();
					});
				}, "json");
			});
		}
	});
});
function searchBut(){
	this.form.submit();
}

</script>
</body>
</html>