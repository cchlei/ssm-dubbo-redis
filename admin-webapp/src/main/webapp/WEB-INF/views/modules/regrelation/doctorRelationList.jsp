<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>注册医生列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生基本信息</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/regrelation/selectRelevanceDoctorInfoList" method="GET">
	<input type="hidden"  id="doctorRegisterId" name="doctorRegisterId"  value="${doctorRelation.doctorRegisterId}"/>
	姓名：<input type="text"  id="doctorRegisterName" name="doctorRegisterName"  value="${selectInfo.doctorRegisterName}"/>&nbsp;&nbsp;&nbsp;
	<select class="mSelect"  class="mSelect"  id="hospitalId" name ="hospitalId" onchange="searchDepartment(this.value,${doctorRelation.doctorRegisterId})">
	<option value=""></option>
	<c:forEach items="${hospitalList}" var="hospital" varStatus="status">
	       <option value="${hospital.hospId}">${hospital.hospName}</option>
	</c:forEach>
	</select>
	科室：
		<select class="mSelect"  class="mSelect"  id="departmentId" name ="departmentId" onchange="searchDepartmentTwo(this.value,${doctorRelation.doctorRegisterId})">
	    <option value=""></option>
	    <c:forEach items="${departmentList}" var="department" varStatus="status">
	    <option value="${department.departmentId}">${department.departmentName}</option>
	    </c:forEach>
	    </select>
	    
	    <select class="mSelect"  class="mSelect"  id="departmentTwoId" name ="departmentTwoId">
	    <option value=""></option>
	    <c:forEach items="${departmentTwoList}" var="departmentTwo" varStatus="status">
	    <option value="${departmentTwo.departmentId}">${departmentTwo.departmentName}</option>
	    </c:forEach>
	    </select>
	    
	    
	    
	  <input type="hidden" name="hospitalValue" id="hospitalValue" value="${selectInfo.hospitalId}">
	  <input type="hidden" name="departmentValue" id="departmentValue" value="${selectInfo.departmentId}"> 
	  <input type="hidden" name="departmentTwoValue" id="departmentTwoValue" value="${selectInfo.departmentTwoId}"> 
	&nbsp;&nbsp;&nbsp;<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</form>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>医生基本信息
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">姓名</th>
			    <th class="text-center">医院</th>
				<th class="text-center">科室</th>
				<th class="text-center">电话</th>
				<th class="text-center">邮件地址</th>
				<th class="text-center">执业证书</th>
				<th class="text-center">审核状态</th>
				<th class="text-center">关联状态</th>
			</tr>
			</thead>
			<tr>
				<td class="text-center">${doctorRelation.doctorRegisterName}</td>
				<td>${doctorRelation.hospital}</td>
				<td>${doctorRelation.department}</td>
				<td>${doctorRelation.phone}</td>
				<td>${doctorRelation.email}</td>
				<td class="text-center"><img src="${downFilePath}?path=${doctorRelation.certificateImg}" id="img1" width="50px" height="50px" onclick="showImgWindow('${doctorRelation.certificateImg}')"/></td>
				<td class="text-center"><span id ="statuesName" name="statuesName">${doctorRelation.statues}</span></td>
				<td class="text-center"><span id="relevanceName" name="relevanceName">${doctorRelation.isRelevance}</span></td> 
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
			    <th class="text-center">姓名</th>		    
			    <th class="text-center">医院</th>
				<th class="text-center">科室</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${doctorRelationList}" var="doctorInfo" varStatus="status">
			<tr>
			    <input type ="hidden" id ="doctorId" name ="doctorId" value="${doctorInfo.doctorId}">
				<td class="text-center">${doctorInfo.doctorName}</td>
				<td class="text-center">${doctorInfo.hospName}</td>
				<td class="text-center">${doctorInfo.departmentName}</td>
				<td class="text-center"><a href="javascript:relevance(${doctorInfo.doctorId},${doctorRelation.doctorRegisterId},1)">关联</a>&nbsp;&nbsp;&nbsp;</td>
			</tr>
			</c:forEach>
		</table>	
	</div>
