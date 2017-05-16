<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院映射列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医院映射列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/agentMapping/hospList" method="GET">
	平台代理名称：<select class="mSelect"  id="agentId" name="agentId">
			<option value="">请选择</option>
		<c:forEach items="${agentList}" var="agent" varStatus="status">
		    <c:if test="${agentId==agent.agentId}">
		    	<option value="${agent.agentId}" selected="selected">${agent.agentName}</option>
		    </c:if>
		    <c:if test="${agentId!=agent.agentId}">
		    	<option value="${agent.agentId}">${agent.agentName}</option>
		    </c:if>
			
		</c:forEach>
	</select>
	<input type="submit" value="查询" />
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医院映射列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">平台编号</th>
				<th class="text-center">对方医院ID</th>
				<th class="text-center">pavo医院ID</th>
				<th class="text-center">pavo医院名称</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${agentHospList}" var="hosp" varStatus="status">
			<tr>
				<td>${hosp.agentHospitalRef.agentId}</td>
				<td>${hosp.agentHospitalRef.hospitalId}</td>
				<td>${hosp.agentHospitalRef.myHospitalId}</td>
				<td>${hosp.hosp.hospName}</td>
				<td><a href="${ctx}/agentMapping/toEditHosp?agentHospitalRef.agentId=${hosp.agentHospitalRef.agentId}&hosp.hospName=${hosp.hosp.hospName}&agentHospitalRef.myHospitalId=${hosp.agentHospitalRef.myHospitalId}">修改</a>&nbsp;
				<a href="${ctx}/agentMapping/departmentList?agentHospitalRef.agentId=${hosp.agentHospitalRef.agentId}&hosp.hospName=${hosp.hosp.hospName}&agentHospitalRef.myHospitalId=${hosp.agentHospitalRef.myHospitalId}">医院科室</a>&nbsp;
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
				$.get("${ctx}/agent/delete/"+id, function(json) {
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