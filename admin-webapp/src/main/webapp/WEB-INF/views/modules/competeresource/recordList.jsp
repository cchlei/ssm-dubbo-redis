<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>挂号记录列表</title>
<style>
#divSCA
      {
          position: absolute;
          top:200px !important;
          width: 500px;
          height: 300px;
          font-size: 12px;
          background: #fff;
          border: 0px solid #000;
          z-index: 10001;
          display: none;
      }
#close
      {
      position:absolute;
		right:0;/*   定位到右上   */
		top:0;
      }
       
</style>
</head>

<body>
	<!-- <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">挂号记录列表</a></li>
	</ul> -->
	<div>
	<form name="form" role="form" action="${ctx}/competeresource/recordlist" method="GET">
    <%-- <input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/> --%>
    <input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${competeResourceRecord.departmentId}"/>
	<input id="departmentName" name="departmentName" type="hidden" value="${competeResourceRecord.departmentName}"/>
    <input type="hidden" id="page" name="page" value="${page}"/>
    

	 <c:if test="${belongHospId==null || belongHospId==''}">
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
	   <%-- <c:if test="${hospId!=null}">
	    	<option>${hospName}</option>
	    </c:if> --%>
	    <c:if test="${competeResourceRecord.hospId==null}">
	    	<option value="0">请选择</option>
	    </c:if>
	    </select>
	 </c:if>
    <br/>
	医院科室：<select class="mSelect"  class="mSelect"  id="hdParent" name="hdParent" onchange="searchHd(this,1,null,null,1)">
    <option value="0">请选择</option>
    </select>&nbsp;&nbsp;
    <!-- <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="searchHd(this.value,2);"> -->
    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="selectHd(this);">
   	<%-- <c:if test="${competeResourceRecord.departmentId!=null && competeResourceRecord.departmentId!=hdParent}">
    	<option>${departmentName}</option>
    </c:if>  --%>
    <c:if test="${competeResourceRecord.departmentId==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select>&nbsp;&nbsp;
    医生：<select class="mSelect"  class="mSelect"  id="doctorId" name="doctorId">
     <c:if test="${competeResourceRecord.doctorId==null}">
    	<option value="">请选择</option>
    </c:if>
    </select>
    <br/>
             来源：<select class="mSelect"  class="mSelect"  id="recordSource" name="recordSource" size="1">
   	    <option value="">请选择</option>
    	<option value="1">app</option>
		<option value="2">第三方</option>
		<option value="3">客服</option>
		<option value="4">vip</option>
		<option value="5">现场</option>
		<option value="6">电话</option>
		<option value="7">行业项目</option>
		<option value="8">渠道</option>
		<option value="9">PC网站</option>
		<option value="10">区域</option>
		<option value="11">内嵌页</option>
	</select>
       状态：<select class="mSelect"  class="mSelect"  id="status" name="status">
	    <option value="">请选择</option>
		<option value="0">已提交</option>
		<option value="1">审核通过</option>
		<option value="2">审核未过</option>
		<option value="3">挂号成功</option>
		<option value="4">挂号失败</option>
		<option value="5">已取消</option>
	</select>
      
          预约抢号时间：<input class="Wdate" type="text" name="startDate" id="startDate"  value="<fmt:formatDate value="${competeResourceRecord.startDate}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;-&nbsp;
	<input class="Wdate" type="text" name="endDate" id="endDate"  value="<fmt:formatDate value="${competeResourceRecord.endDate}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;
	
    <input type="submit" id="searchDoc" value="查询"/>
    </form><p>
    <input type="button" name="pass" id="pass" value="批量通过" onclick="batchPass()">
    <input type="button" name="refuse" id="refuse" value="批量拒绝" onclick="batchRefuse()">
    <input type="button" name="cancel" id="cancel" value="批量取消" onclick="batchCancel()">
    <div id="selCon1">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 抢号记录列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter table2">
			<thead>
			<tr>
			    <th class="text-center" width="5%">全选<input type='checkbox'  onclick="selectAll(this,'selCon1')"></th>
			    <th class="text-center">医院名称</th>
				<th class="text-center">科室名称</th>
				<th class="text-center">医生</th>
				<th class="text-center">就诊人</th>
				<th class="text-center" style="width:30px;">性别</th>
				<th class="text-center">手机号</th>
				<th class="text-center">证件类型</th>
				<th class="text-center">证件号</th>
				<th class="text-center">预约抢号时间</th>
				<th class="text-center">社保卡类型</th>
				<th class="text-center">社保卡号</th>
				<th class="text-center">初/复诊</th>
				<th class="text-center">来源</th>
				<th class="text-center">状态</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="today"/>
			<c:forEach items="${competeRecordList}" var="competeRecord" varStatus="status">
			<tr>
			    <td class="text-center"><input type="checkbox" id="recordId" name="recordId" value="${competeRecord.recordId}"/></td>
				<td>${competeRecord.hospName} </td>
				<td>${competeRecord.departmentName}</td>
				<td>${competeRecord.doctorName}</td>
				<td>${competeRecord.patientName}</td>
				<td>
				<c:if test="${competeRecord.sex==1}">男</c:if>
				<c:if test="${competeRecord.sex==2}">女</c:if>
				</td>
				<td>${competeRecord.phoneNum}</td>
				<td>
				<c:if test="${competeRecord.idType==1}">身份证</c:if>
				<c:if test="${competeRecord.idType==2}">社保卡</c:if>
				<c:if test="${competeRecord.idType==3}">驾驶证</c:if>
				<c:if test="${competeRecord.idType==0}">其它</c:if>
				</td>
				<td>${competeRecord.idCard}</td>

				<td>
				<fmt:formatDate value="${competeRecord.diagnosisDate}" pattern="yyyy-MM-dd,EEEE"/>&nbsp;
				</td>
				<td>
				<c:if test="${competeRecord.medicareCardType==1}">医保卡</c:if>
				<c:if test="${competeRecord.medicareCardType==2}">自保卡</c:if>
				<c:if test="${competeRecord.medicareCardType==3}">自费初诊</c:if>
				</td>
				<td>${competeRecord.medicareNumber}</td>
				<td>
				<c:if test="${competeRecord.isFirstVisit==1}">初诊</c:if>
				<c:if test="${competeRecord.isFirstVisit==2}">复诊</c:if>
				</td>
				<td>
				<c:if test="${competeRecord.recordSource==1}">app</c:if>
				<c:if test="${competeRecord.recordSource==2}">第三方</c:if>
				<c:if test="${competeRecord.recordSource==3}">客服</c:if>
				<c:if test="${competeRecord.recordSource==4}">vip</c:if>
				<c:if test="${competeRecord.recordSource==5}">现场</c:if>
				<c:if test="${competeRecord.recordSource==6}">电话</c:if>
				<c:if test="${competeRecord.recordSource==7}">行业项目</c:if>
				<c:if test="${competeRecord.recordSource==8}">渠道</c:if>
				<c:if test="${competeRecord.recordSource==9}">pc网站</c:if>
				<c:if test="${competeRecord.recordSource==10}">区域</c:if>
				<c:if test="${competeRecord.recordSource==11}">内嵌页</c:if>
				</td>
				<td>
				<c:if test="${competeRecord.status=='0'}">已提交</c:if>
				<c:if test="${competeRecord.status=='1'}">审核通过</c:if>
				<c:if test="${competeRecord.status=='2'}">审核未过</c:if>
				<c:if test="${competeRecord.status=='3'}">挂号成功</c:if>
				<c:if test="${competeRecord.status=='4'}">挂号失败</c:if>
				<c:if test="${competeRecord.status=='5'}">已取消</c:if>
				</td>
				<td>
				<fmt:formatDate value="${competeRecord.diagnosisDate}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="diagnosisDate"/>
                <c:if test="${competeRecord.status=='0'}">
                <a href="javascript:void(0);" onclick="applyPass('${competeRecord.recordId}')" >通过</a><br>
                <a href="javascript:void(0);" onclick="applyRefuse('${competeRecord.recordId}')">拒绝</a><br>
                <a href="javascript:void(0);" onclick="applyCancel('${competeRecord.recordId}')">取消</a><br>
                </c:if>
                <c:if test="${competeRecord.status=='1'}">
                <a href="javascript:void(0);" onclick="applyCancel('${competeRecord.recordId}')">取消</a>
                </c:if>
                <c:if test="${competeRecord.status=='2'}">
                <a href="${ctx}/competeresource/toCompeteResourceInfo?recordId=${competeRecord.recordId}">详情</a>
                </c:if>
				</td>

				
			</tr>
			</c:forEach>
		</table>
	</div>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/competeresource/recordlist?hospId=${params.hospId}&startDate=${params.startDate}&endDate=${params.endDate}&areaId=${params.areaId}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&areaIdParent=${params.areaIdParent}&areaIdChild=${params.areaIdChild}&hospital=${params.hospital}&hdParent=${params.hdParent}&hdChild1=${params.hdChild1}&doctorId=${params.doctorId}&patientName=${params.patientName}&operatorName=${params.operatorName}"/>	
	
	<div id="divSCA">
	   <input type="button" id="close" value="关闭" onclick="closeDiv()">
	   <input type="hidden" name="registrationRecordId" id="registrationRecordId">
	   <input type="hidden" name="latestUnsubscribeTime" id="latestUnsubscribeTime">
	   <input type="hidden" name="cancelDoctorId" id="cancelDoctorId">
	   <br/><br/><br/><br/>
	   &nbsp;&nbsp;&nbsp;&nbsp;请选择取消原因：<select id="cause" name="cause" class="lSelect">
	      <option value="1">${causeMAp['1']}</option>
	      <option value="2">${causeMAp['2']}</option>
	      <option value="3">${causeMAp['3']}</option>
	   </select>
	   <br/><br/><br/><br/>
	   <div style="margin-left:180px">
	   		<button type="button" id="cancelBut" onclick="cancel();" class="btn btn-primary">确定</button></div>
	   </div>
	</div>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//查询条件赋值
	if("${competeResourceRecord.recordSource}"!=""){
		$("#recordSource").val("${competeResourceRecord.recordSource}");
	}
	if("${competeResourceRecord.status}"!=""){
		$("#status").val("${competeResourceRecord.status}");
	}

	var areaIdParent = "${areaIdParent}";
	var areaId = "${areaId}";
	var hospId = "${competeResourceRecord.hospId}";
	var hdParent = "${hdParent}";
	var departmentId = "${competeResourceRecord.departmentId}";
	var doctorId = "${competeResourceRecord.doctorId}";
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
//批量通过
function batchPass()
{
	var recordIds = $("input[name='recordId']:checked").serialize();
	if(checkedNum()<1){
		alert("请勾选注册用户！");
		return;
	}else{
		 var AjaxURL= "${ctx}/competeresource/batchPass";  
             $.ajax({
                 type: "POST",
                 url: AjaxURL,
                 data: {"recordIds":recordIds},
                 success: function (data) {
 					$.alert(data.message, function() {
						window.location.reload();
					});
                 },
                 error: function(data) {
                     alert("error:"+data.message);
                  }
             });
	}
}
//批量拒绝
function batchRefuse()
{
	var recordIds = $("input[name='recordId']:checked").serialize();
	alert(recordIds);
	if(checkedNum()<1){
		alert("请勾选注册用户！");
		return;
	}else{
		 var AjaxURL= "${ctx}/competeresource/batchRefuse";  

             $.ajax({
                 type: "POST",
                 url: AjaxURL,
                 data: {"recordIds":recordIds},
                 success: function (data) {
  					$.alert(data.message, function() {
						window.location.reload();
					});
                 },
                 error: function(data) {
                     alert("error:"+data.message);
                  }
             });
	}
}
//批量取消
function batchCancel()
{
	var recordIds = $("input[name='recordId']:checked").serialize();
	alert(recordIds);
	if(checkedNum()<1){
		alert("请勾选注册用户！");
		return;
	}else{
		 var AjaxURL= "${ctx}/competeresource/batchRefuse";

             $.ajax({
                 type: "POST",
                 url: AjaxURL,
                 data: {"recordIds":recordIds},
                 success: function (data) {
  					$.alert(data.message, function() {
						window.location.reload();
					});
                 },
                 error: function(data) {
                     alert("error:"+data.message);
                  }
             });
	}
}

