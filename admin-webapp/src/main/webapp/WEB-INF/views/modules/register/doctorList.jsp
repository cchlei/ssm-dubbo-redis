<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生列表</title>
</head>
<body>
	<!-- <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生列表</a></li>
	</ul> -->
	<div>
	<form name="form" role="form" action="${ctx}/register/doctorList" method="GET">
	<input id="flag" name="flag" type="hidden" value="${flag}"/>
	<input id="vip" name="vip" type="hidden" value="${vip}"/>
	<c:if test="${flag=='sources'}">
	<input id="flag" name="flag" type="hidden" value="sources"/>
	</c:if>
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
	<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="#FF0000">*必须选择医院* </font>
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
				<th class="text-center">预约挂号数量</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${doctorList}" var="doctor" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td style="word-break:break-all">${doctor.doctorName} 
					<c:if test="${vip==3}"></br> ${doctor.specialtydesc}</c:if>
				</td>
				<td class="text-center">${doctor.departmentName}</td>
				<td>
				  <c:forEach items="${dicList}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==doctor.doctorGrade}">
				    	${dic.dictName}
				    </c:if>
				  </c:forEach></td>
				<td>${doctor.successfulRegisteredNum}
				<c:if test="${vip==3}">
					</br>
					<c:if test="${doctorSurplus[doctor.doctorId]!=null}">
						<c:forEach items="${doctorSurplus[doctor.doctorId]}" var="surplus" varStatus="status">
							${surplus.resourceTpyeText} 剩余  ${surplus.surplus} </br>
						</c:forEach>
					</c:if>
					<c:if test="${doctorSurplus[doctor.doctorId]==null || fn:length(doctorSurplus[doctor.doctorId])==0}">
						<c:if test="${doctor.isThirdparty==1}">无数据（第三方）</c:if>
						<c:if test="${doctor.isThirdparty!=1}">无号源</c:if>
					</c:if>
				</c:if>
				</td>
				<td>
				<c:if test="${flag==1}">
				<c:if test="${vip==1}">
				<a href="${ctx}/regrecord/recordlist?doctorId=${doctor.doctorId}&vip=${vip}">挂号记录</a>
				</c:if>
				<c:if test="${vip==0}">
				<a href="${ctx}/regrecord/recordlist?doctorId=${doctor.doctorId}">挂号记录</a>
				</c:if>
				</c:if>
				<c:if test="${flag==''||flag==null}">
					<c:if test="${vip==1}">
						<button type="button"  class="btn btn-primary" onclick="gotoResource('${doctor.doctorId}','${doctor.doctorName}','${doctor.departmentId}','${belongHospName}','${departmentName}');">预约</button>
					</c:if>
					<c:if test="${vip!=1}">
						<c:if test="${doctor.registrationType==1}">
							<button type="button"  class="btn btn-primary" onclick="gotoResource('${doctor.doctorId}','${doctor.doctorName}','${doctor.departmentId}','${belongHospName}','${departmentName}');">预约</button>
						</c:if>
						<c:if test="${doctor.registrationType==2}">
							<button type="button" disabled class="btn">约满</button>
						</c:if>
						<c:if test="${doctor.registrationType==3}">
							<button type="button" disabled class="btn">停诊</button>
						</c:if>
					</c:if>
				</c:if>
				
				</td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
	
	<page:page pager="${page}" linkUrl="${ctx}/register/doctorList?flag=${params.flag}&vip=${params.vip}&areaId=${params.areaId}&belongHospId=${params.belongHospId}&belongHospName=${params.belongHospName}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&hdParent=${params.hdParent}&hdChild1=${params.hdChild1}&nameSpell=${params.nameSpell}&areaIdParent=${params.areaIdParent}&areaIdChild=${params.areaIdChild}"/>
	
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//查询条件赋值
	var areaIdParent = "${areaIdParent}";
	var areaNameParent = "${areaNameParent}";
	var areaId = "${areaId}";
	var hospId = "${belongHospId}";
	var hdParent = "${hdParent}";
	var departmentId = "${departmentId}";
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,areaNameParent,null);
		if(hospId!=""){
			searchHosp(areaIdParent,hospId);
			searchDep(null,hospId,hdParent);
			if(hdParent!=null){
				searchHd(null,1,hdParent,departmentId);
			}
		}else{
			searchHosp(areaIdParent,null);
		}
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		searchArea(areaIdParent,areaNameParent,areaId);
		if(hospId!=""){
			searchHosp(areaId,hospId);
			searchDep(null,hospId,hdParent);
			if(hdParent!=null){
				searchHd(null,1,hdParent,departmentId);
			}
		}else{
			searchHosp(areaId,null);
		}
	}
});

function gotoResource(doctorId,doctorName,departmentId,hospName,departmentName){
	var hospId = $("#belongHospId").val();
	var vip = $("#vip").val();
	if(vip=="1" && typeof(vip)!="undefined"){
		window.location.href = ctx+'/register/vipResource?doctorId='+doctorId+'&doctorName='+doctorName+'&hospId='+hospId+'&hospName='+hospName+'&departmentName='+departmentName+'&departmentId='+departmentId+'&vip='+vip;
	}else if(vip=="2" && typeof(vip)!="undefined"){
		window.location.href = ctx+'/register/resourceList?doctorId='+doctorId+'&doctorName='+doctorName+'&hospId='+hospId+'&hospName='+hospName+'&departmentName='+departmentName+'&departmentId='+departmentId+'&vip='+vip;
	}else if(vip=="3" && typeof(vip)!="undefined"){
		window.location.href = ctx+'/register/resourceList?doctorId='+doctorId+'&doctorName='+doctorName+'&hospId='+hospId+'&hospName='+hospName+'&departmentName='+departmentName+'&departmentId='+departmentId+'&vip='+vip;
	}else if(vip=="4" && typeof(vip)!="undefined"){
		window.location.href = ctx+'/register/resourceList?doctorId='+doctorId+'&doctorName='+doctorName+'&hospId='+hospId+'&hospName='+hospName+'&departmentName='+departmentName+'&departmentId='+departmentId+'&vip='+vip;
	}else{
		window.location.href = ctx+'/register/resourceList?doctorId='+doctorId+'&doctorName='+doctorName+'&hospId='+hospId+'&hospName='+hospName+'&departmentName='+departmentName+'&departmentId='+departmentId+'&vip='+vip;	
	}
	
}

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
		 } 
	
}

//科室下拉联动
function searchDep(obj,hospId1,hdParent){
	var hospId = 0;
	var hospName = "";
	if(hospId1 != null){
		hospId = hospId1;
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
	} 
	
} 
function selectHd(obj){
	var hdC = obj.options[obj.selectedIndex].value;
	var hdName = obj.options[obj.selectedIndex].text;
	if(hdC!=0){
		   $("#departmentId").val(hdC);
		   $("#departmentName").val(hdName);
		   $("#searchDoc").removeAttr("disabled");
		}
}
</script>
</body>
</html>