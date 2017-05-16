<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生列表</title>
    <style>
        body,html{padding:0;margin:0;width:100%;height:100%;}
    </style>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生编辑</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/doctor/list" method="GET">
	<c:if test="${params.flag=='sources'}">
	<input id="flag" name="flag" type="hidden" value="sources"/>
	</c:if>
	<input id="areaId" name="areaId" type="hidden" value="${params.areaId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${params.hospId}"/>
	<%-- <input id="hospName" name="hospName" type="hidden" value="${hospName}"/> --%>
	<input id="departmentId" name="departmentId" type="hidden" value="${params.departmentId}"/>
	<input id="departmentName" name="departmentName" type="hidden" value="${params.departmentName}"/>
	<input id="standardDepartmentId" name="standardDepartmentId" type="hidden" value="${params.standardDepartmentId}"/>
	姓名：<input type="text"  id="doctorName" name="doctorName"   style="width:80px;" value="${doctorInfo.doctorName}"/>&nbsp;&nbsp;&nbsp;
	所在地：  
	<c:if test="${areaIdp!=null}">${areaMap[areaIdp]}</c:if>
	<c:if test="${areaIdp==null}">
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
    </select>
    </c:if>
    &nbsp;&nbsp;&nbsp;
    <c:if test="${areaIdc!=null}">${areaMap[areaIdc]}</c:if>
	<c:if test="${areaIdc==null}">	
    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
    <c:choose>
   	    <c:when test="${params.areaId!=null && params.areaId!=params.areaIdParent}">
    	<option>${areaMap[params.areaId]}</option>
	    </c:when>
	    <c:otherwise>
	   	    <option value="0">请选择</option>
	    </c:otherwise>
	</c:choose>
    </select>
    </c:if>
    &nbsp;&nbsp;&nbsp;
    医院：<select class="lSelect"  class="lSelect"  id="hospital" data-edit-select="1" name="hospital" onchange="searchDep(this,null,null)">
    <c:if test="${params.hospId==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select><br/> 仅显示开启科室 <input type="checkbox" name="checkbox" id="depCheckbox">&nbsp;&nbsp;
	医院科室：<select class="mSelect"  class="mSelect"  id="hdParent" name="hdParent" onchange="searchHd(this,1,null,null)">
    <option value="0">请选择</option>
    </select>&nbsp;&nbsp;
    <!-- <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="searchHd(this.value,2);"> -->
    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="selectHd(this);">
    <c:if test="${params.departmentId==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select>&nbsp;&nbsp;
	是否是专科医生：<select class="sSelect"  class="sSelect"  id="isSpecialized" name="isSpecialized">
				 <c:if test="${doctorInfo.isSpecialized==null||doctorInfo.isSpecialized==''}">
				 <option value="">请选择</option>
				 <option value="1">是</option>
				 <option value="2">否</option>
				 </c:if>
				 <c:if test="${doctorInfo.isSpecialized==1}">
				 <option value="">请选择</option>
				 <option value="1" selected="selected">是</option>
				 <option value="2">否</option>
				 </c:if>
				 <c:if test="${doctorInfo.isSpecialized==2}">
				 <option value="">请选择</option>
				 <option value="1">是</option>
				 <option value="2" selected="selected">否</option>
				 </c:if>
				</select>&nbsp;&nbsp;&nbsp;<br/>
	职称：<select class="mSelect"  class="mSelect"  id="doctorGrade" name="doctorGrade">
				<option value="">请选择</option>
			    <c:forEach items="${dicList}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==doctorInfo.doctorGrade}">
				    	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
				    </c:if>
				    <c:if test="${dic.dictId!=doctorInfo.doctorGrade}">
				    	<option value="${dic.dictId}" >${dic.dictName}</option>
				    </c:if>
			    </c:forEach>
		    </select>&nbsp;&nbsp;
	<c:if test="${params.flag=='sources'}">
	<input type="button" onclick="subBut()" id="searchDoc" value="查询"/><br/><span style="color:blue">(选择二级科室后查询按钮才可点击)</span>
	</c:if>
	<c:if test="${params.flag!='sources'}">
	<input type="button" onclick="subBut()"  value="查询" />&nbsp;&nbsp;
    <a href="${ctx}/doctor/toAddorEdit?hospId=${params.hospId}&departmentId=${params.departmentId}&standardDepartmentId=${params.standardDepartmentId}">添加医生</a>
    </c:if>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医 生 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<th class="text-center" width="60px">姓名</th>
				<th class="text-center">医院</th>
				<th class="text-center" width="80px">科室</th>
				<th class="text-center">是否是专科医生</th>
				<th class="text-center">职称</th>
				<th class="text-center">患者数</th>
				<c:if test="${params.flag!='sources'}">
				<th class="text-center">创建人</th>
				<th class="text-center">创建时间</th>
				</c:if>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${doctorList}" var="doctor" varStatus="status">
			<tr>
			   <c:if test="${params.flag=='sources'}">
			   <!-- 号源下的医生列表不包含第三方医生 -->
			   <%-- <c:if test="${doctor.isThirdparty=='2'}">  --%>
				<td>${doctor.doctorName}</td>
				<td>${doctor.hospName}</td>
				<td>${doctor.departmentName}</td>
				<td>
				<c:if test="${doctor.isSpecialized==1}">是</c:if>
				<c:if test="${doctor.isSpecialized==2}">否</c:if>
				</td>
				<td>
				  <c:forEach items="${dicList}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==doctor.doctorGrade}">
				    	${dic.dictName}
				    </c:if>
				  </c:forEach></td>
				<td>${doctor.successfulRegisteredNum}</td>
				<c:if test="${params.flag!='sources'}">
				<td>${doctor.operatorName}</td>
				<td><fmt:formatDate value="${doctor.operationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</c:if>
				<c:if test="${params.flag!='sources'}">
				<td><a href="${ctx}/doctor/toAddorEdit?doctorId=${doctor.doctorId}&hospId=${params.hospId}&departmentId=${params.departmentId}&standardDepartmentId=${params.standardDepartmentId}">修改</a>&nbsp;
				<a href="#" del_id="${doctor.doctorId}">删除</a></td>
				</c:if>
				<c:if test="${params.flag=='sources'}">
				<td style="text-align:center;width:300px;">
				<c:if test="${doctor.isThirdparty=='2'}"> 
					<a href="${ctx}/sources/toAddorEdit?doctorId=${doctor.doctorId}&hospId=${doctor.hospId}&departmentId=${doctor.departmentId}&doctorName=${doctor.doctorName}&departmentName=${doctor.departmentName}&resourceReservedNum=${doctor.resourceReservedNum}">编辑号源模板</a>&nbsp;&nbsp;&nbsp;
					<a href="${ctx}/sourcesDet/list?doctorId=${doctor.doctorId}&doctorName=${doctor.doctorName}&hospId=${doctor.hospId}&departmentId=${doctor.departmentId}">编辑号源</a>&nbsp;&nbsp;&nbsp;
					<%-- <a href="${ctx}/stopAndVisit/toAddorEdit">停复诊记录</a>&nbsp;&nbsp;&nbsp; --%>
					<a href="${ctx}/stopAndVisit/toAddorEdit?doctorId=${doctor.doctorId}&departmentId=${doctor.departmentId}&hospId=${doctor.hospId}">停复诊管理</a>
				</c:if>
				<c:if test="${doctor.isThirdparty!='2'}"> 
						<a href="${ctx}/sourcesDet/list?doctorId=${doctor.doctorId}&doctorName=${doctor.doctorName}&hospId=${doctor.hospId}&departmentId=${doctor.departmentId}&isThirdpartyFlag=1">查看号源</a>&nbsp;&nbsp;&nbsp;
				</c:if>
					</td>
				</td>
				</td>
				</c:if>
				
				<%-- </c:if> --%>
			    </c:if> 
			    
			    <c:if test="${params.flag!='sources'}">
				<td>${doctor.doctorName}</td>
				<td>${doctor.hospName}</td>
				<td>${doctor.departmentName}</td>
				<td>
				<c:if test="${doctor.isSpecialized==1}">是</c:if>
				<c:if test="${doctor.isSpecialized==2}">否</c:if>
				</td>
				<td>
				  <c:forEach items="${dicList}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==doctor.doctorGrade}">
				    	${dic.dictName}
				    </c:if>
				  </c:forEach></td>
				<td>${doctor.successfulRegisteredNum}</td>
				<c:if test="${params.flag!='sources'}">
				<td>${doctor.operatorName}</td>
				<td><fmt:formatDate value="${doctor.operationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</c:if>
				<c:if test="${params.flag!='sources'}">
				<td><a href="${ctx}/doctor/toAddorEdit?doctorId=${doctor.doctorId}&hospId=${params.hospId}&departmentId=${params.departmentId}&standardDepartmentId=${params.standardDepartmentId}">修改</a>&nbsp;
				<a href="#" del_id="${doctor.doctorId}">删除</a></td>
				</c:if>
				<c:if test="${params.flag=='sources'}">
				<td style="text-align:center;width:300px;"><a href="${ctx}/sources/toAddorEdit?doctorId=${doctor.doctorId}&hospId=${doctor.hospId}&departmentId=${doctor.departmentId}">编辑号源模板</a>&nbsp;&nbsp;&nbsp;
				<a href="${ctx}/sourcesDet/list?doctorId=${doctor.doctorId}&doctorName=${doctor.doctorName}&hospId=${doctor.hospId}&departmentId=${doctor.departmentId}">编辑号源</a>&nbsp;&nbsp;&nbsp;
				<%-- <a href="${ctx}/stopAndVisit/toAddorEdit">停复诊记录</a>&nbsp;&nbsp;&nbsp; --%>
				<a href="${ctx}/stopAndVisit/toAddorEdit?doctorId=${doctor.doctorId}&departmentId=${doctor.departmentId}">停复诊管理</a>
				</td>
				</c:if>
			    </c:if> 
			</tr>
			</c:forEach>
		</table>
		
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/doctor/list?areaId=${params.areaId}&areaIdParent=${params.areaIdParent}&flag=${params.flag}&hospId=${params.hospId}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&standardDepartmentId=${params.standardDepartmentId}&hdParent=${params.hdParent}&isSpecialized=${params.isSpecialized}&doctorGrade=${params.doctorGrade}&doctorName=${params.doctorName}"/>
<script src="${ctxStatic}/js/hospSuggestion.js" type="text/javascript"></script>
<script type="text/javascript">

