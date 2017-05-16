<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>地区列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">地区列表</a></li>
	</ul>
	<c:if test="${areaName!=null}">
	<br/>
	<label for="tagName" class="col-sm-2 control-label">父&nbsp; &nbsp;地 &nbsp; &nbsp;区：</label>
			<div class="col-sm-5">
				<span>${areaName}</span>
				<input id="parentId" name="parentId" type="hidden" value="${parentId}"/>
			</div><br/>
	</c:if>
	<div>
	<form name="form" role="form" action="${ctx}/area/list" method="GET">
	<c:if test="${parentId==null}">
	地区名称：<input type="text"  id="areaName" name="areaName"  value="${area.areaName}"/>&nbsp;&nbsp;&nbsp;
	排序：<input type="text"  id="sort" name="sort"   value="${area.sort}"/>&nbsp;&nbsp;&nbsp;
	<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	<a href="${ctx}/area/toAddorEdit">添加父地区</a>
    </c:if>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 地 区 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">地区名称</th>
				<th class="text-center">省市区邮政编码</th>
				<th class="text-center">排序</th>
				<th class="text-center">状态</th>
				<th class="text-center">录入人名称</th>
				<th class="text-center">录入时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${areaList}" var="area" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td>
				<a href="${ctx}/area/list?parentId=${area.areaId}&areaName=${area.areaName}&ppId=${parentId}&ppName=${areaName}">${area.areaName}</a>
				</td>
				<td>${area.zipCode}</td>
				<td>${area.sort}</td>
				<td>
				 <c:if test="${area.status==2}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${area.status==1}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${area.areaId}','${area.status}')">切换</button>
				 </td>
				<td>${area.creatorName}</td>
				<td><fmt:formatDate value="${area.creationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
				<a href="${ctx}/area/toAddorEdit?areaId=${area.areaId}&parentId=${parentId}&areaName=${areaName}">修改</a>&nbsp;
				<%-- <a href="#" del_id="${area.areaId}">删除</a>&nbsp; --%>
				<a href="${ctx}/area/toAddorEdit?parentId=${area.areaId}&areaName=${area.areaName}">添加子地区</a>&nbsp;
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	    <span>注：点击地区名称链接查看对应的子地区</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <c:if test="${parentId!=null}">
			<button type="button" class="btn" onclick="javascript:window.location='${ctx}/area/list?parentId=${ppId}&areaName=${ppName}'">返 回</button>
		</c:if>
	
<script type="text/javascript">
$(document).ready(function() {
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function(){
				$.get("${ctx}/area/delete/"+id, function(json){
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

function changeStat(areaId,status){
	//转换地区启用禁用状态
	var parentId = '${parentId}';
	var areaName = '${areaName}';
	if(status==2){
		status=1;
	}else if(status==1){
		status=2;
	} 
	var change = areaId+","+status;
	url="${ctx}/area/list?parentId="+parentId+"&areaName="+areaName+"&change="+change;
	//alert(url);
	window.location.href=url;
	
}
</script>
</body>
</html>