<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院科室编辑</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<%-- <li><a href="${ctx}/hospital/toAddorEdit?hospId=${hospId}">医院基本信息编辑</a></li>
		<li><a href="${ctx}/hospital/addClinic?hospId=${hospId}">挂号类型信息编辑</a></li> --%>
		<li class="active"><a href="${ctx}/hospDep/list?hospId=${hospId}">医院科室信息编辑</a></li>
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
	<form name="form" role="form" action="${ctx}/hospDep/list" method="GET">
	<input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	<input id="hospName" name="hospName" type="hidden" value="${hospName}"/>
	<input id="flag" name="flag" type="hidden" value="${flag}"/>
	<input id="standardDepartmentId" name="standardDepartmentId" type="hidden" value="${department.standardDepartmentId}"/>
	<input id="standardDepartmentName" name="standardDepartmentName" type="hidden" value="${standardDepartmentName}"/>
	<c:if test="${parentId==null}">
		<c:if test="${flag!='hierarchy'}">
			所在地：  
			<c:if test="${areaIdp!=null}">${areaMap[areaIdp]}</c:if>
			<c:if test="${areaIdp==null}">
				<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null,null)">
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
			    </select>
		    </c:if>
		    &nbsp;&nbsp;&nbsp;
		    <c:if test="${areaIdc!=null}">${areaMap[areaIdc]}</c:if>
			<c:if test="${areaIdc==null}">
		    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
		   	    <c:choose>
			   	    <c:when test="${areaId!=null && areaId!=areaIdParent}">
			    		<option>${areaMap[areaId]}</option>
				    </c:when>
				    <c:otherwise>
				   	    <option value="0">请选择</option>
				    </c:otherwise>
				</c:choose>
		    </select>
		    </c:if>
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   医院：<select class="lSelect"  class="lSelect"  id="hospital" name="hospital" data-edit-select="1" onchange="setHosp(this)">
				    <c:if test="${hospId==null}">
				    	<option value="0">请选择</option>
				    </c:if>
	    		</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    </c:if>
		<br/>科室名称：<input type="text"  id="departmentName" name="departmentName"  value="${department.departmentName}"/>&nbsp;&nbsp;&nbsp;
		排序：<input type="text"  id="sort" name="sort"  style="width:80px"  value="${hosDepInfo.sort}"/>&nbsp;&nbsp;&nbsp;
		<input 	type="submit" value="查询" />
		<button type="button" class="btn btn-primary" onclick="changeStat2('${dept.departmentId}','${dept.isEnabled}')">一键启用一级二级科室</button>
		<button type="button" class="btn btn-primary" onclick="changeStat3('${dept.departmentId}','${dept.isEnabled}')">一键禁用一级二级科室</button>
		<br/>
	    <a href="${ctx}/hospDep/toAddorEdit?hospId=${hospId}">添加一级科室</a>
    </c:if>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医 院 科 室 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">第三方编码</th>
				<th class="text-center">科室名称</th>
				<th class="text-center">简码</th>
				<th class="text-center">排序</th>
				<c:if test="${parentId!=null}">
				<th class="text-center">标准科室</th>
				</c:if>
				<th class="text-center">特色科室</th>
				<th class="text-center">成功挂号人数</th>
				<th class="text-center">状态</th>
				<th class="text-center">录入人名称</th>
				<th class="text-center">录入时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${deptList}" var="dept" varStatus="status">
			<tr>
				<%-- <td class="text-center">${status.count}</td> --%>
				<td>${dept.departmentCode}</td>
				<td>
				<a href="${ctx}/hospDep/list?parentId=${dept.departmentId}&departmentName=${dept.departmentName}&ppId=${parentId}&ppName=${departmentName}&hospId=${hospId}&flag=${flag}">${dept.departmentName}</a>
				</td>
				<td>${dept.brevityCode}</td>
				<td>${dept.sort}</td>
				<c:if test="${parentId!=null}">
				<td>${sdMap[dept.standardDepartmentId]}</td>
				</c:if>
				<td>
				<c:if test="${dept.isSpecial==1}">是</c:if>
				<c:if test="${dept.isSpecial==2}">否</c:if>
				</td>
				<td>${dept.successfulRegisteredNum}</td>
				<td>
				 <c:if test="${dept.isEnabled==2}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${dept.isEnabled==1}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${dept.departmentId}','${dept.isEnabled}')">切换</button>
				 </td>
				<td>${dept.creatorName}</td>
				<td><fmt:formatDate value="${dept.creationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
				<c:if test="${dept.parentId==0}">
				<a href="${ctx}/hospDep/toAddorEdit?departmentId=${dept.departmentId}&hospId=${hospId}&flag=${flag}">编辑</a>&nbsp;
				</c:if>
				<c:if test="${dept.parentId!=0}">
				<a href="${ctx}/hospDep/toAddorEdit?departmentId=${dept.departmentId}&hospId=${hospId}&flag=${flag}&departmentName=${dept.departmentName}">编辑</a>&nbsp;
				</c:if>
				<a href="#" del_id="${dept.departmentId}">删除</a>&nbsp;
				<c:if test="${departmentName==null}"> 
					<a href="${ctx}/hospDep/toAddorEdit?hospId=${hospId}&parentId=${dept.departmentId}&departmentName=${dept.departmentName}&isThirdparty=${dept.isThirdparty}">添加下级科室</a>&nbsp;
				</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	    <span>注：点击科室名称链接查看对应的下级科室</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <c:if test="${parentId!=null}">
			<button type="button" class="btn" onclick="javascript:window.location='${ctx}/hospDep/list?parentId=${ppId}&departmentName=${ppName}&hospId=${hospId}'">返 回</button>
		</c:if>
