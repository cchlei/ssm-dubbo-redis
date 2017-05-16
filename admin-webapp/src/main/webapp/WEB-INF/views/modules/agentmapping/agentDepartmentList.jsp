<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院科室列表</title>
</head>

<body>
	<form name="form" role="form" action="${ctx}/hospDep/list" method="GET">
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> ${myMappingBean.hosp.hospName}科室列表
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
			<c:forEach items="${resultList}" var="dept" varStatus="status">
			<tr>
				<td>${dept.agentDepartmentRef.agentId}</td>
				<td>${dept.agentDepartmentRef.departmentId}</td>
				<td>${dept.agentDepartmentRef.myDepartmentId}</td>
				<td>${dept.department.departmentName}</td>
				<td><a href="${ctx}/agentMapping/toEditDepartment?agentDepartmentRef.agentId=${dept.agentDepartmentRef.agentId}&department.departmentName=${dept.department.departmentName}&agentDepartmentRef.myDepartmentId=${dept.agentDepartmentRef.myDepartmentId}&hosp.hospName=${myMappingBean.hosp.hospName}">修改</a>&nbsp;
				<a href="${ctx}/agentMapping/doctorList?agentDepartmentRef.agentId=${dept.agentDepartmentRef.agentId}&hosp.hospName=${myMappingBean.hosp.hospName}&agentDepartmentRef.myDepartmentId=${dept.agentDepartmentRef.myDepartmentId}&department.departmentName=${dept.department.departmentName}">科室医生</a>&nbsp;
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	   
	
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	
});


</script>
</body>
</html>