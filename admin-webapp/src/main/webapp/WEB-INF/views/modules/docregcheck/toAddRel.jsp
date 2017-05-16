<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>待关联医生列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">待关联医生列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/docregcheck/toAddRel" method="GET">
	<input id="userId" name="userId" type="hidden" value="${queryDoctor.userId}"/>
	<input id="areaId" name="areaId" type="hidden" value="${queryDoctor.areaId}"/>
	<input id="standardDepartmentId" name="standardDepartmentId" type="hidden" value="${queryDoctor.standardDepartmentId}"/>
	所在地：  
	<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null)">
    <option value="0">请选择</option>
    <c:forEach items="${areaList}" var="area" varStatus="status">
       <c:if test="${area.parentId==0}">
	    	<c:choose>
		       <c:when test="${areaIdParent!=null && areaIdParent==area.areaId}">
		       		<option value="${area.areaId}" selected="selected">${area.areaName}</option>
		       </c:when>
		       <c:otherwise>
			    	<option value="${area.areaId}">${area.areaName}</option>
			   </c:otherwise>
		   </c:choose> 	
	   </c:if>
    </c:forEach>
    </select>&nbsp;&nbsp;&nbsp;
    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="selectArea(this);">
    <c:choose>
   	    <c:when test="${queryDoctor.areaId!=null && queryDoctor.areaId!=areaIdParent}">
    	<option>${areaMap[queryDoctor.areaId]}</option>
	    </c:when>
	    <c:otherwise>
	   	    <option value="0">请选择</option>
	    </c:otherwise>
	</c:choose>
    </select>&nbsp;&nbsp;&nbsp;
    标准科室：
    <select class="mSelect"  class="mSelect"  id="sdParent" name="sdParent" onchange="searchSd(this.value,1,null)">
    <option value="0">请选择</option>
    <c:forEach items="${sdList}" var="sd" varStatus="status">
       <c:if test="${sd.parentId==0}">
            <c:if test="${sdParent==sd.standardDepartmentId}">
	    		<option value="${sd.standardDepartmentId}" selected="selected">${sd.departmentName}</option>
	    	</c:if>
	    	<c:if test="${sdParent!=sd.standardDepartmentId}">
	    		<option value="${sd.standardDepartmentId}">${sd.departmentName}</option>
	    	</c:if>
	   </c:if>
    </c:forEach>
    </select>
     <select class="mSelect"  class="mSelect"  id="sdChild1" name="sdChild1" onchange="searchSd(this.value,2,null);">
        <c:if test="${queryDoctor.standardDepartmentId==null}">
   	    	<option>请选择</option>
   	    </c:if>
   	    <c:if test="${queryDoctor.standardDepartmentId!=null}">
    		<option>${sdMap[queryDoctor.standardDepartmentId]}</option>
    	</c:if>
    </select>
	<br/>
	职称：<select class="mSelect"  id="doctorGrade" name="doctorGrade">
	<option value="">请选择</option>
    <c:forEach items="${dicList}" var="dic" varStatus="status">
	    <c:if test="${dic.dictId==queryDoctor.doctorGrade}">
	    	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
	    </c:if>
	    <c:if test="${dic.dictId!=queryDoctor.doctorGrade}">
	    	<option value="${dic.dictId}" >${dic.dictName}</option>
	    </c:if>
    </c:forEach>
    </select>&nbsp;&nbsp;
    姓名：<input type="text"  id="doctorName" name="doctorName"   style="width:80px;" value="${queryDoctor.doctorName}" readOnly="true"/>&nbsp;&nbsp;&nbsp;
	<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</form>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 待关联医生列表
			</h4>
		</div>
		<div id="selCon1">
		<form class="form-horizontal form-input" name="form2" id="form2" action="${ctx}/docregcheck/addRef" method="POST">
		<input  name="userId" type="hidden" value="${queryDoctor.userId}"/>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center" width="5%">全选<input type='checkbox'  onclick="selectAll(this,'selCon1')"></th>
			    <th class="text-center">姓名</th>
				<th class="text-center" width="8%">所在地区</th>
				<th class="text-center" width="12%">所在医院</th>
				<th class="text-center">所在科室</th>
				<th class="text-center">标准科室</th>
				<th class="text-center" width="6%">医生职称</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="list" varStatus="status">
			<tr>
			    <td class="text-center"><input type="checkbox" name="relIds" value="${list.relId}"/></td>
				<td>${list.doctorName}</td>
				<td>${fn:replace(list.areaNamePath, "-", "")} </td>
				<td>${list.hospName}</td>
				<td>${list.departmentName}</td>
				<td>${list.standardDepartmentName}</td>
				<td>${list.doctorGradeText}</td>
			</tr>
			</c:forEach>
		</table>
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<span id="msg-info" style="margin-left:280px;"><button type="button" class="btn btn-primary" onclick="addRelBut()">确定</button></span>
		</div>
	</div>
	</form>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//查询条件赋值
	var areaIdParent = "${areaIdParent}";
	var areaId = "${queryDoctor.areaId}";
	var standardDepartmentId = "${queryDoctor.standardDepartmentId}";
	var sdParent = "${sdParent}";
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,null);
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		searchArea(areaIdParent,areaId);
	}
	if(sdParent!="" && standardDepartmentId!=""){
		searchSd(sdParent,1,standardDepartmentId);
	}else if(sdParent!="" && standardDepartmentId==""){
		searchSd(sdParent,1,null);
	}
	
	
});