/**
 * by da宗熊
 *  一次性插件，不提供删除操作
 * @example:
 *  $("select").filterSelect({blurClear: 离开自动清空内容?, focusClear: 聚焦自动清空?});
 *  $("select").on("change", fn); 监听回调
 *  通过 $("select").val() 拿到最新的值
 *  通过 $("select").trigger("setEditSelectValue", 2); 设置选中的值为 2
 *  通过 $("select").trigger("optionChange", updateInputValue?) 触发 更新 option 的值
*/


var ctx = "${ctx}";
$(document).ready(function() {
	$.ajaxSetup({
		   async:false
    });
	
	var flag = "${params.flag}";
	if(flag=="sources"){
		var departmentId = $("#departmentId").val();
		if(departmentId==""){
			$('#searchDoc').attr('disabled', true);
		}else{
			 $("#searchDoc").removeAttr("disabled");
		}
		
	}
	//查询条件赋值
	var areaIdParent = "${params.areaIdParent}";
	var areaId = "${params.areaId}";
	var hospId = "${params.hospId}";
	var hdParent = "${params.hdParent}";
	var departmentId = "${params.departmentId}";
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,null);
		if(hospId!=""){
			searchHosp(areaIdParent,hospId);
			searchDep(null,hospId,hdParent);
			if(hdParent!=null && hdParent!=departmentId){
				searchHd(null,1,hdParent,departmentId);
				$("#departmentId").val(departmentId);
			}else{
				searchHd(null,1,hdParent,departmentId);
				$("#departmentId").val(departmentId);
			}
		}else{
			searchHosp(areaIdParent,null);
		}
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		searchArea(areaIdParent,areaId);
		if(hospId!=""){
			searchHosp(areaId,hospId);
			searchDep(null,hospId,hdParent);
			if(hdParent!=null && hdParent!=departmentId){
				searchHd(null,1,hdParent,departmentId);
				$("#departmentId").val(departmentId);
			}else{
				searchHd(null,1,hdParent,departmentId);
				$("#departmentId").val(departmentId);
			}
		}else{
			searchHosp(areaId,null);
		}
	}
	if(flag=='sources' && departmentId!=null && hdParent!=departmentId){
		$("#searchDoc").removeAttr("disabled");
	}
	
	
	$(".table-bordered td a").bind("click", function(){
	 if ($(this).attr('del_id')) {
		var id = $(this).attr('del_id');
		//验证提示信息
		var msg = "";
		var url = ctx+"/doctor/checkIfCanDo";
			$.ajax({  
				type : "post",  
				url : url,  
				data : {'doctorId':id,'flag':1},  
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
				$.get("${ctx}/doctor/delete/"+id, function(json) {
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

function changeStat(doctorId,status){
	//转换地区启用禁用状态
	if(status==2){
		status=1;
	}else if(status==1){
		status=2;
	} 
	var change = doctorId+","+status;
	url="${ctx}/doctor/list?change="+change;
	//alert(url);
	window.location.href=url;
	
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

	
}

//医院下拉联动
function searchHosp(areaId,hospId){
	//alert(hospId);
	if(areaId==0){
		var areaIdParent=$("#areaIdParent").val();
		searchArea(areaIdParent,null);
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
		}  
    });
	
	 if(areaId!=0){
		   $("#areaId").val(areaId);
		 } 
	 if(areaId!=0){
		   $("#areaId").val(areaId);
		 }
	$(".m-input").remove();
	var h =$("#hospId").val();
    var $select = $("select[data-edit-select]").filterSelect();
	$select.on("change", function(){
		    console.log(this.value)
    });

}

//科室下拉联动
function searchDep(obj,hospId1,hdParent){
	var hospId = 0;
	//var hospName = "";
	if(hospId1 != null){
		hospId = hospId1;
	}else{
		hospId = obj.options[obj.selectedIndex].value;
		//hospName = obj.options[obj.selectedIndex].text;
	}
	    
	if(hospId==0){
		return;
	}
	var url = ctx+"/doctor/searchDep";
	var depFlag =  $("#depCheckbox").is(":checked");
	$.post(url,{'hospId':hospId,"depFlag":depFlag},function (data){
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
		   //$("#hospName").val(hospName);
		}

}

//二级科室下拉联动
function searchHd(obj,number,departmentId,departmentIdChild){
	var hdId = 0;
	var hdName ="";
	if(departmentId!=null){
		hdId = departmentId;
	}else{
		hdId = obj.options[obj.selectedIndex].value;
		hdName = obj.options[obj.selectedIndex].text;
	}	
	var flag = "${params.flag}";
	if(flag=="sources"){
		$('#searchDoc').attr('disabled', true);
	}
	if(hdId==0){
		return;
	}
	var hospId = $("#hospId").val();
	var url = ctx+"/doctor/searchHdDep";
	var depFlag =  $("#depCheckbox").is(":checked");
	var selPeram = "";
	$.post(url,{'departmentId':hdId,'hospId':hospId,"depFlag":depFlag},function (data){
		json = eval(data);
		  if(number==1){
			  selPeram = "#hdChild1";
		  }else{
			  selPeram = "#hdChild2";
		  }
		  //添加前先清空
		  $(selPeram).empty(); 
	      var option = "";
	      option = $("<option>").val("").text("请选择");
	      $(selPeram).append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			//console.log(departmentIdChild+"--"+json[i].departmentId);
			if(flag=="sources"){//号源编辑医生列表页不查出没关联二级科室的医院科室
					if(departmentIdChild!=null && departmentIdChild == json[i].departmentId){
						option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).prop("selected",true);
					}else{
						option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
					}
			    //}
			}else{
				if(departmentIdChild!=null && departmentIdChild == json[i].departmentId){
					option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).prop("selected",true);
				}else{
					option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
				}
			}
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
	if(hdC==null || hdC==""){
		$("#searchDoc").attr("disabled","true");
	}
	if(hdC!=0){
		   $("#departmentId").val(hdC);
		   $("#departmentName").val(hdName);
		   $("#searchDoc").removeAttr("disabled");
		}
}

function subBut(){
	var doctorName = $("#doctorName").val();
	$("#doctorName").val($.trim(doctorName));
	this.form.submit();
}

//仅显示开启科室
$("#depCheckbox").click(function(){
	searchDep($("#hospital"),$("#hospital").val(),null);
	$("#hdChild1").html("<option>请选择</option>");
});

</script>


</body>
</html>