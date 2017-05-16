<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>地区列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">资源列表</a></li>
	</ul>
	<div>
   	<a href="${ctx}/resource/toAddorEdit">添加资源</a>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 资 源 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">资源名称</th>
				<th class="text-center">资源类型</th>
				<th class="text-center">资源路径</th>
				<th class="text-center">资源标识</th>
				<th class="text-center">上级菜单</th>
				<th class="text-center">操作	</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="resource" varStatus="status">
			<tr>
				<td class="text-center">${resource.rid}</td>
				<td>${resource.name}</td>
				<td>
				 <c:if test="${resource.type=='normal'}">PATH</c:if>
				 <c:if test="${resource.type=='menu'}">菜单</c:if>
				 <c:if test="${resource.type=='button'}">按钮</c:if>
				</td>
				<td>${resource.url}</td>
				<td>${resource.permission}</td>
				<td>${resource.menu.name}</td>
				<td>
				<a href="${ctx}/resource/toAddorEdit?rid=${resource.rid}">修改</a>&nbsp;
				<a href="#" del_id="${resource.rid}">删除</a>&nbsp;
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
				$.get("${ctx}/resource/delete/"+id, function(json) {
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