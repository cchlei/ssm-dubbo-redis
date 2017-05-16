<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>已审核用户管理列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">已审核用户管理列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/docregcheck/checkedDoctorList" method="GET">
	<input id ="onlineLengthSort" name="onlineLengthSort" type="hidden" value="${onlinelengthSort}">
	<input id="areaId" name="areaId" type="hidden" value="${params.areaId}"/>
	<input id="standDeptId" name="standDeptId" type="hidden" value="${params.standDeptId}"/>
	所在地：  
	<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null)">
    <option value="0">请选择</option>
    <c:forEach items="${areaList}" var="area" varStatus="status">
       <c:if test="${area.parentId==0}">
	    	<c:choose>
		       <c:when test="${params.areaIdParent!=null && params.areaIdParent==area.areaId}">
		       		<option value="${area.areaId}" selected="selected">${area.areaName}</option>
		       </c:when>
		       <c:otherwise>
			    	<option value="${area.areaId}">${area.areaName}</option>
			   </c:otherwise>
		   </c:choose> 	
	   </c:if>
    </c:forEach>
    </select>&nbsp;&nbsp;&nbsp;
   <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value,null);">
    <c:choose>
   	    <c:when test="${params.areaId!=null && params.areaId!='' &&params.areaId!=0 && params.areaId!=params.areaIdParent}">
    	<option>${areaMap[params.areaId]}</option>
	    </c:when>
	    <c:otherwise>
	   	    <option value="0">请选择</option>
	    </c:otherwise>
	</c:choose>
	</select>&nbsp;&nbsp;&nbsp;
	医院：<select class="lSelect"  class="lSelect"  id="hospId" name="hospId" onchange="selectHosp(this.value)">
    <c:if test="${params.hospId==null || params.hospId==''||params.hospId==0}">
    	<option value="">请选择</option>
    </c:if>
    </select><br/>
    标准科室：
    <select class="mSelect"  class="mSelect"  id="sdParent" name="sdParent" onchange="searchSd(this.value,1,null)">
    <option value="0">请选择</option>
    <c:forEach items="${sdList}" var="sd" varStatus="status">
       <c:if test="${sd.parentId==0}">
            <c:if test="${params.sdParent==sd.standardDepartmentId}">
	    		<option value="${sd.standardDepartmentId}" selected="selected">${sd.departmentName}</option>
	    	</c:if>
	    	<c:if test="${params.sdParent!=sd.standardDepartmentId}">
	    		<option value="${sd.standardDepartmentId}">${sd.departmentName}</option>
	    	</c:if>
	   </c:if>
    </c:forEach>
    </select>
     <select class="mSelect"  class="mSelect"  id="sdChild1" name="sdChild1" onchange="searchSd(this.value,2,null);">
        <c:if test="${params.standDeptId==null}">
   	    	<option>请选择</option>
   	    </c:if>
   	    <c:if test="${params.standDeptId!=null}">
    		<option>${sdMap[params.standDeptId]}</option>
    	</c:if>
    </select>
	<br/>
	职称：<select class="mSelect"  class="mSelect"  id="grade" name="grade">
	<option value="">请选择</option>
    <c:forEach items="${dicList}" var="dic" varStatus="status">
	    <c:if test="${dic.dictId==params.grade}">
	    	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
	    </c:if>
	    <c:if test="${dic.dictId!=params.grade}">
	    	<option value="${dic.dictId}" >${dic.dictName}</option>
	    </c:if>
    </c:forEach>
    </select>&nbsp;&nbsp;
    姓名：<input type="text"  id="name" name="name"   style="width:80px;" value="${params.name}"/>&nbsp;&nbsp;&nbsp;
    手机号：<input type="text"  id="phone" name="phone"   style="width:120px;" value="${params.phone}"/>&nbsp;&nbsp;&nbsp;
	<input type="submit" value="查询" onclick ="onlineLengthSubmit(0)"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="按今日时长排序" onclick ="onlineLengthSubmit(1)"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="按累计时长排序" onclick ="onlineLengthSubmit(2)"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 已审核用户管理列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<!-- <th class="text-center">用户名</th> -->
			    <th class="text-center">姓名</th>
				<th class="text-center" width="8%">所在地区</th>
				<th class="text-center" width="12%">所在医院</th>
				<th class="text-center">所在科室</th>
				<th class="text-center">标准科室</th>
				<th class="text-center" width="6%">医生职称</th>
				<th class="text-center">手机号</th>
				<th class="text-center">今日在线时长(分钟)</th>
				<th class="text-center">累计在线时长(分钟)</th>
				<th class="text-center">排序</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${userDocList}" var="list" varStatus="status">
			<tr>
			    <%-- <td>${list.auditUserName}</td> --%>
				<td>${list.name}</td>
				<td>${list.areaName}</td>
				<td>${list.hospName}</td>
				<td>${list.deptName}</td>
				<td>${list.standDeptName}</td>
				<td>${list.gradeText}</td>
				<td>${list.phone}</td>
				<c:if test="${list.onlineLength==null}">
				<td>0</td>
				</c:if>
				<c:if test="${list.onlineLength!=null}">
				<td>${list.onlineLength}</td>
				</c:if>
				<c:if test="${list.onlineLengthTotal==null}">
				<td>0</td>
				</c:if>
				<c:if test="${list.onlineLengthTotal!=null}">
				<td>${list.onlineLengthTotal}</td>
				</c:if>
 				<c:if test="${list.sort==null}">
					<td><input type="text" value="0" style="width:35px;" maxlength=4></td>
				</c:if>
			    <c:if test="${list.sort!=null}">
					<td><input type="text" value="${list.sort}" style="width:35px;" maxlength=4></td>
				</c:if> 
				
				<td>
				<a href="#" sort="${list.userId}">排序</a>&nbsp;&nbsp;
				<a href="${ctx}/docregcheck/toDetail?userId=${list.userId}&flag=1">查看</a>&nbsp;&nbsp;
				<a href="${ctx}/docregcheck/docRelList?userId=${list.userId}">关联</a>&nbsp;&nbsp;
				<a href="javascript:disable('${list.userId}','${list.name}')">禁用</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/docregcheck/checkedDoctorList?areaId=${params.areaId}&areaIdParent=${params.areaIdParent}&standDeptId=${params.standDeptId}&sdParent=${params.sdParent}&grade=${params.grade}&name=${params.name}&hospId=${params.hospId}&phone=${params.phone}&onlineLengthSort=${onlineLengthSort}"/>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//查询条件赋值
	var areaIdParent = "${params.areaIdParent}";
	var areaId = "${params.areaId}";
	var hospId = "${params.hospId}";
	var standDeptId = "${params.standDeptId}";
	var sdParent = "${params.sdParent}";
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,null);
		if(hospId!=""){
			searchHosp(areaIdParent,hospId);
			
		}else{
			searchHosp(areaIdParent,null);
		}
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		searchArea(areaIdParent,areaId);
		if(hospId!=""){
			searchHosp(areaId,hospId);
			
		}else{
			searchHosp(areaId,null);
		}
	}
	if(sdParent!="" && standDeptId!=""){
		searchSd(sdParent,1,standDeptId);
	}else if(sdParent!="" && standDeptId==""){
		searchSd(sdParent,1,null);
	}
	
	$(".table-bordered td a").bind("click", function(){
	 	if ($(this).attr('sort'))
	 	{
	 	    var userId = $(this).attr('sort');
			var sortNum = $(this).parent().parent().children('td').eq(9).find("input").val();
			var url = "${ctx}/docregcheck/updateSort";
			$.confirm("确定要修改排序值吗？", function() {
				$.post(url,{"userId":userId,"sortNum":sortNum},function (data){
					var msg = "";
					json =eval(data);
					if (json.success) {
							var msg = "";
							if (json.message) {
								msg = json.message;
							}
							$.alert(msg, function() {
								$("#onlineLengthSort").val(0);
								window.location.reload(true);
							});
					}else
					{
						$.alert(json.message);
					}
				}, "json"); 

			
			}); 
	 	}
	});
});

