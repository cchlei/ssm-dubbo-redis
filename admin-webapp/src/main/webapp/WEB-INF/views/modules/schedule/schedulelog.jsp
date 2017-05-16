<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>任务调度</title>
</head>

<body>

	<div class="panel panel-default">
		<table class="table table-bordered table-hover tablesorter">
			<thead>
				<tr>
					<th class="text-center">类别</th>
				    <th class="text-center">主机</th>
					<th class="text-center">时间</th>
					<th class="text-center">结果</th>
				</tr>
			</thead>
			<c:forEach items="${logs}" var="l" varStatus="status">
				<c:if test="${l.category == 1}"><tr style="color: red; font-weight: bold;"></c:if>
				<c:if test="${l.category == 2}"><tr></c:if>
					<td  class="text-center">
						<c:if test="${l.category == 1}">调度</c:if>
						<c:if test="${l.category == 2}">处理</c:if>
					</td>
				    <td  class="text-center">${l.hostName}</td>
					<td  class="text-center"><fmt:formatDate value="${l.handleTime}" pattern="yyyy年MM月dd日HH时mm分ss秒" /></td>
					<td  class="text-center">
						<c:if test="${l.success == true}">成功</c:if>
						<c:if test="${l.success == false}">异常</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>