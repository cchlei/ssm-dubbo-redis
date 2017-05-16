<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>账号列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">账号列表</a></li>
	</ul>
	<form name="form" role="form" action="${ctx}/area/list" method="GET">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 预 约 记 录
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">医院名称</th>
				<th class="text-center">科室名称</th>
				<th class="text-center">医生</th>
				<th class="text-center">就诊人</th>
				<th class="text-center">性别</th>
				<th class="text-center">证件号</th>
				<th class="text-center">联系电话</th>
				<th class="text-center">就诊时间</th>
				<th class="text-center">预约时间</th>
				<th class="text-center">社保卡号</th>
				<th class="text-center">医院处理状态</th>
			</tr>
			</thead>
			<c:forEach items="${regRecordList}" var="regRecord" varStatus="status">
			<tr>
				<td>${regRecord.hospName}</td>
				<td>${regRecord.departmentName}</td>
				<td>${regRecord.doctorName}</td>
				<td>${regRecord.patientName}</td>
				<td>
				<c:if test="${regRecord.sex==1}">男</c:if>
				<c:if test="${regRecord.sex==2}">女</c:if>
				</td>
				<td>${regRecord.idCard}</td>
				<td>${regRecord.phoneNum}</td>
				<td>
				<fmt:formatDate value="${regRecord.diagnosisDate}" pattern="yyyy-MM-dd"/>&nbsp;
				<%-- <c:if test="${regRecord.week==7}">
					星期日
					</c:if>
					<c:if test="${regRecord.week!=7}">
					星期${regRecord.week}
				</c:if>&nbsp; --%>
				<c:if test="${regRecord.ampm==1}">上午</c:if>
					<c:if test="${regRecord.ampm==2}">下午</c:if>	
					
				<c:if test="${regRecord.timespanStart!=''}">
				<fmt:formatDate value="${regRecord.timespanStart}" pattern="HH:mm"/>
				</c:if>
				</td>
				<td><fmt:formatDate value="${regRecord.registrationDate}" pattern="yyyy-MM-dd"/></td>
				<td>${regRecord.medicareNumber}</td>
				<td>
				<c:if test="${regRecord.isGuide=='1'}">未处理</c:if>
				<c:if test="${regRecord.isGuide=='2'}">接诊</c:if>
				<c:if test="${regRecord.isGuide=='3'}">拒绝</c:if>
				<c:if test="${regRecord.isGuide=='4'}">爽约</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		<div class="col-sm-offset-0  col-sm-1"></br>
			<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
			<span id="msg-info" style="margin-left:10px;"></span>
		</div>
	</div>
	</form>
<script type="text/javascript">
$(document).ready(function() {
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get("${ctx}/area/delete/"+id, function(json) {
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

function changeStat(userid,status){
	if(status=='normal'){
		status='locked';
	}else if(status=='locked'){
		status='normal';
	} 
	url="${ctx}/user/list?userid="+userid+"&status="+status;
	window.location.href=url;
	
}
</script>
</body>
</html>