function disable(userId, docName){
	if(userId){
		$.confirm("确定要禁用 "+ docName +" 医生么?", function() {
			$.ajax({  
				type : "post",  
				url : ctx+"/docregcheck/disable",  
				data : {'userId':userId},  
				async : false,  
				asyncBoolean:false,
				success : function(data){  
					window.location.reload(true); 
				}  
		    });
		});
	}
}


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
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#areaIdChild").append(option); 
		} 
	});
	 searchHosp(areaId,null);//根据父级地区查询医院
	 if(areaId!=0){
	   $("#areaId").val(areaId);
	 } 
	
}

//医院下拉联动
function searchHosp(areaId,hospId){
	//alert(hospId);
	if(areaId==0){
		return;
	}
	var flag = "${params.flag}";
	if(flag!="sources"){
		flag="1";
	}else{
		flag="1";
	}
	var url = ctx+"/doctor/searchHosp";
	$.ajax({  
		type : "post",  
		url : url,  
		data : {'areaId':areaId,'flag':flag},  
		async : false,  
		asyncBoolean:false,
		success : function(data){  
			json = eval(data);
			  // 先清空第二个 
		      $("#hospId").empty(); 
		      var option = "";
		      option = $("<option>").val(0).text("请选择");
		      $("#hospId").append(option); 
			for(var i=0; i<json.length; i++) 
			{ 
				if(hospId!=null && hospId == json[i].hospId){
					option = $("<option>").val(json[i].hospId).text(json[i].hospName).prop("selected",true);
				}else{
					option = $("<option>").val(json[i].hospId).text(json[i].hospName);
				}
			    //alert(json[i].areaId+" " + json[i].areaName) 
			    $("#hospId").append(option); 
			} 
		}  
    });
	 
	 if(areaId!=0){
		   $("#areaId").val(areaId);
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
		$("#standDeptId").val(sdId);
	}
	if(sdId2!=0 && sdId2!=null && sdId2!=""){
		   $("#standDeptId").val(sdId2);
		}
	
	
} 

function onlineLengthSubmit(type)
{
	$("#onlineLengthSort").val(type);
	form.submit();
	
}

/* function selectArea(obj){
	var areaId = obj.options[obj.selectedIndex].value;
	if(areaId!=0){
		$("#areaId").val(areaId);
	}
} */
</script>
</body>
</html>