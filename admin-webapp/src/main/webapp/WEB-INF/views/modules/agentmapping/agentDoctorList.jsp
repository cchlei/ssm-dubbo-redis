<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生列表</title>
</head>

<body>
	<form name="form" role="form" action="${ctx}/hospDep/list" method="GET">
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> ${myMappingBean.hosp.hospName}-${myMappingBean.department.departmentName}  医生列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			   <th class="text-center">平台编号</th>
				<th class="text-center">对方医生ID</th>
				<th class="text-center">pavo医生ID</th>
				<th class="text-center">pavo医生名称</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${resultList}" var="doctor" varStatus="status">
			<tr>
				<td>${doctor.agentDoctorRef.agentId}</td>
				<td>${doctor.agentDoctorRef.doctorId}</td>
				<td>${doctor.agentDoctorRef.myDoctorId}</td>
				<td>${doctor.doctor.doctorName}</td>
				<td><a href="${ctx}/agentMapping/toEditDoctor?agentDoctorRef.agentId=${doctor.agentDoctorRef.agentId}&doctor.doctorName=${doctor.doctor.doctorName}&agentDoctorRef.myDoctorId=${doctor.agentDoctorRef.myDoctorId}&hosp.hospName=${myMappingBean.hosp.hospName}&department.departmentName=${myMappingBean.department.departmentName}">修改</a>&nbsp;
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