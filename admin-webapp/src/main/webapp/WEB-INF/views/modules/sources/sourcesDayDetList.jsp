<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生号源列表</title>
<meta http-equiv="Content-Type" content="text/html charset=utf-8">
<style>  
/*  input:focus{  
    border:1px solid #f00;  
    background:#fcc;  
 }   */
 .focus{  
    border:1px solid #f00;  
    background:#fcc;  
 }  
</style> 
</head>
<body>
	<!-- <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">号源编辑</a></li>
	</ul> -->
<c:forEach items="${sourceList}" var="resource" varStatus="status">
<c:if test="${status.count==1}">
<input id="doctorName" name="doctorName" type="hidden" value="${resource.doctorName}"/>
	<label style="font-size:20px;">
		${resource.hospName}->
		${resource.departmentName}->
		${resource.doctorName}->
		<fmt:formatDate value="${resource.resourceDate}" pattern="yyyy-MM-dd"/>
		号源：
		</label><br/>
		<%-- <label>挂&nbsp;号&nbsp;类&nbsp;型：</label>
	    <select class="mSelect"  class="mSelect"  name="resourceTpye" onchange="setValue(this);">
			<c:forEach items="${dicList}" var="dic" varStatus="status">
			  <c:if test="${resource.resourceTpye==dic.dictId}">
			  	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
			  </c:if>
			  <c:if test="${resource.resourceTpye!=dic.dictId}">
			  	<option value="${dic.dictId}">${dic.dictName}</option>
			  </c:if>
			  
			</c:forEach>
		</select> 
		<button type="button" class="btn btn-primary" onclick="editResType('${resource.resourceTpye}')">修改</button>--%>
		<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/sourcesDet/updateRTB" method="POST">
			<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
			<input id="departmentId" name="departmentId" type="hidden" value="${departmentId}"/>
			<input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/>
			<input id="resourceDays" name="resourceDays" type="hidden" value="${resourceDays}"/>
			<%-- <input id="date" name="date" type="hidden" value="${date}"/> --%>
			<%-- <input id="resourceTpye" name="resourceTpye" type="hidden" value="${resource.resourceTpye}"/> --%>
			<input id="amResourceTpyeText" name="amBean.resourceTypeText" type="hidden"/>
			<input id="pmResourceTpyeText" name="pmBean.resourceTypeText" type="hidden"/>
			<input id="isTimespan" name="isTimespan" type="hidden" value="${resource.isTimespan}"/>
			<input id="resourceDate" name="resourceDate" type="hidden" value="<fmt:formatDate value="${resource.resourceDate}" pattern="yyyy-MM-dd"/>"/>
			<br/><label>是否分时段：</label>
			<c:if test="${resource.isTimespan==1}">是</c:if>
			<c:if test="${resource.isTimespan==2}">否</c:if><br/>
			<label>预约开始时间(小时)：</label>
			<input type="text"  id="beginRegisterTime" name="beginRegisterTime" style='width:60px' value="${resource.beginRegisterTime}"/ >
			<label>预约截止时间(小时)：</label>
			<input type="text"  id="overRegisterTime" name="overRegisterTime" style='width:60px' value="${resource.overRegisterTime}"/ >	
			
			<div id="amShow">
			<br/>
			 <label>“上午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  id="amResourceTpye" name="amBean.resourceType" onchange="selecType(this,'1');">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
			<label>挂号费：</label>
			<input type="text"  id="amexpense" name="amBean.expense" style='width:60px' value="${resourceTypeBean.amBean.expense}" >	
			<label>取号地点：</label>
			<input type="text"  id="amretrieveAddress" name="amBean.retrieveAddress" style='width:200px' value="${resourceTypeBean.amBean.retrieveAddress}" >	
			</div>
			<div id="pmShow">
			<br/>
			 <label>“下午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  id="pmResourceTpye" name="pmBean.resourceType" onchange="selecType(this,'2');">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
			<label>挂号费：</label>
			<input type="text"  id="pmexpense" name="pmBean.expense" style='width:60px' value="${resourceTypeBean.pmBean.expense}" >	
			<label>取号地点：</label>
			<input type="text"  id="pmretrieveAddress" name="pmBean.retrieveAddress" style='width:200px' value="${resourceTypeBean.pmBean.retrieveAddress}"  >	
			</div>
			</c:if>
			</c:forEach>
			<button type="submit" class="btn btn-primary">修改</button>
	</form>
	<div class="panel panel-default">
		<input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/>
		
		
	<div id ="showDiv1">
		<table class="table table-bordered table-hover tablesorter"  id="tableS1">
			<thead>
			<tr>
			    <th></th>
			    <th class="text-center">挂号类型</th>
			    <th class="text-center">挂号费</th>
			    <th class="text-center">取号地点</th>
			    <th class="text-center">号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			<c:forEach items="${sourceList}" var="resource" varStatus="status">
			<c:if test="${fn:length(sourceList)<2 && resource.ampm==2}">
					<tr>
						<td>上午</td>
						<td>
						<select class="mSelect"  class="mSelect"  name="resourceTpye" onchange="setValue(this);">
							<c:forEach items="${dicList}" var="dic" varStatus="status">
							  	<option value="${dic.dictId}">${dic.dictName}</option>
							</c:forEach>
						</select>
						</td>
						<td><input type="text" name='expense'/></td>
						<td><input type="text" name='retrieveAddress' style='width:100%'/></td>
						<td><input type="text" name='resourceNum'/></td>
						<td><button type="button" class="btn btn-primary" onclick="addOne('2',this,'1')">添加</button></td>
					</tr>
					<tr>
						<td>
						<c:if test="${resource.ampm==1}">上午</c:if>
						<c:if test="${resource.ampm==2}">下午</c:if>
						</td>
						<td>
						<select class="mSelect"  class="mSelect"  name="resourceTpye" onchange="setValue(this);">
							<c:forEach items="${dicList}" var="dic" varStatus="status">
							  <c:if test="${resource.resourceTpye==dic.dictId}">
							  	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
							  </c:if>
							  <c:if test="${resource.resourceTpye!=dic.dictId}">
							  	<option value="${dic.dictId}">${dic.dictName}</option>
							  </c:if>
							  
							</c:forEach>
						</select>
						</td>
						<td><input type="text" value="${resource.expense}"/></td>
						<td><input type="text" value="${resource.retrieveAddress}" style='width:100%'/></td>
						<td><input type="text" value="${resource.resourceNum}"></td>
						<%-- <td>${resource.beginRegisterTime}</td>
						<td>${resource.overRegisterTime}</td> --%>
						<td><button type="button" class="btn btn-primary" onclick="editNum(this,'${resource.resourceId}')">修改</button>&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" onclick="delOne('${resource.resourceId}')">删除</button>
						</td>
				    </tr>
			</c:if>
			<c:if test="${fn:length(sourceList)==2}">
			<c:if test="${resource.ampm==status.count}">
				<tr>
					<td>
					<c:if test="${resource.ampm==1}">上午</c:if>
					<c:if test="${resource.ampm==2}">下午</c:if>
					</td>
					<td>
						<select class="mSelect"  class="mSelect"  name="resourceTpye" onchange="setValue(this);">
							<c:forEach items="${dicList}" var="dic" varStatus="status">
							  <c:if test="${resource.resourceTpye==dic.dictId}">
							  	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
							  </c:if>
							  <c:if test="${resource.resourceTpye!=dic.dictId}">
							  	<option value="${dic.dictId}">${dic.dictName}</option>
							  </c:if>
							  
							</c:forEach>
						</select>
						</td>
						<td><input type="text" value="${resource.expense}"/></td>
						<td><input type="text" value="${resource.retrieveAddress}" style='width:100%'/></td>
					<td><input type="text" value="${resource.resourceNum}"></td>
					<%-- <td>${resource.beginRegisterTime}</td>
					<td>${resource.overRegisterTime}</td> --%>
					<td><button type="button" class="btn btn-primary" onclick="editNum(this,'${resource.resourceId}')">修改</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-primary" onclick="delOne('${resource.resourceId}')">删除</button>
					</td>
				</tr>
			</c:if>
			</c:if>
			<c:if test="${fn:length(sourceList)<2 && resource.ampm==1}">
					<tr>
						<td>
						<c:if test="${resource.ampm==1}">上午</c:if>
						<c:if test="${resource.ampm==2}">下午</c:if>
						</td>
						<td>
						<select class="mSelect"  class="mSelect"  name="resourceTpye" onchange="setValue(this);">
							<c:forEach items="${dicList}" var="dic" varStatus="status">
							  <c:if test="${resource.resourceTpye==dic.dictId}">
							  	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
							  </c:if>
							  <c:if test="${resource.resourceTpye!=dic.dictId}">
							  	<option value="${dic.dictId}">${dic.dictName}</option>
							  </c:if>
							  
							</c:forEach>
						</select>
						</td>
						<td><input type="text" value="${resource.expense}"/></td>
						<td><input type="text" value="${resource.retrieveAddress}" style='width:100%'/></td>
						<td><input type="text" value="${resource.resourceNum}"></td>
						<%-- <td>${resource.beginRegisterTime}</td>
						<td>${resource.overRegisterTime}</td> --%>
						<td><button type="button" class="btn btn-primary" onclick="editNum(this,'${resource.resourceId}')">修改</button>&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" onclick="delOne('${resource.resourceId}')">删除</button>
						</td>
				    </tr>
					<tr>
						<td>下午</td>
						<td>
						<select class="mSelect"  class="mSelect"  name="resourceTpye" onchange="setValue(this);">
							<c:forEach items="${dicList}" var="dic" varStatus="status">
							  	<option value="${dic.dictId}">${dic.dictName}</option>
							</c:forEach>
						</select>
						</td>
						<td><input type="text" name='expense'/></td>
						<td><input type="text" name='retrieveAddress' style='width:100%'/></td>
						<td><input type="text" name='resourceNum'/></td>
						<td><button type="button" class="btn btn-primary" onclick="addOne('2',this,'2')">添加</button></td>
					</tr>
			</c:if>
			</c:forEach>
		 </table>
   </div>		 
   
   <div id ="showDiv2">
        <table class="table table-bordered table-hover tablesorter" id="table1">
			<thead>
			<tr>
			<th colspan="6"><label style="font-size:15px;">上午</label>&nbsp;
			</th>
			</tr>
			<tr>
			    <th class="text-center">开始时段</th>
			    <th class="text-center">截止时段</th>
			    <th class="text-center">号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			<a href="javascript:void(0);" onclick="addDetNewRow('table1','1');">新增上午号源+</a><br/>
			<c:forEach items="${sourceList}" var="resource" varStatus="status">
			<c:if test="${resource.ampm==1}">
				<tr> 
				<td><fmt:formatDate value="${resource.timespanStart}" pattern="HH:mm"/></td>
				<td><fmt:formatDate value="${resource.timespanEnd}" pattern="HH:mm"/></td>
				<td><input type="text" value="${resource.resourceNum}"></td>
				<%-- <td>${resource.beginRegisterTime}</td>
				<td>${resource.overRegisterTime}</td> --%>
				<td><button type="button" class="btn btn-primary" onclick="editNum(this,'${resource.resourceId}')">修改</button>&nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="delOne('${resource.resourceId}')">删除</button>
				</td>
				</tr>
			</c:if>
			</c:forEach>
	    </table>
	    <table class="table table-bordered table-hover tablesorter" id="table2">
	        <thead>
	        <tr>
			<th colspan="6"><label style="font-size:15px;">下午</label></th>
			</tr>
			<tr>
			    <th class="text-center">开始时段</th>
			    <th class="text-center">截止时段</th>
			    <th class="text-center">号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			<a href="javascript:void(0);" onclick="addDetNewRow('table2','2');">新增下午号源+</a><br/>
			<c:forEach items="${sourceList}" var="resource" varStatus="status">
			<c:if test="${resource.ampm==2}">
				<tr> 
				<td><fmt:formatDate value="${resource.timespanStart}" pattern="HH:mm"/></td>
				<td><fmt:formatDate value="${resource.timespanEnd}" pattern="HH:mm"/></td>
				<td><input type="text" value="${resource.resourceNum}"></td>
				<%-- <td>${resource.beginRegisterTime}</td>
				<td>${resource.overRegisterTime}</td> --%>
				<td><button type="button" class="btn btn-primary" onclick="editNum(this)">修改</button>&nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="delOne('${resource.resourceId}')">删除</button>
				</td>
				</tr>
			</c:if>
			</c:forEach>
        </table>
   </div>
		</div>
		
	</div>
