<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>预约统计列表</title>
</head>

<body>
	<!-- <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">预约统计列表</a></li>
	</ul> -->
	<form name="form" role="form" action="${ctx}/webregrecord/statisticslist" method="GET">
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	开始日期：<input class="Wdate" type="text" name="startDate" id="startDate"  value="${startDate}" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}'})">&nbsp;&nbsp;&nbsp;
	截止日期：<input class="Wdate" type="text" name="endDate" id="endDate"  value="${endDate}" onClick="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}'})">
	&nbsp;&nbsp;<input type="button" onclick="subBut()" value="查询" />
	</form>
	<br/>
	<div>
	<c:if test="${startDate!=null||endDate!=null}">
		<span style="font-size:18px;">统计期间：${startDate}至${endDate}</span>
	</c:if>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 预约统计列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">挂号类型</th>
				<th class="text-center">总预约数</th>
				<th class="text-center">未就医</th>
				<th class="text-center">已就医</th>
				<th class="text-center">已取消</th>
				<th class="text-center">拒绝就医</th>
				<th class="text-center">爽约</th>
			</tr>
			</thead>
			<c:forEach items="${statisticslist}" var="statistics" varStatus="status">
			<tr>
			<td>${statistics.resourceTypeText}</td>
			<td>${statistics.recordNum}</td>
			<td>${statistics.notYetNum}</td>
			<td>${statistics.alreadyNum}</td>
			<td>${statistics.canceledNum}</td>
			<td>${statistics.refuseNum}</td>
			<td>${statistics.missedNum}</td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
<script type="text/javascript">
$(document).ready(function() {
	
});

function subBut(){
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	if(startDate=="" || endDate==""){
		alert("请选择开始时间和结束时间！");
		return;
	}
	this.form.submit();
}

</script>
</body>
</html>