<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>标准科室列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">标准科室列表</a></li>
	</ul>
	<c:if test="${departmentName!=null}">
	<br/>
	<label for="tagName" class="col-sm-2 control-label">上&nbsp;级&nbsp;科&nbsp;室 ：</label>
			<div class="col-sm-5">
				<span>${departmentName}</span>
				<input id="parentId" name="parentId" type="hidden" value="${parentId}"/>
			</div><br/>
	</c:if>
	<div>
	<form name="form" role="form" action="${ctx}/standardDep/list" method="GET">
	<c:if test="${parentId==null}">
	科室名称：<input type="text"  id="departmentName" name="departmentName"  value="${sdInfo.departmentName}"/>&nbsp;&nbsp;&nbsp;
	排序：<input type="text"  id="sort" name="sort"   value="${sdInfo.sort}"/>&nbsp;&nbsp;&nbsp;
	<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	<%-- <a href="${ctx}/standardDep/toAddorEdit">添加一级科室</a> --%>
    </c:if>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 标 准 科 室 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">科室名称</th>
				<th class="text-center">简码</th>
				<th class="text-center">排序</th>
				<th class="text-center">状态</th>
				<th class="text-center">录入人名称</th>
				<th class="text-center">录入时间</th>
				<!-- <th class="text-center">操作</th> -->
			</tr>
			</thead>
			<c:forEach items="${deptList}" var="dept" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td>
				<a href="${ctx}/standardDep/list?parentId=${dept.standardDepartmentId}&departmentName=${dept.departmentName}&ppId=${parentId}&ppName=${departmentName}">${dept.departmentName}</a>
				</td>
				<td>${dept.brevityCode}</td>
				<td><input type="text" name="sort" id="sort" style="width:80px;" value="${dept.sort}"/></td>
				<td>
				 <c:if test="${dept.isEnabled==2}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${dept.isEnabled==1}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${dept.standardDepartmentId}','${dept.isEnabled}')">切换</button>
				 </td>
				<td>${dept.creatorName}</td>
				<td><fmt:formatDate value="${dept.creationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
				<a href="#" onclick="editNum(this,'${dept.standardDepartmentId}')">修改</a>
				</td>
				<%--<td>
				<a href="${ctx}/standardDep/toAddorEdit?standardDepartmentId=${dept.standardDepartmentId}">修改</a>&nbsp;
				<a href="#" del_id="${dept.standardDepartmentId}">删除</a>&nbsp; 
				<c:if test="${departmentName==null}">
					<a href="${ctx}/standardDep/toAddorEdit?parentId=${dept.standardDepartmentId}&departmentName=${dept.departmentName}">添加下级科室</a>&nbsp;
				</c:if> 
				</td>--%>
			</tr>
			</c:forEach>
		</table>
	</div>
	    <span>注：点击科室名称链接查看对应的下级科室</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <c:if test="${parentId!=null}">
			<button type="button" class="btn" onclick="javascript:window.location='${ctx}/standardDep/list?parentId=${ppId}&departmentName=${ppName}'">返 回</button>
		</c:if>
	
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get("${ctx}/standardDep/delete/"+id, function(json) {
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

function changeStat(standardDepartmentId,isEnabled){
	//转换地区启用禁用状态
	var parentId = '${parentId}';
	var departmentName = '${departmentName}';
	var ppId = '${ppId}';
	var ppName = '${ppName}';
	if(isEnabled==2){
		isEnabled=1;
	}else if(isEnabled==1){
		isEnabled=2;
	} 
	var change = standardDepartmentId+","+isEnabled;
	url="${ctx}/standardDep/list?parentId="+parentId+"&departmentName="+departmentName+"&change="+change+"&ppId="+ppId+"&ppName="+ppName;
	//alert(url);
	window.location.href=url;
	
}

function editNum(objOne,standardDepartmentId){
	var obj=objOne.parentNode;
	var sort = obj.parentNode.cells[3].childNodes[0].value;
	var url = ctx+"/standardDep/updateSort";
	$.post(url,{'standardDepartmentId':standardDepartmentId,'sort':sort},function (data){
		if(data.success){
			alert(data.message);
			window.location.reload();
		}
	});
	
}
</script>
</body>
</html>