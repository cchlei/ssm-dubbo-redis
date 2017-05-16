<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>地区列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">角色列表</a></li>
	</ul>
	<div>
   	<a href="${ctx}/role/toAddorEdit">添加角色</a>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 角 色 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">角色名称</th>
				<th class="text-center">角色标识</th>
				<!-- 		<th class="text-center">状态</th> -->
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${roleList}" var="role" varStatus="status">
			<tr>
				<td class="text-center">${role.rid}</td>
				<td>${role.name}</td>
				<td>${role.identity}</td>
				<!-- 
				<td>
				 <c:if test="${role.show==false}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${role.show==true}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${role.rid}','${role.show}')">切换</button>
				 </td> -->
				<td>
				<a href="${ctx}/role/toAddorEdit?roleId=${role.rid}">修改</a>&nbsp;
				<a href="#" del_id="${role.rid}">删除</a>&nbsp;
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
				$.get("${ctx}/role/delete/"+id, function(json) {
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

function changeStat(rId,show){
	var status = true;
	//转换地区启用禁用状态
	if(show=="true"){
		status=false;
	}else if(show=="false"){
		status=true;
	} 
	url="${ctx}/role/list?roleId="+rId+"&show="+status;
	//alert(url);
	window.location.href=url;
	
}
</script>
</body>
</html>