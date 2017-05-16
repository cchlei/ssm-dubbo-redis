<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生关联信息列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生关联信息列表</a></li>
	</ul>
	<div>
    <input id="departmentId" name="departmentId" type="hidden" value="${departmentId}"/>
	<%--  <input id="hospId" name="hospId" type="hidden" value="${hospId}"/> --%>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医生关联信息列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">姓名</th>
				<th class="text-center">是否启用</th>
				<th class="text-center" width="80px">排序</th>
				<th class="text-center">是否推荐</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${depList}" var="doctor" varStatus="status">
			<tr>
			<td class="text-center">${status.count}</td>
			<td>${doctor.doctorName}</td>
			<td>
				 <c:if test="${doctor.isEnabled==2}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${doctor.isEnabled==1}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${doctor.relId}','${doctor.isEnabled}','${doctor.doctorId}')">切换</button>
			</td>
			<td><input type="text" name="sort" id="sort" style="width:80px;" value="${doctor.sort}"/></td>
			<td>
			<select class="sSelect"  class="mSelect"  id="recommend" name="recommend">
				 <c:if test="${doctor.recommend==1}">
				 <option value="1" selected="selected">推荐</option>
				 <option value="2">不推荐</option>
				 </c:if>
				 <c:if test="${doctor.recommend==2}">
				 <option value="1">推荐</option>
				 <option value="2" selected="selected">不推荐</option>
				 </c:if>
			</select>
			</td>
			<td>
			<a href="#" onclick="editNum(this,'${doctor.relId}')">修改</a>
			&nbsp;<a href="#" del_id="${doctor.relId}" doc_id="${doctor.doctorId}" dep_id="${doctor.departmentId}">删除</a>
			</td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			var doctorId = $(this).attr('doc_id');
			var departmentId = $(this).attr('dep_id');
			var url = ctx+"/doctor/checkIfCanDo";
			//验证提示信息
			var msg = "";
			$.ajax({  
				type : "post",  
				url : url,  
				data : {'doctorId':doctorId,'departmentId':departmentId,'flag':2},  
				async : false,  
				asyncBoolean:false,
				success : function(data){  
					if(data.success){
						if(data.message==1){
							msg = "确定要删除此条数据吗？该医生相关号源已有客户预约还未就诊！";
						}else{
							msg = "确定要删除此条数据吗？删除后不可恢复！";
						}
					}
			    }
			});
			$.confirm(msg, function() {
				$.get("${ctx}/doctor/deleterel/"+id, function(json) {
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

function changeStat(doctorId,status,doctorId2){
	//转换医生启用禁用状态
	if(status==2){
		status=1;
	}else if(status==1){
		status=2;
	} 
	var change = doctorId+","+status;
	url="${ctx}/doctor/deplist?change="+change+"&departmentId="+$("#departmentId").val();
	//alert(url);
	if(status==2){
		//验证提示信息
		var url2 = ctx+"/doctor/checkIfCanDo";
		var departmentId = $("#departmentId").val();
				$.ajax({  
					type : "post",  
					url : url2,  
					data : {'doctorId':doctorId2,'departmentId':departmentId,'flag':2},  
					async : false,  
					asyncBoolean:false,
					success : function(data){  
						if(data.success){
							if(data.message==1){
								$.confirm("确定要禁用该医生吗？该医生相关号源已有客户预约还未就诊！", function() {
									window.location.href=url;
								});
							}else{
								window.location.href=url;
							}
						}
				    }
				});
	}else{
		window.location.href=url;
	}
	
}


function editNum(objOne,relId){
	var obj=objOne.parentNode;
	var sort = obj.parentNode.cells[3].childNodes[0].value;
	var recommend = obj.parentNode.cells[4].getElementsByTagName("select")[0].value;
	var url = ctx+"/doctor/updaterel";
	$.post(url,{'relId':relId,'sort':sort,'recommend':recommend},function (data){
		if(data.success){
			alert(data.message);
		}
	});
}

</script>
</body>
</html>