<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生列表</title>
</head>

<body>
	<!-- <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生列表</a></li>
	</ul> -->
	<div>
	<form name="form" role="form" action="${ctx}/regrecord/doctorList" method="GET">
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${doctorInfo.departmentId}"/>
	<input id="departmentName" name="departmentName" type="hidden" value="${doctorInfo.departmentName}"/>
    姓名：<input type="text"  id="doctorName" name="doctorName"   style="width:80px;" value="${doctorInfo.doctorName}"/>&nbsp;&nbsp;&nbsp;
	医院科室：<select class="mSelect"  class="mSelect"  id="hdParent" name="hdParent" onchange="searchHd(this,1)">
    <option value="0">请选择</option>
    </select>&nbsp;&nbsp; 
    <!-- <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="searchHd(this.value,2);"> -->
    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="selectHd(this);">
   	<c:if test="${doctorInfo.departmentName!=null}">
    	<option>${doctorInfo.departmentName}</option>
    </c:if>
    <c:if test="${doctorInfo.departmentName==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select>&nbsp;&nbsp;
    <%-- <select class="mSelect"  class="mSelect"  id="hdChild2" name="hdChild2" onchange="selectHd(this.value);">
    </select>&nbsp;&nbsp; --%>
    <%-- <br/>医生名称：<input type="text"  id="doctorName" name="doctorName"  value="${doctorInfo.doctorName}"/>&nbsp;&nbsp;&nbsp; --%>
	<input type="button" id="searchDoc" onclick="subBut()" value="查询" /><span style="color:blue">(选择二级科室后查询按钮才可点击)</span>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医 生 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">所属科室</th>
				<th class="text-center">医生名称</th>
				<!-- <th class="text-center">职称</th> -->
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${doctorList}" var="doctor" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td>${depMap[doctor.departmentId]}</td>
				<td>${doctor.doctorName}</td>
				<%-- <td>
				  <c:forEach items="${dicList}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==doctor.doctorGrade}">
				    	${dic.dictName}
				    </c:if>
				  </c:forEach></td> --%>
				<td><a href="${ctx}/stopAndVisit/toAddorEdit?doctorId=${doctor.doctorId}&departmentId=${doctorInfo.departmentId}&hospId=${doctor.hospId}">停复诊管理</a></td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	var hospId="${hospId}";
	var hdParent = "${hdParent}";
	searchDep(hospId,hdParent);
	var departmentId = $("#departmentId").val();
	if(departmentId==""){
		$('#searchDoc').attr('disabled', true);
	}else{
		 $("#searchDoc").removeAttr("disabled");
	}

});


//科室下拉联动
function searchDep(hospId,hdParent){
	//var hospId = obj.options[obj.selectedIndex].value;
	//var hospName = obj.options[obj.selectedIndex].text;
	if(hospId==""){
		return;
	}
	var url = ctx+"/regrecord/searchDep";
	$.post(url,{'hospId':hospId},function (data){
		json = eval(data);
		   // 先清空第二个 
	      $("#hdParent").empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择");
	      $("#hdParent").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(hdParent!=null && hdParent == json[i].departmentId){
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
			}
			
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#hdParent").append(option); 
		}  
	});
	if(hospId!=0){
		   $("#hospId").val(hospId);
		  // $("#hospName").val(hospName);
		}

}

//二级科室下拉联动
function searchHd(obj,number){
	var hdId = obj.options[obj.selectedIndex].value;
	var hdName = obj.options[obj.selectedIndex].text;
	var departmentId = $("#departmentId").val();
	$('#searchDoc').attr('disabled', true);
	if(hdId==0){
		return;
	}
	var hospId = $("#hospId").val();
	var url = ctx+"/regrecord/searchHdDep";
	var selPeram = "";
	$.post(url,{'departmentId':hdId,'hospId':hospId},function (data){
		json = eval(data);
		  if(number==1){
			  selPeram = "#hdChild1";
		  }else{
			  selPeram = "#hdChild2";
		  }
		  //添加前先清空
		  $(selPeram).empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择");
	      $(selPeram).append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
		    $(selPeram).append(option); 
		} 
	});
	 if(hdId!=0){
	   $("#departmentId").val(hdId);
	   $("#departmentName").val(hdName);
	} 
	
} 
function selectHd(obj){
	var hdC = obj.options[obj.selectedIndex].value;
	var hdName = obj.options[obj.selectedIndex].text;
    $("#searchDoc").removeAttr("disabled");
	if(hdC!=0){
		   $("#departmentId").val(hdC);
		   $("#departmentName").val(hdName);
		}
}

function subBut(){
	var doctorName = $("#doctorName").val();
	$("#doctorName").val($.trim(doctorName));
	this.form.submit();
}
</script>
</body>
</html>