<script type="text/javascript">
var ctx = "${ctx}";

$(document).ready(function() {
	var isTimespan = $("#isTimespan").val();
	if(isTimespan==1){
		if("${resourceTypeBean.amBean}"!=""){
			var rtbamType = "${resourceTypeBean.amBean.resourceType}";
			var rtbamTypeText = "${resourceTypeBean.amBean.resourceTypeText}";
			$("#amResourceTpye").val(rtbamType);
			$("#amResourceTpyeText").val(rtbamTypeText);
		}else{
			var textAm = $("#amResourceTpye").find("option:selected").text();
			$("#amResourceTpyeText").val(textAm);
			//document.getElementById("showDiv1").style.display="block";
			document.getElementById("amShow").style.display="none";
		}
		//alert("${resourceTypeBean.pmBean}"=="");
		if("${resourceTypeBean.pmBean}"!=""){
			var rtbpmType = "${resourceTypeBean.pmBean.resourceType}";
			var rtbpmTypeText = "${resourceTypeBean.pmBean.resourceTypeText}";
			$("#pmResourceTpye").val(rtbpmType);
			$("#pmResourceTpyeText").val(rtbpmTypeText);
		}else{
			var textPm = $("#pmResourceTpye").find("option:selected").text();
			$("#pmResourceTpyeText").val(textPm);
			document.getElementById("pmShow").style.display="none";
		}
	}else{
		document.getElementById("amShow").style.display="none";
		document.getElementById("pmShow").style.display="none";
	}
	ifShow(isTimespan,'2');
	init();
	
	$(".form-input").Validform({
		showAllError : true,
		tiptype : function(msg, o, cssctl) {
			if (!o.obj.is("form")) {
				//alert($(o.obj.parent().parent().find(".Validform_checktip")).html());
				var objtip = o.obj.parent().parent().find(".Validform_checktip");
				cssctl(objtip, o.type);
				objtip.text(msg);
			} else {
				var objtip = o.obj.find("#msg-info");
				cssctl(objtip, o.type);
				objtip.text(msg);
			};
		},
		postonce : true,
		ajaxPost : true,
		beforeSubmit:function(curform){
			var am = $("#amShow").css("display");
			var pm = $("#pmShow").css("display");
			if(am=="block"){
				var expense = $("#amexpense").val();
				var retrieveAddress = $("#amretrieveAddress").val();
				if(expense==""){
					alert("请填写对应上午号源挂号费！");
				}
				if(retrieveAddress==""){
					alert("请填写对应上午号源取号地点！");
				}
			}
			if(pm=="block"){
				var expense = $("#pmexpense").val();
				var retrieveAddress = $("#pmretrieveAddress").val();
				if(expense==""){
					alert("请填写对应下午号源挂号费！");
				}
				if(retrieveAddress==""){
					alert("请填写对应下午号源取号地点！");
				}
			}
			$('#fat-btn').button('loading');
			//console.log($("#amResourceTpyeText").val());
		},
		callback : function(json, statusText) {
			if (json.success) {
				$.alert(json.message, function(){
					window.location.reload();
					//window.location.href = '${ctx}/link/list';
				});
			} else {
				errorValidate("msg-info", '');
				if (json.data.title) {
					errorValidate('title', json.message + ',' + json.data.title);
				}
				
			}
			$('#fat-btn').button('reset');
		}
	});
	
});
function addOne(isTimeSpan,objOne,type){
	var obj=objOne.parentNode;
	var ampm = 1;
	var beginRegisterTime = $("#beginRegisterTime").val();
	var overRegisterTime = $("#overRegisterTime").val();
	var doctorId = $("#doctorId").val();
	var resourceDate = $("#resourceDate").val();
	var isTimespan = $("#isTimespan").val();
	var departmentId = $("#departmentId").val();
	var resourceTpye = "";
	var resourceTpyeText = "";
	if(type==2){//下午
		ampm=2;
	}
	if(isTimeSpan==1){//分时段
		if(type==2){//下午
			resourceTpye = $("#pmResourceTpye").val();
			resourceTpyeText=$("#pmResourceTpye").find("option:selected").text();
			expense = $("#pmexpense").val();
			retrieveAddress = $("#pmretrieveAddress").val();
			if(expense==""||expense==null){
				alert("请填写对应下午号源挂号费！");
				return;
			}
			if(retrieveAddress==""||retrieveAddress==null){
				alert("请填写对应下午号源取号地点！");
				return;
			}
		}else if(type==1){//上午
			resourceTpye = $("#amResourceTpye").val();
			resourceTpyeText=$("#amResourceTpye").find("option:selected").text();
			expense = $("#amexpense").val();
			retrieveAddress = $("#amretrieveAddress").val();
			if(expense==""||expense==null){
				alert("请填写对应上午号源挂号费！");
				return;
			}
			if(retrieveAddress==""||retrieveAddress==null){
				alert("请填写对应上午号源取号地点！");
				return;
			}
		}
	
		var timespanStart = obj.parentNode.cells[0].childNodes[0].value;
		var timespanEnd = obj.parentNode.cells[1].childNodes[0].value;
		var resourceNum = obj.parentNode.cells[2].childNodes[0].value;
		if(timespanStart==""||timespanEnd==""||resourceNum==""){
			alert("请将此条号源信息补充完整！");
			return;
		}
		//var beginRegisterTime = obj.parentNode.cells[3].childNodes[0].value;
		//var overRegisterTime = obj.parentNode.cells[4].childNodes[0].value;
		
		var resource1 = ("{\"timespanStart\":\""+timespanStart+"\",\"timespanEnd\":\""+timespanEnd+"\",\"resourceTpye\":\""+resourceTpye+"\",\"resourceTpyeText\":\""+resourceTpyeText+"\",\"isTimespan\":\""+isTimespan+"\",\"ampm\":\""+ampm+"\",\"departmentId\":\""+departmentId+"\",\"doctorId\":\""+doctorId+"\",\"beginRegisterTime\":\""+beginRegisterTime+"\",\"overRegisterTime\":\""+overRegisterTime+"\",\"resourceNum\":\""+resourceNum+"\",\"resourceDate\":\""+resourceDate+"\",\"expense\":\""+expense+"\",\"retrieveAddress\":\""+retrieveAddress+"\"}");
	}else{
		resourceTpye = obj.parentNode.cells[1].getElementsByTagName("select")[0].value;
		var obj1 = obj.parentNode.cells[1].getElementsByTagName("select")[0];
		resourceTpyeText =obj1.options[obj1.selectedIndex].text;
		var expense = obj.parentNode.cells[2].childNodes[0].value;
		var retrieveAddress = obj.parentNode.cells[3].childNodes[0].value;
		var resourceNum = obj.parentNode.cells[4].childNodes[0].value;
		if(expense==""||retrieveAddress==""||resourceNum==""){
			alert("请将此条号源信息补充完整！");
			return;
		}
		//var resourceNum = obj.parentNode.cells[1].childNodes[0].value;
		//var beginRegisterTime = obj.parentNode.cells[2].childNodes[0].value;
		//var overRegisterTime = obj.parentNode.cells[3].childNodes[0].value;
		var resource1 = ("{\"resourceTpye\":\""+resourceTpye+"\",\"resourceTpyeText\":\""+resourceTpyeText+"\",\"isTimespan\":\""+isTimespan+"\",\"ampm\":\""+ampm+"\",\"doctorId\":\""+doctorId+"\",\"beginRegisterTime\":\""+beginRegisterTime+"\",\"overRegisterTime\":\""+overRegisterTime+"\",\"resourceNum\":\""+resourceNum+"\",\"resourceDate\":\""+resourceDate+"\",\"expense\":\""+expense+"\",\"departmentId\":\""+departmentId+"\",\"retrieveAddress\":\""+retrieveAddress+"\"}");
	}
	var resource = eval('(' + resource1 + ')');
	var url = ctx+"/sourcesDet/save";
	$.ajax({
        type: "POST",
        url:url,
        dataType: "json",
        contentType:"application/json",
        data:$.toJSON(resource), 
        success: function(data){
       	 alert(data.message);
       	 window.location.reload();
        }
    });   
}