<script type="text/javascript">
$(document).ready(function() {
	changeStatues();
	optionSelected();
	updateImg();
});
function changeStatues()
{
	
	$("span[name='statuesName']").each(function() {
		if($(this).text() == 0)
		{
			$(this).text('未审核');
		}else if($(this).text() == 1)
		{
			$(this).text('已通过');
		}else if($(this).text() == 2)
		{
			$(this).text('未通过');
		}	
	});
	$("span[name='relevanceName']").each(function() {
		if($(this).text() == 0)
		{
			$(this).text('未关联');
		}else if($(this).text() == 1)
		{
			$(this).text('已关联');
		}	
	});
	
}
function relevance(doctorId,doctorRegisterId,statues)
{
	var ctx = "${ctx}";
	var confirmStr ="确认关联该医生吗？";
	$.confirm(confirmStr, function() {
		$.get(ctx+"/regrelation/saveRelevanceDoctor",{'doctorId':doctorId,'doctorRegisterId':doctorRegisterId,'statues':statues}, 
				function(json)
				{
 			         var msg = "";
			         if (json.message) {
				         msg = json.message;
			         } 			       
			      
					 $.alert(msg, function() {
						       if(json.success)
						       {
						    	   window.location.href = ctx+'/regrelation/getRegisterDoctorInfoList';
						       }
					 }); 
			        
 
				}, "json");
	});
}
//医院下拉联动
function searchDepartment(hospId,doctorRegisterId){
	var ctx = "${ctx}";
	if(hospId==""){
		return;
	}
	var url = ctx+"/regrelation/searchDepartment";
	$.get(url,{'hospitalId':hospId,'doctorRegisterId':doctorRegisterId},function (data){
 		  json = eval(data);
	      $("#departmentId").empty(); 
	      $("#departmentTwoId").empty();
	      var option = "";
	      option = $("<option>").val(-1).text("");
	      $("#departmentId").append(option);
		for(var i=0; i<json.length; i++) 
		{ 
			option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#departmentId").append(option); 
		}  
	});
	
}
//科室下拉联动
function searchDepartmentTwo(departmentId,doctorRegisterId){
	var ctx = "${ctx}";
	if(departmentId==""){
		return;
	}
	var hospitalId =$("#hospitalId").val();
	var url = ctx+"/regrelation/searchDepartment";
	$.get(url,{'hospitalId':hospitalId,'departmentId':departmentId,'doctorRegisterId':doctorRegisterId},function (data){
 		  json = eval(data);
	      $("#departmentTwoId").empty(); 
	      var option = "";
	      option = $("<option>").val(-1).text("");
	      $("#departmentTwoId").append(option);
		for(var i=0; i<json.length; i++) 
		{ 
			option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#departmentTwoId").append(option); 
		}  
	});
	
}
function optionSelected()
{
	var hospitalValue =$("#hospitalValue").val();
	var departmentValue =$("#departmentValue").val();
	var departmentTwoValue=$("#departmentTwoValue").val();
	$("#hospitalId option[value='"+hospitalValue+"']").attr("selected", "selected");
	$("#departmentId option[value='"+departmentValue+"']").attr("selected", "selected");
	$("#departmentTwoId option[value='"+departmentTwoValue+"']").attr("selected", "selected");
}
function updateImg()
{
	//var downFilePath = $("#downFilePath").val();
	$("img").each(function() {
	   var src =$(this).attr("src");
	   var pathTemp =src.split("|");
	   var path =pathTemp[0];
	   $(this).attr("src",path);
	  // alert($(this).attr("src"));
	  // alert($("#img1")[0].src); 
	});
}
function showImgWindow(img)
{
	var ctx = "${ctx}";
	window.open (ctx+"/regrelation/toShowImg?img="+img , "_blank",
    "height=200,width=500,scrollbars=yes,location=no left=200 top=200");
}
</script>
</body>
</html>