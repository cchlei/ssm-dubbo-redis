<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生号源列表</title>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生号源编辑</a></li>
	</ul>
<%-- 	<c:if test="${fn:length(dateList)==0}">
	<span style="color:red;">请先编辑医生号源模板！</span><br/>
	</c:if> --%>
	
	<c:forEach items="${dateList}" var="datelist" varStatus="status">
			<c:if test="${status.count==1}">
				<label>是否分时段：</label>
				<c:if test="${datelist.isTimespan==1}">是</c:if>
				<c:if test="${datelist.isTimespan==2}">否</c:if><br/>
			</c:if>
	</c:forEach>
	<c:if test="${isThirdpartyFlag!=1}">
		<a href="${ctx}/sourcesDet/toAdd?doctorId=${doctorId}&doctorName=${doctorName}&hospId=${hospId}&departmentId=${departmentId}">新增+</a>
	</c:if>
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${departmentId}"/>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> “${doctorName}”号源列表
			</h4>
		</div>
		<input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">日期</th>
				<th class="text-center">号源数</th>
				<th class="text-center">已挂号数</th>
				<!-- <th class="text-center">挂号类型</th> -->
				<c:if test="${isThirdpartyFlag!=1}">
				<th class="text-center">操作</th>
				</c:if>
			</tr>
			</thead>
			<c:forEach items="${dateList}" var="datelist" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td><fmt:formatDate value="${datelist.resourceDate}" pattern="yyyy-MM-dd"/></td>
				<td>${datelist.resourceNum}</td>
				<td>${datelist.issuedResourceNum}</td>
				<%-- <td>
				${dicMap[datelist.resourceTpye]}
				</td> --%>
				<c:if test="${isThirdpartyFlag!=1}">
				<td><a href="${ctx}/sourcesDet/dayList?doctorId=${doctorId}&hospId=${hospId}&departmentId=${departmentId}&date=<fmt:formatDate value="${datelist.resourceDate}" pattern="yyyy-MM-dd"/>">详情</a></td>
				</c:if>
				</tr>
			</c:forEach>
		</table>
		
	</div>
<script type="text/javascript">
/* $(document).ready(function() {
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get("${ctx}/tag/delete/"+id, function(json) {
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
}); */
/* 
function changeStat(tagId,status){
	//转换地区启用禁用状态
	if(status==2){
		status=1;
	}else if(status==1){
		status=2;
	} 
	var change = tagId+","+status;
	url="${ctx}/tag/list?change="+change;
	//alert(url);
	window.location.href=url;
	
} */


</script>
</body>
</html>