function selecType(obj,type){
	if(type==1){//上午
		var amResourceTpyeText = obj.options[obj.selectedIndex].text;
		//console.log("rtbamTypeText : " + amResourceTpyeText);
		$("#amResourceTpyeText").val(amResourceTpyeText);
	}else if(type==2){//下午
		var pmResourceTpyeText = obj.options[obj.selectedIndex].text;
		$("#pmResourceTpyeText").val(pmResourceTpyeText);
	}
	
}
function editNum(objOne,resourceId){
	var obj=objOne.parentNode;
	var isTimespan = $("#isTimespan").val();
	var resourceNum = 0;
	var expense = "";
	var retrieveAddress = "";
	var resourceTpye="";
	var resourceTpyeText ="";
	if(isTimespan==1){
		resourceNum = obj.parentNode.cells[2].childNodes[0].value;
	}else{
		resourceTpye = obj.parentNode.cells[1].getElementsByTagName("select")[0].value;
		var obj1 = obj.parentNode.cells[1].getElementsByTagName("select")[0];
		resourceTpyeText =obj1.options[obj1.selectedIndex].text;
		expense = obj.parentNode.cells[2].childNodes[0].value;
		retrieveAddress = obj.parentNode.cells[3].childNodes[0].value;
		resourceNum = obj.parentNode.cells[4].childNodes[0].value;
	}
	//alert(resourceId);
	//alert("resourceTpye="+resourceTpye+"resourceTpyeText="+resourceTpyeText+"expense="+expense+"retrieveAddress="+retrieveAddress+"resourceNum="+resourceNum);
	var url = ctx+"/sourcesDet/updateNum";
	$.post(url,{'resourceId':resourceId,'resourceTpye':resourceTpye,'resourceTpyeText':resourceTpyeText,'expense':expense,'retrieveAddress':retrieveAddress,'resourceId':resourceId,'resourceNum':resourceNum},function (data){
		if(data.success){
			alert(data.message);
			window.location.reload();
		}
	});
}

