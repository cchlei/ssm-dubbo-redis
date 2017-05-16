<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>注册医生列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">注册医生列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/docregcheck/regDoctorList" method="GET">
	申请时间：<input class="Wdate" type="text" name="createDate" id="createDate" value="<fmt:formatDate value="${userDoctor.createDate}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;&nbsp;
	状态：<select class="sSelect"  class="sSelect"  id="auditStatus" name="auditStatus">
		    <option value="">请选择</option>
		    <option value="2">未审核</option>
		    <option value="1">通过</option>
		    <option value="0">拒绝</option>
		  </select>
	&nbsp;&nbsp;&nbsp;
	<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 注册医生列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">姓名</th>
				<th class="text-center" width="8%">所在地区</th>
				<th class="text-center" width="12%">所在医院</th>
				<th class="text-center">所在科室</th>
				<th class="text-center" width="6%">医生职称</th>
				<th class="text-center">手机号</th>
				<th class="text-center">医院分机</th>
				<th class="text-center">推荐码</th>
				<th class="text-center" width="12%">照片</th>
				<th class="text-center">申请时间</th>
				<th class="text-center">状态</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${userDocList}" var="list" varStatus="status">
			<tr>
				<td>${list.name}</td>
				<td>${list.areaName}</td>
				<td>${list.hospName}</td>
				<td>${list.deptName}</td>
				<td>${list.gradeText}</td>
				<td>${list.phone}</td>
				<td>${list.telExt}</td>
				<td>${list.referralCode}</td>
				<td>
				<c:forEach items="${fn:split(list.activeImgUrl, ',')}" var="imgUrl" varStatus="status1">
				<img src="${imgUrl}" id="img" width="50px" height="50px"  />
				</c:forEach>
				</td>
				<td><fmt:formatDate value="${list.createDate}" pattern="yyyy-MM-dd"/></td>
				<td>
					<c:if test="${list.auditStatus==2}">未审核</c:if>
					<c:if test="${list.auditStatus==1}">通过</c:if>
					<c:if test="${list.auditStatus==0}">拒绝</c:if>
				</td>
				<td>
				<c:if test="${list.auditStatus==2}">
				<a href="${ctx}/docregcheck/toCheck?userId=${list.userId}">审核</a>
				</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/docregcheck/regDoctorList"/>
<script type="text/javascript">
$(document).ready(function() {
	var auditStatus = "${userDoctor.auditStatus}";
	$("#auditStatus").val(auditStatus);
});

</script>
</body>
</html>