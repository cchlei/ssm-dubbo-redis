<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>统计管理</title>
</head>
<body>
	<form name="form" role="form" action="${ctx}/statisResource/list" method="GET">
    <input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	<input id="doctorId2" name="doctorId2" type="hidden" value="${resource.doctorId}"/>
    <input type="hidden" id="page" name="page" value="${page}"/>
      渠道类型：<select class="mSelect"  class="mSelect"  id="isGuide" name="isGuide">
	    <option value="">请选择</option>
		<option value="1">手机APP挂号</option>
		<!-- <option value="2">第三方挂号</option> -->
		<option value="3">客服人工挂号</option>
		<option value="4">VIP挂号类型挂号</option>
		<option value="5">现场挂号</option>
		<!-- <option value="6">电话挂号</option> -->
		<option value="7">行业项目挂号</option>
		<option value="8">医院web端挂号</option>
		<option value="12">合作医院</option>
	</select>
	所在地：<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null)">
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
	    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
	    <c:choose>
	   	    <c:when test="${areaId!=null && areaId!=areaIdParent}">
	    	<option>${areaMap[areaId]}</option>
		    </c:when>
		    <c:otherwise>
		   	    <option value="0">请选择</option>
		    </c:otherwise>
		</c:choose>
	    </select>&nbsp;&nbsp;&nbsp;
	         医院：<select class="mSelect"  class="lSelect"  id="hospital" name="hospital" onchange="searchDep(this,null,null)">
			  <%--  <c:if test="${hospId!=null}">
			    	<option>${hospId}</option>
			    </c:if>
			    <c:if test="${resource.hospId!=null}">
			    	<option value="0">请选择</option>
			    </c:if> --%>
	   		</select>    
    <br/> 
	医院科室：<select class="mSelect"  class="mSelect"  id="hdParent" name="hdParent" onchange="searchHd(this,1,null,null,1)">
    			<option value="0">请选择</option>
   			</select>&nbsp;&nbsp;   
    	    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="selectHd(this);" >
			    <c:if test="${resource.standardDepartmentId==null}">
			    	<option value="0">请选择</option>
			    </c:if>
    		</select>&nbsp;&nbsp;
         医生：<select class="mSelect"  class="mSelect"  id="doctorId" name="doctorId">
		     <c:if test="${resource.doctorId==null}">
		    	<option value="">请选择</option>
		     </c:if>
	    </select>
	    <br/>
	<!--  开始日期：<input class="Wdate" type="text" name="timespanStart" id="timespanStart"  style="width:120px;" value="" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'timespanStart\')}'})">--  
	 截止日期：<input class="Wdate" type="text" name="timespanEnd" id="timespanEnd"  style="width:120px;"  value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'timespanEnd\')}'})"> -->
	开始日期： <input type="text" id="timespanStart" name="timespanStart" value="${timespanStart}" onfocus="WdatePicker({dateFmt:'H:mm:00',minDate:'00:00:00',maxDate:'23:30:00'})" class="Wdate"/>
	截止日期： <input type="text" id="timespanEnd" name="timespanEnd" value="${timespanEnd}" onfocus="WdatePicker({dateFmt:'H:mm:00',minDate:'00:00:00',maxDate:'23:30:00'})" class="Wdate"/>
	
    <%--挂号日期： <input class="Wdate" type="text" name="registration" id="registration"  value="<fmt:formatDate value="${registrationRecord.registrationDate}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;--%>     
    <input type="submit" id="searchDoc" value="查询"/>
    </form>
     <div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 基础信息列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter table2">
			<thead>
			<tr>
			    <th class="text-center">医院名称</th>
				<th class="text-center">科室名称</th>
				<th class="text-center">医生</th>
				<th class="text-center" style="width:30px;">性别</th>
				<th class="text-center">挂号费用</th>
				<th class="text-center">号源数量</th>
				<th class="text-center">已挂号数量</th>
				<th class="text-center">已爽约数量</th>
				<th class="text-center">时段开始</th>
				<th class="text-center">时段结束</th>
			</tr>
			</thead>
			<c:forEach items="${resourceList}" var="resource" varStatus="status">
			<tr>
				<td>${resource.hospName}</td>
				<td>${resource.departmentName}</td>
				<td>${resource.doctorName}</td>
				<td>
					<c:if test="${resource.doctorSex==1}">男</c:if>
					<c:if test="${resource.doctorSex==2}">女</c:if>
				</td>
				<td>${resource.expense}</td>
				<td>${resource.resourceNum}</td>
				<td>${resource.issuedResourceNum}</td>
				<td>${resource.countIsGuide}</td>
				<td>
					<fmt:formatDate value="${resource.timespanStart}" pattern="HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${resource.timespanEnd}" pattern="HH:mm:ss"/>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/statisResource/list?hospId=${params.hospId}&isGuide=${params.isGuide}&areaId=${params.areaId}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&areaIdParent=${params.areaIdParent}&areaIdChild=${params.areaIdChild}&hospital=${params.hospital}&hdParent=${params.hdParent}&hdChild1=${params.hdChild1}"/>	
	
