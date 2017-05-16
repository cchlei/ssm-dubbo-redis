<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>规则列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">规则列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/rule/list" method="GET">
	规则名称：<input type="text"  id="ruleName" name="ruleName"  value="${ruleName}"/>&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="${ctx}/rule/toAddorEdit">添加规则</a>
	</form>
	
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 规 则 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">规则名称</th>
				<th class="text-center">规则编码</th>
				<th class="text-center">规则类型</th>
				<th class="text-center">状态</th>
				<th class="text-center">修改人名称</th>
				<th class="text-center">修改时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${ruleList}" var="rule" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td>${rule.ruleName}</td>
				<td>${rule.ruleCode}</td>
				<td>
				<c:if test="${rule.ruleType==1}">通用</c:if>
				<c:if test="${rule.ruleType==2}">渠道</c:if>
				</td>
				<td>
				 <c:if test="${rule.isEnabled==0}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${rule.isEnabled==1}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${rule.ruleId}','${rule.isEnabled}')">切换</button>
				 </td>
				<td>${rule.operatorName}</td>
				<td><fmt:formatDate value="${rule.operationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><a href="${ctx}/rule/toAddorEdit?ruleId=${rule.ruleId}">修改</a>&nbsp;<a href="#" del_id="${rule.ruleId}">删除</a></td>
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
				$.get("${ctx}/rule/delete/"+id, function(json) {
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

function changeStat(ruleId,status){
	//转换启用禁用状态
	var parentId = '${parentId}';
	var ruleName = '${ruleName}';
	if(status==0){
		status=1;
	}else if(status==1){
		status=0;
	} 
	var change = ruleId+","+status;
	url="${ctx}/rule/list?parentId="+parentId+"&ruleName="+ruleName+"&change="+change;
	//alert(url);
	window.location.href=url;
	
}


</script>
</body>
</html>