//通过
function applyPass(recordId)
{
		 var AjaxURL= "${ctx}/competeresource/applyPass";  

             $.ajax({
                 type: "POST",
                 url: AjaxURL,
                 data: {"recordId":recordId},
                 success: function (data) {
  					$.alert(data.message, function() {
						window.location.reload();
					});
                 },
                 error: function(data) {
                     alert("error:"+data.message);
                  }
             });
	
}
//拒绝
function applyRefuse(recordId)
{
		 var AjaxURL= "${ctx}/competeresource/applyRefuse";  

             $.ajax({
                 type: "POST",
                 url: AjaxURL,
                 data: {"recordId":recordId},
                 success: function (data) {
  					$.alert(data.message, function() {
						window.location.reload();
					});
                 },
                 error: function(data) {
                     alert("error:"+data.message);
                  }
             });
}
//取消
function applyCancel(recordId)
{

		 var AjaxURL= "${ctx}/competeresource/applyCancel";

             $.ajax({
                 type: "POST",
                 url: AjaxURL,
                 data: {"recordId":recordId},
                 success: function (data) {
  					$.alert(data.message, function() {
						window.location.reload();
					});
                 },
                 error: function(data) {
                     alert("error:"+data.message);
                  }
             });
}

//判断勾选的复选框个数
function checkedNum(){
	var checks = document.getElementsByName("recordId");
	n = 0;
	for(i=0;i<checks.length;i++){
		if(checks[i].checked)
			n++;
	}
	return n;
}
function process(registrationRecordId){
	var url = ctx+"/register/processConsumer";
	$.post(url,{'recordId':registrationRecordId},function(json){
		if(json=='success'){
			$.alert('挂号记录已成功处理。', function() {
				var registerType = "${registerType}";
				//window.location.href = '${ctx}/regrecord/queryRecordlist?doctorId='+json.results+"&registerType="+registerType;
				window.location.href = '${ctx}/regrecord/queryRecordlist?hospId=${params.hospId}&queryDiagnosisDateBegin=${params.queryDiagnosisDateBegin}&queryDiagnosisDateEnd=${params.queryDiagnosisDateEnd}&areaId=${params.areaId}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&areaIdParent=${params.areaIdParent}&areaIdChild=${params.areaIdChild}&hospital=${params.hospital}&hdParent=${params.hdParent}&hdChild1=${params.hdChild1}&doctorId=${params.doctorId}&projectNum=${params.projectNum}&ikangCardNum=${params.ikangCardNum}&queryRegistrationDateBegin=${params.queryRegistrationDateBegin}&queryRegistrationDateEnd=${params.queryRegistrationDateEnd}&patientName=${params.patientName}&operatorName=${params.operatorName}&isGuide=${params.isGuide}&serviceType=${params.serviceType}&unsubscribeType=${params.unsubscribeType}&sortOrder=${params.sortOrder}&registerType=${params.registerType}';
			});
		}else{
			alert("处理失败，请联系管理员。");
		}
	});
}

