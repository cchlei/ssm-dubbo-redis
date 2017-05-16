<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生列表</title>
</head>
<body>
	<!-- <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生列表</a></li>
	</ul> -->
	<div>
	<form name="form" role="form" action="${ctx}/docregcheck/hospdoctorList" method="GET">
	<input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="areaName" name="areaName" type="hidden" value="${areaName}"/>
	<input id="areaNameParent" name="areaNameParent" type="hidden" value="${areaNameParent}"/>
	<input id="belongHospId" name="belongHospId" type="hidden" value="${belongHospId}"/>
	<input id="belongHospName" name="belongHospName" type="hidden" value="${belongHospName}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${departmentId}"/>
	<input id="departmentName" name="departmentName" type="hidden" value="${departmentName}"/>
	<input type="hidden" id="page" name="page" value="${page}"/>
	<c:if test="${belongHosp!='true'}">
	所在地： 
	<c:if test="${areaIdp!=null}">${areaMap[areaIdp]}</c:if>
	<c:if test="${areaIdp==null}">
	<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,this.options[this.selectedIndex].text,null)">
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
    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value,null,this.options[this.selectedIndex].text);">
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
    &nbsp;&nbsp;&nbsp;
    医院：<select class="lSelect"  class="lSelect"  id="hospital" name="hospital" onchange="searchDep(this,null,null)">
    <!--<c:if test="${hospId!=null}">
    	<option>${hospName}</option>
    </c:if>-->
    <c:if test="${belongHospId==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select><br/>
	</c:if>

	医院科室：<select class="mSelect"  class="mSelect"  id="hdParent" name="hdParent" onchange="searchHd(this,1,null,null)">
    <option value="0">请选择</option>
    </select>&nbsp;&nbsp;
    <!-- <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="searchHd(this.value,2);"> -->
    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="selectHd(this);">
   	<!--<c:if test="${departmentName!=null}">
    	<option>${departmentName}</option>
    </c:if>-->
    <c:if test="${departmentName==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select>&nbsp;&nbsp;
    <%-- <select class="mSelect"  class="mSelect"  id="hdChild2" name="hdChild2" onchange="selectHd(this.value);">
    </select>&nbsp;&nbsp; --%>
    <%-- <br/>医生名称：<input type="text"  id="doctorName" name="doctorName"  value="${doctorInfo.doctorName}"/>&nbsp;&nbsp;&nbsp; --%>
    &nbsp;&nbsp;  医生拼音：<input type="text"  id="nameSpell" name="nameSpell"  value="${doctorInfo.nameSpell}"/>&nbsp;&nbsp;&nbsp; 
	<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="#FF0000">*必须选择医院* </font>&nbsp;&nbsp;&nbsp; <a id="adddoc" href="${ctx}/docregcheck/edit2regdoc?areaId=&areaName=&hospId=&hospName=&deptId=&deptName=">添加</a>
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
				<th class="text-center">医生名称</th>
				<th class="text-center">科室名称</th>
				<th class="text-center">职称</th>
				<!-- <th class="text-center">标准科室</th> -->
				<th class="text-center">电话号码</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${doctorList}" var="doctor" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td style="word-break:break-all">${doctor.doctorName}</td>
				<td class="text-center">${doctor.departmentName}</td>
				<td>
				  <c:forEach items="${dicList}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==doctor.doctorGrade}">
				    	${dic.dictName}
				    </c:if>
				  </c:forEach></td>
							<%-- <td class="text-center"><select class="mSelect"
								class="mSelect" id="sdParent" name="sdParent"
								onchange="searchSd(this.value,1,null)">
									<option value="0">请选择</option>
									<c:forEach items="${sdList}" var="sd" varStatus="status">
										<c:if test="${sd.parentId==0}">
											<c:if test="${parDepartmentId==sd.standardDepartmentId}">
												<option value="${sd.standardDepartmentId}"
													selected="selected">${sd.departmentName}</option>
											</c:if>
											<c:if test="${parDepartmentId!=sd.standardDepartmentId}">
												<option value="${sd.standardDepartmentId}">${sd.departmentName}</option>
											</c:if>
										</c:if>
									</c:forEach>
							</select> <select class="mSelect" class="mSelect" id="sdChild1"
								name="sdChild1" onchange="searchSd(this.value,2,null);">
									<c:if test="${userDoctor.standDeptId==null}">
										<option>请选择</option>
									</c:if>
									<c:if test="${userDoctor.standDeptId!=null}">
										<option>${sdMap[userDoctor.standDeptId]}</option>
									</c:if>
							</select></td> 
							<td class="text-center"><input id="phone" type="text"
								placeholder="医生电话"
								datatype="/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/i"
								nullmsg="请输入医生电话！" errormsg="电话格式不正确！" value="${doctor.phone}"></td>--%>
							<td class="text-center">${doctor.phone}</td>
				<td>
						<%-- <c:if test="${doctor.userId==0}">
							<button type="button"  class="btn btn-primary" onclick="gotoDoccheck('${doctor.doctorId}','${doctor.doctorName}','${doctor.departmentId}','${doctor.departmentName}','${doctor.hospId}','${doctor.hospName}','${doctor.areaId}','${doctor.areaName}','${doctor.doctorGrade}','${doctor.doctorGradeText}','${doctor.doctorHeadImage}',this);">注册</button>
						</c:if>
						<c:if test="${doctor.userId!=0}">
							<button type="button" disabled class="btn">已注册</button>
						</c:if>
						&nbsp; --%>
						<a href="${ctx}/docregcheck/edit2regdoc?doctorId=${doctor.doctorId}">编辑</a>
				</td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
	
	<page:page pager="${page}" linkUrl="${ctx}/docregcheck/hospdoctorList?areaId=${params.areaId}&belongHospId=${params.belongHospId}&belongHospName=${params.belongHospName}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&hdParent=${params.hdParent}&hdChild1=${params.hdChild1}&nameSpell=${params.nameSpell}&areaIdParent=${params.areaIdParent}&areaIdChild=${params.areaIdChild}"/>
	
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//查询条件赋值
	var areaIdParent = "${areaIdParent}";
	var areaNameParent = "${areaNameParent}";
	var areaId = "${areaId}";
	var hospId = "${belongHospId}";
	var areaName = "${areaName}";
	var hospName = "${belongHospName}";
	var hdParent = "${hdParent}";
	var departmentId = "${departmentId}";
	var addhref = "${ctx}/docregcheck/edit2regdoc?"
		
	//$('#adddoc').attr('href',$('#adddoc').attr('href').replace(substring(str1.indexOf("areaId=")+1,str1.indexOf("&")), areaId)); 
	
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,areaNameParent,null);
		if(hospId!=""){
			searchHosp(areaIdParent,hospId);
			if(hdParent!=null){
				searchHd(null,1,hdParent,departmentId);
			}
		}else{
			searchHosp(areaIdParent,null);
		}
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		searchArea(areaIdParent,areaNameParent,areaId);
		if(hospId!=""){
			searchHosp(areaId,hospId,areaName);
			searchDep(null,hospId,hdParent);
			if(hdParent!=null){
				searchHd(null,1,hdParent,departmentId);
			}
		}else{
			searchHosp(areaId,null);
		}
	}
});


