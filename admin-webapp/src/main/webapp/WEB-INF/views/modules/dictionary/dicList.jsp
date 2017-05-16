<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>数据字典列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">数据字典列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/dic/list?code=GHLX" method="GET">
	<input type="hidden" id="code" name="code" value="${code}"/>
	字典名称：<input type="text"  id="dictName" name="dictName"  value="${dictInfo.dictName}"/>&nbsp;&nbsp;&nbsp;
	排序：<input type="text"  id="sort" name="sort"   value="${dictInfo.sort}"/>&nbsp;&nbsp;&nbsp;
	<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="${ctx}/dic/toAddorEdit?code=${code}">添加字典</a>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 数 据 字 典 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
			    <!-- <th class="text-center">字典编码</th> -->
				<th class="text-center">字典名称</th>
				<th class="text-center">排序</th>
				<th class="text-center">创建人</th>
				<th class="text-center">创建时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${dicList}" var="dic" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<%-- <td>${dic.dictCode}</td> --%>
				<td>${dic.dictName}</td>
				<td>${dic.sort}</td>
				<td>${dic.creatorName}</td>
				<td><fmt:formatDate value="${dic.creationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><a href="${ctx}/dic/toAddorEdit?dictId=${dic.dictId}">修改</a></td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
<script type="text/javascript">
$(document).ready(function() {
	
});


</script>
</body>
</html>