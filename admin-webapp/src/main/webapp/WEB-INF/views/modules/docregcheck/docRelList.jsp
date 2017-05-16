<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>注册医生关联列表</title>
</head>

<body>
	<div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医生基本信息
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">姓名</th>
				<th class="text-center" width="8%">所在地区</th>
				<th class="text-center" width="12%">所在医院</th>
				<th class="text-center">所在科室</th>
				<th class="text-center">标准科室</th>
				<th class="text-center" width="6%">医生职称</th>
				<th class="text-center">医院分机</th>
				<th class="text-center">推荐码</th>
				<th class="text-center" width="12%">照片</th>
				<th class="text-center">申请时间</th>
			</thead>
			<tr>
				<td>${userDoctor.name}</td>
				<td>${userDoctor.areaName}</td>
				<td>${userDoctor.hospName}</td>
				<td>${userDoctor.deptName}</td>
				<td>${userDoctor.standDeptName}</td>
				<td>${userDoctor.gradeText}</td>
				<td>${userDoctor.telExt}</td>
				<td>${userDoctor.referralCode}</td>
				<td><c:forEach items="${fn:split(userDoctor.activeImgUrl, ',')}" var="imgUrl" varStatus="status1">
				<img src="${imgUrl}" id="img" width="50px" height="50px"  />
				</c:forEach>
				</td>
				<td><fmt:formatDate value="${userDoctor.createDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
		</table>
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 关联信息
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center" width="8%">姓名</th>
				<th class="text-center" width="15%">所在地区</th>
				<th class="text-center" width="15%">所在医院</th>
				<th class="text-center">所在科室</th>
				<th class="text-center">标准科室</th>
				<th class="text-center" width="10%">医生职称</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${qdlist}" var="list" varStatus="status">
			<tr>
				<td>${list.doctorName}</td>
				<td>${fn:replace(list.areaNamePath, "-", "")} </td>
				<td>${list.hospName}</td>
				<td>${list.departmentName}</td>
				<td>${list.standardDepartmentName}</td>
				<td>${list.doctorGradeText}</td>
				<td>
				<a href="#" del_id="${list.relId}">删除关联</a>&nbsp; 
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<form name="form" role="form" id="form1" name="form1" action="${ctx}/docregcheck/toAddRel" method="GET">
	<input id="userId" name="userId" type="hidden" value="${userDoctor.userId}"/>
	<input id="doctorName" name="doctorName" type="hidden" value="${userDoctor.name}"/>
	<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<span id="msg-info" style="margin-left:280px;"><button type="button" id="refuse" class="btn btn-primary" onclick="addRef()">添加关联</button></span>
			</div>
		</div>
	 </form>	
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	$(".table-bordered td a").bind("click", function(){
		var userId = "${userDoctor.userId}";
		if ($(this).attr('del_id')) {
			var relId = $(this).attr('del_id');
			$.confirm("确定要删除关联吗？删除后不可恢复！", function() {
				$.get("${ctx}/docregcheck/delete/"+relId+"/"+userId, function(json) {
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

function addRef(){
	//var userId = "${userDoctor.userId}";
	//var name = "${userDoctor.name}";
	//window.location.href="${ctx}/docregcheck/toAddRel?userId="+userId+"&doctorName="+name;
	this.form1.submit();
}

</script>
</body>
</html>