<script src="${ctxStatic}/js/hospSuggestion.js" type="text/javascript"></script>	
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	$.ajaxSetup({
		   async:false
 });
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get("${ctx}/hospDep/delete/"+id, function(json) {
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
	//查询条件赋值
	var areaIdParent = "${areaIdParent}";
	var areaId = "${areaId}";
	var hospId = "${hospId}";
	if(areaIdParent!="" && areaId==areaIdParent){
		if(hospId!=""){
			searchArea(areaIdParent,null,1);
			searchHosp(areaIdParent,hospId);
		}else{
			searchArea(areaIdParent,null,0);
			searchHosp(areaIdParent,null);
		}
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		if(hospId!=""){
			searchArea(areaIdParent,areaId,1);
			searchHosp(areaId,hospId);
		}else{
			searchArea(areaIdParent,areaId,0);
			searchHosp(areaId,null);
		}
	}
});

function changeStat(departmentId,status){
	//转换地区启用禁用状态
	var parentId = '${parentId}';
	var departmentName = '${departmentName}';
	var ppId = '${ppId}';
	var ppName = '${ppName}';
	if(status==2){
		status=1;
	}else if(status==1){
		status=2;
	} 
	var change = departmentId+","+status;
	url="${ctx}/hospDep/list?parentId="+parentId+"&departmentName="+departmentName+"&change="+change+"&ppId="+ppId+"&ppName="+ppName+"&hospId="+"${hospId}";
	//alert(url);
	window.location.href=url;
	
}
function changeStat2(hospId,status){
	//转换地区启用禁用状态
	var parentId = '${parentId}';
	var departmentName = '${departmentName}';
	var ppId = '${ppId}';
	var ppName = '${ppName}';
		status=1;
	var change = hospId+","+status;
	url="${ctx}/hospDep/list2?parentId="+parentId+"&departmentName="+departmentName+"&change="+change+"&ppId="+ppId+"&ppName="+ppName+"&hospId="+"${hospId}";
	//alert(url);
	window.location.href=url;
	
}
function changeStat3(hospId,status){
	//转换地区启用禁用状态
	var parentId = '${parentId}';
	var departmentName = '${departmentName}';
	var ppId = '${ppId}';
	var ppName = '${ppName}';
		status=2;
	var change = hospId+","+status;
	url="${ctx}/hospDep/list2?parentId="+parentId+"&departmentName="+departmentName+"&change="+change+"&ppId="+ppId+"&ppName="+ppName+"&hospId="+"${hospId}";
	//alert(url);
	window.location.href=url;
	
}
function searchSd(obj,number){
	var sdId = obj.options[obj.selectedIndex].value;
	var sdName = obj.options[obj.selectedIndex].text;
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
			option = $("<option>").val(json[i].standardDepartmentId).text(json[i].departmentName);
		    $(selPeram).append(option); 
		} 
	});
	if(sdId!=0){
	   $("#standardDepartmentId").val(sdId);
	   $("#standardDepartmentName").val(sdName);
	   
	}
	
} 

function selectSd(sdC){
	if(sdC!=0){
		   $("#standardDepartmentId").val(sdC);
		}
}


//地区下拉联动
function searchArea(areaId,areaIdChild,flag){
	if(areaId==0){
		return;
	}
	var url = ctx+"/hospDep/searchArea";
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
	if(areaIdChild==null){
		if(flag==0||flag==null){
			searchHosp(areaId);//根据父级地区查询医院
		}
	}
	 if(areaId!=0){
	   $("#areaId").val(areaId);
	 } 
	
}

//医院下拉联动
function searchHosp(areaId,hospId){
	if(areaId==0){
		var areaIdParent=$("#areaIdParent").val();
		searchArea(areaIdParent,null);
		return;
	}
	var url = ctx+"/hospDep/searchHosp";
	$.post(url,{'areaId':areaId},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#hospital").empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择");
	      $("#hospital").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(hospId!=null && hospId == json[i].hospId){
				option = $("<option>").val(json[i].hospId).text(json[i].hospName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].hospId).text(json[i].hospName);
			}
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#hospital").append(option); 
		} 
	});
	 if(areaId!=0){
		   $("#areaId").val(areaId);
		 } 
	 
		$(".m-input").remove();
	    var $select = $("select[data-edit-select]").filterSelect();
		$select.on("change", function(){
			    console.log(this.value)
	    });
	
}
function setHosp(obj){
	var hospId = obj.options[obj.selectedIndex].value;
	var hospName = obj.options[obj.selectedIndex].text;
	$("#hospId").val(hospId);
	$("#hospName").val(hospName);
}
</script>
</body>
</html>