function sendsms(registrationRecordId){
	var url = ctx+"/register/sendsms";
	$.post(url,{'recordId':registrationRecordId},function(json){
		if(json=='success'){
			$.alert('短信重新发送', function() {
				if("${vip}"!=""){
					var vip = "${vip}";
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&vip="+vip+"&flag=1";;
				}else if("${scene}"!=""){
					var scene = "${scene}";
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&scene="+scene+"&flag=1";
				}else{
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&flag=1";
				}
				//window.location.reload();
			});
		}
	});
}
function cancel(){
	var registrationRecordId = $("#registrationRecordId").val();
	var latestUnsubscribeTime = $("#latestUnsubscribeTime").val();
	var cause = $("#cause").val();
	var doctorId = $("#doctorId").val();
	closeDiv();
	//alert(registrationRecordId+"---"+latestUnsubscribeTime+"---"+cause);
	var now = new Date();
	latestUnsubscribeTime = latestUnsubscribeTime.replace(/-/g,"/");//替换字符，变成标准格式    
	var last = new Date(Date.parse(latestUnsubscribeTime));    
	  if(last<now){
		alert("已过最晚取消时间！！");
		return;
	}  
	
	$.confirm("确定要取消此挂号？取消后不可恢复！", function() {
		$.get(ctx+"/regrecord/cancel/"+registrationRecordId,{'doctorId':doctorId,'cause':cause}, function(json) {
			var msg = "";
			if (json.message) {
				msg = json.message;
			}
			$.alert(msg, function() {
				if("${vip}"!=""){
					var vip = "${vip}";
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&vip="+vip+"&flag=1";;
				}else if("${scene}"!=""){
					var scene = "${scene}";
					//alert(json.results);
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&scene="+scene+"&flag=1";
				}else{
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&flag=1";
				}
				//window.location.reload();
			});
		}, "json");
	});
	
	
}
function toCancel(registrationRecordId,latestUnsubscribeTime,doctorId){
	$("#registrationRecordId").val(registrationRecordId);
	$("#latestUnsubscribeTime").val(latestUnsubscribeTime);
	$("#cancelDoctorId").val(doctorId);
	openDiv();
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
var LODOP ;
function preView(hospName,patientName,phoneNum,idCard,departmentName,doctorName,diagnosisDate,expenseText,retrieveAddress,registrationDate,retrieveTime,ampm,timestamp){
	LODOP = getLodop();
    LODOP.PRINT_INIT("");
    LODOP.SET_PRINT_PAGESIZE(3,800,300,"");//这里3表示纵向打印且纸高“按内容的高度”；300表示纸宽30.0mm；30表示页底空白3.0mm
    if(ampm==1){
		ampm="上午";    	
    }
    if(ampm==2){
		ampm="下午";    	
    }
    $("#p_hospname").text(hospName);
    $("#p_patientName").text(patientName);
    $("#p_phoneNum").text(phoneNum);
    $("#p_idCard").text(idCard);
    $("#p_departmentName").text(departmentName);
    $("#p_doctorName").text(doctorName);
    $("#p_diagnosisDate").text(diagnosisDate+" "+ampm+" "+timestamp);
    $("#p_expenseText").text(expenseText);
    $("#p_retrieveAddress").text(retrieveAddress);
    $("#p_registrationDate").text(registrationDate);
    $("#p_retrieveTime").text(retrieveTime);
    //LODOP.ADD_PRINT_RECT(0,0,305,505,2);
    
    LODOP.ADD_PRINT_HTM(0,0,270,100,document.getElementById("printer").innerHTML);
    //LODOP.PREVIEW();
    LODOP.PRINT();
}

function download(){
	var hospId = $("#hospId").val();
	var queryDiagnosisDateBegin = $("#queryDiagnosisDateBegin").val();
	var queryDiagnosisDateEnd = $("#queryDiagnosisDateEnd").val();
	var areaId = $("#areaId").val();
	var departmentId = $("#departmentId").val();
	var departmentName = $("#departmentName").val();
	var vip = $("#vip").val();
	var scene = $("#scene").val();
	var areaIdParent = $("#areaIdParent").val();
	var areaIdChild = $("#areaIdChild").val();
	var hospital = $("#hospital").val();
	var hdParent = $("#hdParent").val();
	var hdChild1 = $("#hdChild1").val();
	var doctorId = $("#doctorId").val();
	var projectNum = $("#projectNum").val();
	var ikangCardNum = $("#ikangCardNum").val();
	var queryRegistrationDateBegin = $("#queryRegistrationDateBegin").val();
	var queryRegistrationDateEnd = $("#queryRegistrationDateEnd").val();
	var patientName = $("#patientName").val();
	var isGuide = $("#isGuide").val();
	var serviceType = $("#serviceType").val();
	var unsubscribeType = $("#unsubscribeType").val();
	var registerType = $("#registerType").val();
	//alert(queryBeginDate1+"="+queryEndDate1);
	var url="${ctx}/regrecord/industryDownload?hospId="+hospId
			+"&queryDiagnosisDateBegin="+queryDiagnosisDateBegin
			+"&queryDiagnosisDateEnd="+queryDiagnosisDateEnd
			+"&areaId="+areaId
			+"&departmentId="+departmentId
			+"&departmentName="+departmentName
			+"&registerType="+registerType
			+"&vip="+vip
			+"&scene="+scene
			+"&areaIdParent="+areaIdParent
			+"&areaIdChild="+areaIdChild
			+"&hospital="+hospital
			+"&hdParent="+hdParent
			+"&hdChild1="+hdChild1
			+"&doctorId="+doctorId
			+"&projectNum="+projectNum
			+"&ikangCardNum="+ikangCardNum
			+"&queryRegistrationDateBegin="+queryRegistrationDateBegin
			+"&queryRegistrationDateEnd="+queryRegistrationDateEnd
			+"&patientName="+patientName
			+"&isGuide="+isGuide
			+"&serviceType="+serviceType
			+"&unsubscribeType="+unsubscribeType;
    window.open(url);
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