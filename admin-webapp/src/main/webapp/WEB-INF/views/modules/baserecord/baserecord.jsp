<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>预约统计列表</title>
</head>

<body>
	<form name="form" role="form" action="${ctx}/baserecord/list" method="GET">
    <%-- <input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/> --%>
    <input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${registrationRecord.departmentId}"/>
	<input id="departmentName" name="departmentName" type="hidden" value="${departmentName}"/>
    <input id="vip" name="vip" type="hidden" value="${vip}"/>
    <!-- <input id="flag" name="flag" type="hidden" value="${flag}"/>  -->
    <input id="scene" name="scene" type="hidden" value="${scene}"/>
    <input type="hidden" id="page" name="page" value="${page}"/>
		<%-- 所在地：
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
	   <c:if test="${hospId!=null}">
	    	<option>${hospName}</option>
	    </c:if>
	    <c:if test="${registrationRecord.hospId==null}">
	    	<option value="0">请选择</option>
	    </c:if>
	    </select>    
    <br/> --%>
	医院科室：<select class="mSelect"  class="mSelect"  id="hdParent" name="hdParent" onchange="searchHd(this,1,null,null,1)">
    			<option value="0">请选择</option>
   			</select>&nbsp;&nbsp;   
    	    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="selectHd(this);" >
			    <c:if test="${registrationRecord.standardDepartmentId==null}">
			    	<option value="0">请选择</option>
			    </c:if>
    		</select>&nbsp;&nbsp;
         医生：<select class="mSelect"  class="mSelect"  id="doctorId" name="doctorId">
		     <c:if test="${registrationRecord.doctorId==null}">
		    	<option value="">请选择</option>
		     </c:if>
	    </select>
	    <br/>
   	 发送手机号：<input type="text"  id="phone" name="phone"   style="width:100px;" value="${registrationRecord.phoneNum}"/>
	 身份证号码：<input type="text"  id="idCard" name="idCard"   style="width:160px;" value="${registrationRecord.idCard}"/>
           挂号日期：<%-- <input class="Wdate" type="text" name="registrationDate" id="registrationDate"  value="<fmt:formatDate value="${registrationRecord.registrationDate}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;
     --%> <input class="Wdate" type="text" name="registration" id="registration"  value="<fmt:formatDate value="${registrationRecord.registrationDate}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;
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
				<th class="text-center">就诊人</th>
				<th class="text-center" style="width:30px;">性别</th>
				<th class="text-center">证件号</th>
				<th class="text-center">联系电话</th>
				<th class="text-center">就诊时间</th>
				<th class="text-center">预约时间</th>
				<th class="text-center">门诊类型</th>
				<th class="text-center">取号时间</th>
				<th class="text-center">取号地点</th>
				<c:if test="${scene==2}">
				<th class="text-center">服务类型</th>
				</c:if>
				<th class="text-center">操作人</th>
				<th class="text-center">社保卡号</th>
				<th class="text-center">医院处理状态</th>
				<th class="text-center">短信接收状态</th>
			</tr>
			</thead>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="today"/>
			<c:forEach items="${regRecordList}" var="regRecord" varStatus="status">
			<tr>
				<td>${regRecord.hospName}</td>
				<td>${regRecord.departmentName}</td>
				<td>${regRecord.doctorName}</td>
				<td>${regRecord.patientName}</td>
				<td>
				<c:if test="${regRecord.sex==1}">男</c:if>
				<c:if test="${regRecord.sex==2}">女</c:if>
				</td>
				<td>${regRecord.idCard}</td>
				<td>${regRecord.phoneNum}</td>
				<td>
				<fmt:formatDate value="${regRecord.diagnosisDate}" pattern="yyyy-MM-dd,EEEE"/>&nbsp;
				<c:if test="${regRecord.ampm==1}">上午</c:if>
				<c:if test="${regRecord.ampm==2}">下午</c:if>	
				<c:if test="${regRecord.timespanStart!=''}">
				<fmt:formatDate value="${regRecord.timespanStart}" pattern="HH:mm"/>
				</c:if>
				</td>
				<td><fmt:formatDate value="${regRecord.registrationDate}" pattern="yyyy-MM-dd"/></td>
				<td>${regRecord.resourceTpyeText}</td>
				<td>${regRecord.retrieveTime}</td>
				<td>${regRecord.retrieveAddress}</td>
				<c:if test="${scene==2}">
					<td>
						<c:if test="${regRecord.serviceType=='1'}">挂号</c:if>
						<c:if test="${regRecord.serviceType=='2'}">挂号+导诊</c:if>
						<c:if test="${regRecord.serviceType=='3'}">老人陪护</c:if>
						<c:if test="${regRecord.serviceType=='4'}">挂号+导诊（上门取卡）</c:if>					
					</td>
				</c:if>
				<td>${regRecord.operatorName}</td>
				<td>${regRecord.medicareNumber}</td>
				<td>
				<c:if test="${regRecord.isGuide=='1'}">未处理</c:if>
				<c:if test="${regRecord.isGuide=='2'}">接诊</c:if>
				<c:if test="${regRecord.isGuide=='3'}">拒绝</c:if>
				<c:if test="${regRecord.isGuide=='4'}">爽约</c:if>
				</td>
				<td>
				<fmt:formatDate value="${regRecord.diagnosisDate}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="diagnosisDate"/>
				
				<!-- 	 ${today} - ${diagnosisDate}
				<c:if test="${today > diagnosisDate }">
					<a onclick="sendsms('${regRecord.registrationRecordId}')">重发1</a>
				</c:if> -->
				<c:if test="${today <= diagnosisDate }">
					<button type="button" class="btn btn-primary btn-sm" onclick="sendsms('${regRecord.registrationRecordId}')">重 发 </button>
				</c:if>
				
				<c:choose>
					<c:when test="${regRecord.email=='NULL'}">发送中</c:when>  
					<c:when test="${regRecord.email=='DELIVRD'}">成功</c:when>  
				    <c:when test="${regRecord.email=='BLACKMB'}">拒收</c:when>
				    <c:when test="${regRecord.email=='History'}">成功</c:when>
				    <c:when test="${regRecord.email=='CU3:10'}">用户关机</c:when>
					<c:otherwise>${regRecord.email}</c:otherwise>
				</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/baserecord/list?hospId=${params.hospId}&areaId=${params.areaId}&departmentId=${params.departmentId}&departmentName=${params.departmentName}"/>	
	
	
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//查询条件赋值
	if("${registrationRecord.isGuide}"!=""){
		$("#isGuide").val("${registrationRecord.isGuide}");
	}
	if("${registrationRecord.unsubscribeType}"!=""){
		$("#unsubscribeType").val("${registrationRecord.unsubscribeType}");
	}
	if("${registrationRecord.serviceType}"!=""){
		$("#serviceType").val("${registrationRecord.serviceType}");
	}
	
	var areaIdParent = "${areaIdParent}";
	var areaId = "${areaId}";
	var hospId = "${registrationRecord.hospId}";
	var hdParent = "${hdParent}";
	var departmentId = "${registrationRecord.departmentId}";
	var doctorId = "${registrationRecord.doctorId}";
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
function openDiv() {
	$("#divSCA").OpenDiv();
}

function closeDiv() {
	$("#registrationRecordId").val("");
	$("#latestUnsubscribeTime").val("");
	$("#divSCA").CloseDiv();	
}



</script>
</body>
</html>