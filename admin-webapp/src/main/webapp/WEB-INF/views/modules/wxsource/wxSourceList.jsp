<%@ page contentType="text/html;charset=UTF-8"%><%@ include
	file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>微信入口渠道列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">入口渠道列表</a></li>
	</ul>
	<div>
		<a href="${ctx}/wxsource/toAddorEdit">添加渠道</a>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<i class="glyphicon glyphicon-list"></i> 渠道列表
				</h4>
			</div>
			<table class="table table-bordered table-hover tablesorter">
				<thead>
					<tr>
						<th class="text-center">渠道id</th>
						<th class="text-center">渠道名称</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<c:forEach items="${wxsources}" var="wxs" varStatus="status">
					<tr>
						<td class="text-center">${wxs.wxSourceId}</td>
						<td>${wxs.wxSourceName}</td>
						<td><a href="${ctx}/wxsource/toAddorEdit?sid=${wxs.wxSourceId}">修改</a>&nbsp;
							<a href="#" del_id="${wxs.wxSourceId}">删除</a>&nbsp;</td>
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
				$.get("${ctx}/wxsource/delete/"+id, function(json) {
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