function editNum1(objOne,resourceId){
	var obj=objOne.parentNode;
	var isTimespan = $("#isTimespan").val();
	var resourceNum = 0;
	if(isTimespan==1){
		resourceNum = obj.parentNode.cells[2].childNodes[0].value;
	}else{
		resourceNum = obj.parentNode.cells[1].childNodes[0].value;
	}
	var url = ctx+"/sourcesDet/updateNum";
	$.post(url,{'resourceNum':resourceNum,'resourceId':resourceId},function (data){
		if(data.success){
			alert(data.message);
		}
	});
}

function delOne(resourceId){
	$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
		$.get("${ctx}/sourcesDet/delete/"+resourceId, function(json) {
			var msg = "";
			if (json.message) {
				msg = json.message;
			}
			$.alert(msg, function() {
				var sourceList = '${sourceList}';
				var doctorId = $("#doctorId").val();
				var doctorName = $("#doctorName").val();
				var hospId = $("#hospId").val();
				var departmentId = "${departmentId}";
				var ctx = "${ctx}";
				//var url = ctx+"/sourcesDet/list?doctorId="+doctorId+"&doctorName="+doctorName+"&hospId="+hospId+"&departmentId="+departmentId;
				//window.location.href=url;
				window.location.reload();
			});
		}, "json");
	});
}