//地区下拉联动
function searchArea(areaId,areaNameParent,areaIdChild){
	if(areaId==0){
		return;
	}
	var url = "";
	var vip = $("#vip").val();
	if(vip==1){
		url = ctx + "/doctor/searchArea"; 
	}else{
		url = ctx + "/doctor/searchEnableArea";
	}
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
	 	searchHosp(areaId,null);//根据父级地区查询医院
	}
	 if(areaId!=0){
		$("#areaId").val(areaId);
	   	$("#areaIdParent").val(areaId);
	   	$("#areaNameParent").val(areaNameParent);
	 } 
	
}

//医院下拉联动
function searchHosp(areaId,hospId,areaName){
	//alert(hospId);
	if(areaId==0){
		return;
	}
	var url = "";
	var vip = $("#vip").val();
	if(vip==1){
		url = ctx + "/doctor/searchHosp"; 
	}else{
		url = ctx + "/doctor/searchEnableHosp";
	}
	$.ajax({  
		type : "post",  
		url : url,  
		data : {'areaId':areaId},  
		async : false,  
		asyncBoolean:false,
		success : function(data){  
			json = eval(data);
			  // 先清空第二个 
		      $("#hospital").empty(); 
		      var option = "";
		      option = $("<option>").val(0).text("请选择");
		      $("#hospital").append(option); 
		      //alert(hospId);
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
		   $("#areaName").val(areaName);
		   $('#adddoc').attr('href',$('#adddoc').attr('href').replace($('#adddoc').attr('href').substring($('#adddoc').attr('href').indexOf("areaId="),$('#adddoc').attr('href').indexOf("&areaName")), "areaId="+areaId)); 
		   $('#adddoc').attr('href',$('#adddoc').attr('href').replace($('#adddoc').attr('href').substring($('#adddoc').attr('href').indexOf("areaName="),$('#adddoc').attr('href').indexOf("&hospId")), "areaName="+areaName)); 
		 } 
	
}

//科室下拉联动
function searchDep(obj,hospId1,hdParent){
	var hospId = 0;
	var hospName = "";
	if(hospId1 != null){
		hospId = hospId1;
		hospName = "${belongHospName}";
	}else{
		hospId = obj.options[obj.selectedIndex].value;
		hospName = obj.options[obj.selectedIndex].text;
	}
	    
	if(hospId==0){
		return;
	}
	var url = "";
	var vip = $("#vip").val();
	if(vip==1){
		url = ctx + "/doctor/searchDep"; 
	}else{
		url = ctx + "/doctor/searchEnableDep";
	}
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
		   $("#belongHospId").val(hospId);
		   $("#belongHospName").val(hospName);
		   $('#adddoc').attr('href',$('#adddoc').attr('href').replace($('#adddoc').attr('href').substring($('#adddoc').attr('href').indexOf("hospId="),$('#adddoc').attr('href').indexOf("&hospName")), "hospId="+hospId)); 
		   $('#adddoc').attr('href',$('#adddoc').attr('href').replace($('#adddoc').attr('href').substring($('#adddoc').attr('href').indexOf("hospName="),$('#adddoc').attr('href').indexOf("&deptId")), "hospName="+hospName)); 
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
	var flag = "${flag}";
	if(flag=="sources"){
		$('#searchDoc').attr('disabled', true);
	}
	if(hdId==0){
		return;
	}
	var hospId = $("#belongHospId").val();
	var url = "";
	var vip = $("#vip").val();
	if(vip==1){
		url = ctx + "/doctor/searchHdDep"; 
	}else{
		url = ctx + "/doctor/searchEnableHdDep";
	}
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
			//console.log(departmentIdChild+"--"+json[i].departmentId);
			if(departmentIdChild!=null && departmentIdChild == json[i].departmentId){
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
			}
		    $(selPeram).append(option); 
		} 
	});
	 if(hdId!=0){
	   $("#departmentId").val(hdId);
	   $("#departmentName").val(hdName);
	   $('#adddoc').attr('href',$('#adddoc').attr('href').replace($('#adddoc').attr('href').substring($('#adddoc').attr('href').indexOf("deptId="),$('#adddoc').attr('href').indexOf("&deptName")),"deptId="+hdId)); 
	   $('#adddoc').attr('href',$('#adddoc').attr('href').replace($('#adddoc').attr('href').substring($('#adddoc').attr('href').indexOf("deptName="),$('#adddoc').attr('href').length),"deptName="+hdName)); 
	} 
	
} 
function selectHd(obj){
	var hdC = obj.options[obj.selectedIndex].value;
	var hdName = obj.options[obj.selectedIndex].text;
	if(hdC!=0){
		   $("#departmentId").val(hdC);
		   $("#departmentName").val(hdName);
		   $("#searchDoc").removeAttr("disabled");
		   $('#adddoc').attr('href',$('#adddoc').attr('href').replace($('#adddoc').attr('href').substring($('#adddoc').attr('href').indexOf("deptId="),$('#adddoc').attr('href').indexOf("&deptName")),"deptId="+hdC)); 
		   $('#adddoc').attr('href',$('#adddoc').attr('href').replace($('#adddoc').attr('href').substring($('#adddoc').attr('href').indexOf("deptName="),$('#adddoc').attr('href').length),"deptName="+hdName)); 
		}
}

function gotoDoccheck(regDoctorId,name,deptId,deptName,hospId,hospName,areaId,areaName,grade,gradeText,doctorHeadImage,objOne){
	var obj=objOne.parentNode;
	var phone = obj.parentNode.cells[4].childNodes[0].value;
	var url = "${ctx}/docregcheck/patdoc2regdoc";
 	$.post(url,{'areaId':areaId,'areaName':areaName,'hospId':hospId,'hospName':hospName,'deptId':deptId,'deptName':deptName,'regDoctorId':regDoctorId,'name':name,'phone':phone,'grade':grade,'gradeText':gradeText,'doctorHeadImage':doctorHeadImage},function (data){
			alert(data.message);
			window.location.reload();
	});
}



</script>
</body>
</html>