<%@ page contentType="text/html;charset=UTF-8"%><%@ include
	file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>导入管理</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">平台数据导入管理</a></li>
	</ul>
	<br />
	<form name="form" role="form" method="POST" action="${ctx}/import/importAgent">
		<label>平台:</label>
		<select class="mSelect" id="agentId" name="agentId" >
			<option value="">请选择平台</option>
			<c:forEach items="${agentList}" var="agent" varStatus="status">
				<c:if test="${agentId == agent.agentId}">
					<option value="${agent.agentId}" selected="selected">${agent.agentName}</option>
				</c:if>
				<c:if test="${agentId != agent.agentId}">
					<option value="${agent.agentId}">${agent.agentName}</option>
				</c:if>
			</c:forEach>
		</select>
		<select class="mSelect" id="importType" name="importType" >
			<c:if test="${importType == 1}">
				<option value="1" selected="selected">导入医院数据</option>
			</c:if>
			<c:if test="${importType != 1}">
				<option value="1">导入医院数据</option>
			</c:if>
			<c:if test="${importType == 2}">
				<option value="2" selected="selected">导入科室数据</option>
			</c:if>
			<c:if test="${importType != 2}">
				<option value="2">导入科室数据</option>
			</c:if>
			<c:if test="${importType == 3}">
				<option value="3" selected="selected">导入医生数据</option>
			</c:if>
			<c:if test="${importType != 3}">
				<option value="3">导入医生数据</option>
			</c:if>
		</select>
		<button type="submit" class="btn btn-primary" data-loading-text="正在导入...">确认导 入</button>
	</form>
	<p />
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">单医院数据导入管理</a></li>
	</ul>
	<br />
	<div>
	<form name="form" role="form" action="${ctx}/import/importSingle" method="POST">		
		<label>医院:</label>
		<select class="mSelect" id="hospitalId" name="hospitalId">
			<option value="">请选择医院</option>
			<c:forEach items="${hospitalList}" var="hospital" varStatus="status">
				<c:if test="${hospitalId == hospital.hospitalId}">
					<option value="${hospital.hospitalId}" selected="selected">${hospital.hospitalId}</option>
				</c:if>
				<c:if test="${hospitalId != hospital.hospitalId}">
					<option value="${hospital.hospitalId}">${hospital.hospitalId}</option>
				</c:if>
			</c:forEach>
		</select>
		<select class="mSelect" id="importType" name="importType" >
			<c:if test="${importType == 2}">
				<option value="2" selected="selected">导入科室数据</option>
			</c:if>
			<c:if test="${importType != 2}">
				<option value="2">导入科室数据</option>
			</c:if>
			<c:if test="${importType == 3}">
				<option value="3" selected="selected">导入医生数据</option>
			</c:if>
			<c:if test="${importType != 3}">
				<option value="3">导入医生数据</option>
			</c:if>
		</select>
		<button type="submit" class="btn btn-primary" data-loading-text="正在导入...">确认导 入</button>
	</form>

	<div>
		<span style="color: blue">导入结果:</span> 共导入 ${count}条数据
		<table class="table table-bordered table-hover tablesorter" id="tableDoctor">
			<thead>
				<tr>
					<th class="text-center">编号</th> <th class="text-center">名称</th>
				</tr>
			</thead>
			<c:forEach items="${mapData}" var="data" varStatus="status">
			<tr>
				<td class="text-center">${data.key}</td><td class="text-center">${data.value}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
</html>