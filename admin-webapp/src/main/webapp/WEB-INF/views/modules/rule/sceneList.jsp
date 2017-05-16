<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>场景列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">场景列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/scene/list" method="GET">
	<select class="mSelect"  class="mSelect"  id="channelId" name="channelId">
    <option value="">请选择</option>
    <c:forEach items="${channelList}" var="channel" varStatus="status">
       <c:if test="${scene.channelId==channel.channelId}">
	    	<option value="${channel.channelId}" selected="selected">${channel.channelName}</option>
	   </c:if> 	
	   <c:if test="${scene.channelId!=channel.channelId}">
	    	<option value="${channel.channelId}">${channel.channelName}</option>
	   </c:if> 	
    </c:forEach>
    </select>
	<input type="submit"  value="查询" />
    	<a href="${ctx}/scene/toAddorEdit">添加场景</a>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>  场景列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">场景名称</th>
				<th class="text-center">所属渠道</th>
				<th class="text-center">状态</th>
				<th class="text-center">修改人名称</th>
				<th class="text-center">修改时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${sceneList}" var="scene" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td>
				${scene.sceneName}
				</td>
				<td>
				<c:if test="${scene.channelId!=0}">
				${channelMap[scene.channelId]}
				</c:if>
				</td>
				<td>
				 <c:if test="${scene.isEnabled==0}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${scene.isEnabled==1}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${scene.sceneId}','${scene.isEnabled}')">切换</button>
				 </td>
				<td>${scene.operatorName}</td>
				<td><fmt:formatDate value="${scene.operationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
				<a href="${ctx}/scene/toAddorEdit?sceneId=${scene.sceneId}">修改</a>&nbsp;
				<a href="#" del_id="${scene.sceneId}">删除</a>&nbsp;
				<a href="${ctx}/scene/ruleRelation?sceneId=${scene.sceneId}&sceneName=${scene.sceneName}">关联规则</a>&nbsp;
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
				$.get("${ctx}/scene/delete/"+id, function(json) {
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

function changeStat(sceneId,status){
	//转换启用禁用状态
	if(status==0){
		status=1;
	}else if(status==1){
		status=0;
	} 
	var change = sceneId+","+status;
	url="${ctx}/scene/list?change="+change;
	//alert(url);
	window.location.href=url;
	
}
</script>
</body>
</html>