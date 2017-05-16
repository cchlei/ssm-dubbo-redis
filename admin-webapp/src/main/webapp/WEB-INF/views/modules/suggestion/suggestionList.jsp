<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>意见反馈列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">意见反馈列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/suggestion/getSuggestionList" method="GET">
	           用户名：<input type="text"  id="userNameA" name="userNameA"  value="${userNameA}"/>&nbsp;&nbsp;&nbsp;
		开始日期：<input class="Wdate" type="text" name="startDate" id="startDate"  style="width:120px;" value="${startDate}"  onClick="WdatePicker()">&nbsp;&nbsp;&nbsp;
		截止日期：<input class="Wdate" type="text" name="endDate" id="endDate"  style="width:120px;"  value="${endDate}" onClick="WdatePicker()">
	           处理状态:
	<select id="status" name="status" >
	<option value="">全部</option>
	<option value="0">未处理</option>
	<option value="1">已处理</option>
	</select>
	<input type="hidden" name="statusIndex" id="statusIndex" value="${status}">
	&nbsp;&nbsp;&nbsp;<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</form>
	
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 意见反馈列表
			</h4>
		</div>
 		<table class="table table-bordered table-hover tablesorter" style="table-layout:fixed;word-break:break-all">
			<thead>
			<tr>
			    <th class="text-center" style="width:10%; ">用户名</th>
			    <th class="text-center" style="width:51%; ">意见反馈内容</th>
				<th class="text-center" style="width:9%; ">时间</th>
				<th class="text-center" style="width:10%; ">处理状态</th>
	            <th class="text-center" style="width:10%; ">操作</th>
			</tr>
			</thead>
			<c:forEach items="${suggestionList}" var="suggestion" varStatus="idxStatus">
			<tr>
			    <input type="hidden" id ="id" name="id" value="${id}">
				<td class="text-center"><span id="userName">${suggestion.userName}</span></td>						
				<td><span id="suggestion">${suggestion.suggestion}</span></td>
                <td><fmt:formatDate value="${suggestion.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td class="text-center"><span id="statusName" name="statusName">${suggestion.status}</span></td>
				<td class="text-center">
				<a class="passA" href="javascript:pass(${suggestion.id},1)">处理</a>
				<a class="passB" href="javascript:pass(${suggestion.id},0)">未处理</a>
				</td>
			</tr>
			</c:forEach>
		</table>			
	</div>
<page:page pager="${page}" linkUrl="${ctx}/suggestion/getSuggestionList?userNameA=${userNameA}&startDate=${startDate}&endDate=${endDate}&status=${status}"/>
<script type="text/javascript">
$(document).ready(function() {
	optionSelected();
	changeStatus();
});
function optionSelected()
{
	var statusValue =$("#statusIndex").val();
	$("#status option[value='"+statusValue+"']").attr("selected", "selected");
}
function changeStatus()
{
	
	$("span[name='statusName']").each(function(index,element) {
		if($(this).text() == 0)
		{
			$(this).text('未处理');
			$(".passA").eq(index).show();
			$(".passB").eq(index).hide();
			
		}else if($(this).text() == 1)
		{
			$(this).text('已处理');
			$(".passA").eq(index).hide();
			$(".passB").eq(index).show();
		}	
	});
}
function pass(id,status)
{
	var ctx = "${ctx}";
	var confirmStr ="确认更改为未处理状态吗？";
	if(status ==1)
	{
		confirmStr="确认更改为已处理状态吗？";
	}
	$.confirm(confirmStr, function() {
		$.get(ctx+"/suggestion/modifySuggestion",{'id':id,'status':status}, 
				function(json)
				{
 			         var msg = "";
			         if (json.message) {
				         msg = json.message;
			         }
					 $.alert(msg, function() {
							window.location.href = ctx+'/suggestion/getSuggestionList';
							//changestatus();
					 });  
				}, "json");
	});
}

</script>
</body>
</html>