//地区下拉联动
function searchArea(areaId,areaIdChild){
	if(areaId==0){
		return;
	}
	var url = ctx+"/doctor/searchArea";
	$.post(url,{'areaId':areaId},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#areaIdChild").empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择");
	      $("#areaIdChild").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(areaIdChild!=null && areaIdChild == json[i].areaId){
				option = $("<option>").val(json[i].areaId).text(json[i].areaName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].areaId).text(json[i].areaName);
			}
		    $("#areaIdChild").append(option); 
		} 
	});
	 if(areaId!=0){
	   $("#areaId").val(areaId);
	 } 
	 if(areaIdChild!=""&&areaIdChild!=null){
		 $("#areaId").val(areaIdChild);
	 }
	
}

function searchSd(sdId,number,sdId2){
	var url = ctx+"/hospDep/searchSdDep";
	var selPeram = "";
	$.post(url,{'standardDepartmentId':sdId},function (data){
		json = eval(data);
		  if(number==1){
			  selPeram = "#sdChild1";
		  }else{
			  selPeram = "#sdChild2";
		  }
		  //添加前先清空
		  $(selPeram).empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择");
	      $(selPeram).append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(sdId2!=null && sdId2 == json[i].standardDepartmentId){
				option = $("<option>").val(json[i].standardDepartmentId).text(json[i].departmentName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].standardDepartmentId).text(json[i].departmentName);
			}
			
		    $(selPeram).append(option); 
		} 
	});
	if(number==2){//二级标准科室
		$("#standardDepartmentId").val(sdId);
	}
	if(sdId2!=0 && sdId2!=null && sdId2!=""){
		   $("#standardDepartmentId").val(sdId2);
		}
	
	
} 

function selectArea(obj){
	var areaId = obj.options[obj.selectedIndex].value;
	if(areaId!=0){
		$("#areaId").val(areaId);
	}
}

function addRelBut(){
	if(checkedNum()<1){
		alert("请勾选关联医生！");
		return;
	}else{
		//this.form2.submit();
		 var AjaxURL= "${ctx}/docregcheck/addRef";       
         //alert($('#form2').serialize());
             $.ajax({
                 type: "POST",
                 dataType: "json",
                 url: AjaxURL,
                 data: $('#form2').serialize(),
                 success: function (data) {
                     $.alert(data.message, function(){
                    	 var userId = "${queryDoctor.userId}";
         				window.location.href = '${ctx}/docregcheck/docRelList?userId='+userId;
         			});
                 },
                 error: function(data) {
                     alert("error:"+data.message);
                  }
             });
	}
	
}
//判断勾选的复选框个数
function checkedNum(){
	var checks = document.getElementsByName("relIds");
	n = 0;
	for(i=0;i<checks.length;i++){
		if(checks[i].checked)
			n++;
	}
	return n;
}
</script>
</body>
</html>