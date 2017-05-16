<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生第三方数据</title>
</head>

<body>
	<ul class="nav nav-tabs">
	    <li><a href="${ctx}/doctor/toAddorEdit?doctorId=${doctor.doctorId}&hospId=${params.hospId}&departmentId=${params.departmentId}&standardDepartmentId=${params.standardDepartmentId}">医生编辑</a></li>
		<li class="active"><a href="javascript:void(0)"">医生his数据</a></li>
	</ul>
	<div id="hisDataDiv"></div>
	<br />
<script type="text/javascript">
		var ctx = "${ctx}";
	$(document).ready(function() {
		var data = '${hisData}';
		if(data!=""){
       		$("#hisDataDiv").JSONView(data);
		}else{
			$("#hisDataDiv").html("<span style='color:red;'>无</span>");
		}
	});
	
</script>
</html>