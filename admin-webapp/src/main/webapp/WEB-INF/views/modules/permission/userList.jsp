<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>地区列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">管理员列表</a></li>
	</ul>
	<div>
   	<a href="${ctx}/manager/toAddorEdit">添加管理员</a>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 管 理 员 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">管理员名称</th>
				<th class="text-center">角色</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${userList}" var="user" varStatus="status">
			<tr>
				<td class="text-center">${user.uid}</td>
				<td>${user.username}</td>
				<td>
					<c:if test="${roleMap[user.roleId]!=null}">
				    	${roleMap[user.roleId]}
				    </c:if>
			    </td>
				<td>
				<a href="${ctx}/manager/toAddorEdit?userId=${user.uid}">修改</a>&nbsp;
				<a href="#" del_id="${user.uid}">删除</a>&nbsp;
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
<script type="text/javascript">
$(document).ready(function() {
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get("${ctx}/manager/delete/"+id, function(json) {
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
</script>
</body>
</html>