function editHour(){
	var url = ctx+"/sourcesDet/updateRT";
	var beginRegisterTime = $("#beginRegisterTime").val();
	var overRegisterTime = $("#overRegisterTime").val();
	$.post(url,{'beginRegisterTime':beginRegisterTime,'overRegisterTime':overRegisterTime},function (data){
		if(data.success){
			alert(data.message);
		}
	});
}

function editResType(resourceTpye){
	var url = ctx+"/sourcesDet/updateRT";
	var doctorId = $("#doctorId").val();
	var resourceDate = $("#resourceDate").val();
	var resourceTpye = $("#resourceTpye").val();
	var resourceTpyeText = $("#resourceTpyeText").val();
	$.post(url,{'doctorId':doctorId,'resourceDate':resourceDate,'resourceTpye':resourceTpye,'resourceTpyeText':resourceTpyeText},function (data){
		if(data.success){
			alert(data.message);
		}
	});
	
}
function setValue(obj){
	//给挂号类型名称赋值
	var resourceTpyeText = obj.options[obj.selectedIndex].text;
	var resourceTpye = obj.options[obj.selectedIndex].value;
	$("#resourceTpyeText").val(resourceTpyeText);
	$("#resourceTpye").val(resourceTpye);
}


</script>
</body>
</html>