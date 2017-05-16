<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>停诊记录列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">停诊记录列表</a></li>
	</ul>
	<div>
   <%--  <input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/> --%>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 停诊记录列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">停诊日期</th>
				<th class="text-center">复诊日期</th>
				<th class="text-center">复诊类型</th>
				<th class="text-center">操作人</th>
				<th class="text-center">操作时间</th>
			</tr>
			</thead>
			<%-- <c:forEach items="${newsTag}" var="tag" varStatus="status"> --%>
			<tr>
			</tr>
			<%-- </c:forEach> --%>
		</table>
		
	</div>
<script type="text/javascript">
$(document).ready(function() {
});

</script>
</body>
</html>