<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>渠道列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">渠道列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/channel/list" method="GET">
    	<a href="${ctx}/channel/toAddorEdit">添加渠道</a>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>  渠道列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">渠道名称</th>
				<th class="text-center">状态</th>
				<th class="text-center">修改人名称</th>
				<th class="text-center">修改时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${channelList}" var="channel" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td>
				${channel.channelName}
				</td>
				<td>
				 <c:if test="${channel.isEnabled==0}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${channel.isEnabled==1}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${channel.channelId}','${channel.isEnabled}')">切换</button>
				 </td>
				<td>${channel.operatorName}</td>
				<td><fmt:formatDate value="${channel.operationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
				<a href="${ctx}/channel/toAddorEdit?channelId=${channel.channelId}">修改</a>&nbsp;
				<a href="#" del_id="${channel.channelId}">删除</a>&nbsp;
				<a href="${ctx}/channel/hospitalRelation?channelId=${channel.channelId}&channelName=${channel.channelName}">关联医院</a>&nbsp;
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
				$.get("${ctx}/channel/delete/"+id, function(json) {
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

function changeStat(channelId,status){
	//转换启用禁用状态
	if(status==0){
		status=1;
	}else if(status==1){
		status=0;
	} 
	var change = channelId+","+status;
	url="${ctx}/channel/list?change="+change;
	//alert(url);
	window.location.href=url;
	
}
</script>
</body>
</html>