<%-- 	<page:page pager="${page}" linkUrl="${ctx}/statisResource/list?hospId=${params.hospId}
&areaId=${params.areaId}
&departmentId=${params.departmentId}
&departmentName=${params.departmentName}
&areaIdParent=${params.areaIdParent}
&areaIdChild=${params.areaIdChild}
&hdParent=${params.hdParent}
&hdChild1=${params.hdChild1}
&doctorId=${params.doctorId} 
	--%>
   <div></div> 
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//查询条件赋值
	if("${isGuide}"!=""){
		$("#isGuide").val("${isGuide}");
	}
	
	var areaIdParent = "${areaIdParent}";
	var areaId = "${areaId}";
	var hospId = "${resource.hospId}";
	var hdParent = "${hdParent}";
	var departmentId = "${resource.departmentId}";
	var doctorId = "${resource.doctorId}";
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,null);
		if(hospId!=""){
			searchHosp(areaIdParent,hospId);
			searchDep(null,hospId,hdParent);
			//alert(hdParent+"--"+departmentId);
			if(hdParent!=null && hdParent!=departmentId){
				searchHd(null,1,hdParent,departmentId,null);
				$("#departmentId").val(departmentId);
				searchDoctor(departmentId,doctorId);
			}else{
				searchHd(null,1,departmentId,departmentId,null);
				$("#departmentId").val(departmentId);
				searchDoctor(departmentId,doctorId);
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
				searchHd(null,1,hdParent,departmentId,null);
				$("#departmentId").val(departmentId);
				searchDoctor(departmentId,doctorId);
			}
		}else{
			searchHosp(areaId,null);
		}
	}
	if("${resource.doctorId}"!=""){
		$("#doctorId").val("${resource.doctorId}");
	}
	if("${hospId}"!=""){
		$("#hospital").val("${hospId}");
 	}
	if("${resource.departmentId}"!=""){
		$("#hdParent").val("${resource.departmentId}");
	}
	if("${resource.standardDepartmentId}"!=""){
		$("#hdChild1").val("${resource.standardDepartmentId}");
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
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#areaIdChild").append(option); 
		} 
	});
	if(areaIdChild==null){
		searchHosp(areaId,null);//根据父级地区查询医院
	}
	 
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
	var url = ctx+"/regrecord/searchHosp";
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
	 }
	
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
		$("#hospId").val("");
		return;
	}
	var url = ctx+"/regrecord/searchDep";
	$.post(url,{'hospId':hospId},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#hdParent").empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择").prop("selected",true);
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
function searchHd(obj,number,departmentId,departmentIdChild,ifFlag){
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
		 $("#departmentId").val(null);
		return;
	}
	var hospId = $("#hospId").val();
	var url = ctx+"/doctor/searchHdDep";
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
	      option = $("<option>").val("").text("请选择");
	      $(selPeram).append(option); 
	       if(json.length>0 && ifFlag==1){
	    	  //$("#departmentId").val(json[0].departmentId);
	    	  //searchDoctor(json[0].departmentId,null);
	      } 
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
		  // $("#searchDoc").removeAttr("disabled");
		}
	searchDoctor(hdC,null);
}
//医生下拉
function searchDoctor(departmentId,doctorId){
	var url = ctx+"/regrecord/searchDoctor";
	$.post(url,{'departmentId':departmentId},function (data){
		json = eval(data);
		  selPeram = "#doctorId";
		  //添加前先清空
		  $(selPeram).empty(); 
	      var option = "";
	      option = $("<option>").val("").text("请选择");
	      $(selPeram).append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(doctorId!=null && doctorId == json[i].doctorId){
				option = $("<option>").val(json[i].doctorId).text(json[i].doctorName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].doctorId).text(json[i].doctorName);
			}
		    $(selPeram).append(option); 
		} 
	});
}


</script>
</body>
</html>