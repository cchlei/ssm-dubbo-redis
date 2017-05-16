<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>账号列表</title>
</head>

<body>

	<form name="form" role="form" action="${ctx}/user/list" method="GET" style="height:64px">
		编号：<input type="text"  id="accountId" name="accountId"   style="width:80px;" value="${accountId}"/>
    	用户名：<input type="text"  id="accountName" name="accountName"   style="width:80px;" value="${accountName}"/>
		注册手机：<input type="text"  id="phone" name="phone"   style="width:120px;" value="${phone}"/>
		<input type="hidden" id="page" name="page" value="${page}"/>
		注册开始时间：<input class="Wdate" type="text" name="queryDiagnosisDateBegin" id="queryDiagnosisDateBegin"  style="width:100px;" value="${queryDiagnosisDateBegin}" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'queryDiagnosisDateEnd\')}'})">&nbsp;&nbsp;&nbsp;
		注册截止日期：<input class="Wdate" type="text" name="queryDiagnosisDateEnd" id="queryDiagnosisDateEnd"  style="width:100px;"  value="${queryDiagnosisDateEnd}" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryDiagnosisDateBegin\')}'})">
		<br>
		用户状态：<select class="mSelect"  class="mSelect"  id="isGuide" name="isGuide">
			<option value="">请选择</option>
			<option value="2">启用</option>
			<option value="3">禁用</option>
		</select>
	&nbsp;&nbsp;<input type="submit" value="查询" />
	&nbsp;&nbsp;<button type="button" onclick="exportExcel()">导出</button>
	</form>
		
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 账 号 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">用户名</th>
				<th class="text-center">注册手机</th>
				<th class="text-center">注册时间</th>
				<th class="text-center">用户状态</th>
				<th class="text-center">用户记录</th>
			</tr>
			</thead>
			<c:forEach items="${userList}" var="user" varStatus="status">
			<tr>
				<td class="text-center">${user.uid}</td>
				<td>${user.username}</td>
				<td>${user.phone}</td>
				<td><fmt:formatDate value="${user.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
				 <c:if test="${user.status=='locked'}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${user.status=='normal'}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${user.uid}','${user.status}')">切换</button>
				 </td>
				
				<td>
				<a href="${ctx}/user/recordlist?userid=${user.uid}">预约记录</a>&nbsp;
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/user/list?accountId=${accountId}&accountName=${accountName}&phone=${phone}&isGuide=${isGuide}&queryDiagnosisDateBegin=${queryDiagnosisDateBegin}&queryDiagnosisDateEnd=${queryDiagnosisDateEnd}"/>
<script type="text/javascript">
$(document).ready(function() {
	
	if("${isGuide}"!=""){
		$("#isGuide").val("${isGuide}");
	}	
	
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

function exportExcel(){
	var accountId = $("#accountId").val();
	var accountName = $("#accountName").val();
	var phone = $("#phone").val();
	var queryDiagnosisDateBegin = $("#queryDiagnosisDateBegin").val();
	var queryDiagnosisDateEnd = $("#queryDiagnosisDateEnd").val();
	var isGuide = $("#isGuide").val();
	url="${ctx}/user/exportExcel?accountId="+accountId+"&accountName="+accountName+"&phone="+phone+"&queryDiagnosisDateBegin="+queryDiagnosisDateBegin+"&queryDiagnosisDateEnd="+queryDiagnosisDateEnd+"&isGuide="+isGuide;
	window.open(url);
	
}
</script>
</body>
</html>