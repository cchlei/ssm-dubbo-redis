<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>就诊人列表</title>
<style>
#divSCA
      {
          position: absolute;
          top:20px !important;
          width: 600px;
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
		<li class="active"><a href="javascript:void(0)">就诊人列表</a></li>
	</ul> -->
	<div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 就诊人列表 
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<th class="text-center">姓名</th>
				<th class="text-center">证件类型</th>
				<th class="text-center">证件号</th>
				<th class="text-center">医保卡类型</th>
				<th class="text-center">医保号</th>
				<th class="text-center">性别</th>
				<th class="text-center">手机号</th>
				<th class="text-center">是否本人</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${patientList}" var="patient" varStatus="status">
			<tr>
				<td>${patient.patientName}</td>
				<td>
					<c:if test="${patient.idType==1}">身份证</c:if>
					<c:if test="${patient.idType==2}">社保卡</c:if>	
					<c:if test="${patient.idType==3}">驾驶证</c:if>
					<c:if test="${patient.idType==0}">其他</c:if>				
				</td>
				<td>${patient.idNumber}</td>
				<td>
					<c:if test="${patient.medicareCardType==1}">医保卡</c:if>
					<c:if test="${patient.medicareCardType==2}">就诊卡</c:if>	
					<c:if test="${patient.medicareCardType==3}">自费</c:if>				
				</td>
				<td>${patient.medicareNumber}</td>
				<td>
					<c:if test="${patient.sex==1}">男</c:if>
					<c:if test="${patient.sex==2}">女</c:if>
				</td>
				<td>${patient.phoneNum}</td>
				<td>
					<c:if test="${patient.isSelf==1}">是</c:if>
					<c:if test="${patient.isSelf==2}">否</c:if>
				</td>
				<td>
					<button type="button"  class="btn btn-primary" onclick="setResId('${patient.patientId}','${patient.medicareCardType}','${patient.medicareNumber}','${patient.idNumber}','${patient.patientName}');">预 约</button>
				</td>
			</tr>
			</c:forEach> 
		</table>
	</div>
		<div >
			<h4 ></br></br>
				<c:if test="${message!=null}">${message}</c:if>
			</h4>
		</div>	
	<div id="divSCA">
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/register/register" method="POST">
	<input id="diagnosisDate" name="diagnosisDate" type="hidden" value="${diagnosisDate}"/>
	<input id="timespanStart" name="timespanStart" type="hidden" value="${timespanStart}"/>
	<input id="timespanEnd" name="timespanEnd" type="hidden" value="${timespanEnd}"/>
	<input id="visitType" name="visitType" type="hidden" value="${visitType}"/>

    <input id="resourceId" name="resourceId" type="hidden" value="${registrationRecord.resourceId}"/>
	<input id="phoneNum" name="phoneNum" type="hidden" value="${registrationRecord.phoneNum}"/>
	
	<input id="medicareCardType" name="medicareCardType" type="hidden" />
	<input id="medicareNumber" name="medicareNumber" type="hidden" />	
	<input id="patientId" name="patientId" type="hidden" />
	
	<input id="agentId" name="agentId" type="hidden" value="${registrationRecord.agentId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${registrationRecord.hospId}"/>
	<input id="hospName" name="hospName" type="hidden" value="${registrationRecord.hospName}"/>
	<input id="doctorId" name="doctorId" type="hidden" value="${registrationRecord.doctorId}"/>
	<input id="doctorName" name="doctorName" type="hidden" value="${registrationRecord.doctorName}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${registrationRecord.departmentId}"/>
	<%-- <input id="departmentId" name="departmentId" type="hidden" value="${registrationRecord.departmentId}"/> --%>
	<input id="departmentName" name="departmentName" type="hidden" value="${registrationRecord.departmentName}"/>
	<input id="retrieveAddress" name="retrieveAddress" type="hidden" value="${registrationRecord.retrieveAddress}"/>
	<input id="resourceTpye" name="resourceTpye" type="hidden" value="${registrationRecord.resourceTpye}"/>
	<input id="resourceTpyeText" name="resourceTpyeText" type="hidden" value="${registrationRecord.resourceTpyeText}"/>	
	<input id="memberId" name="memberId" type="hidden" value="${registrationRecord.memberId}"/>
	<input id="ampm" name="ampm" type="hidden" value="${registrationRecord.ampm}"/>
	<input id="expense" name="expense" type="hidden" value="${registrationRecord.expense}"/>	
	<input id="hospConfig" name="hospConfig" type="hidden" value="${hospConfig}"/>
	<input id="thirdParams" name="thirdParams" type="hidden" value="${thirdParams}"/>
	<input id="thirdValues" name="thirdValues" type="hidden" value="${thirdValues}"/>
	<input id="thirdpartyId" name="thirdpartyId" type="hidden" value="${registrationRecord.thirdpartyId}"/>	
	<input id="patientName" name="patientName" type="hidden" value="${patientName}"/>	
	<input id="dutyGradeRelId" name="dutyGradeRelId" type="hidden" value="${registrationRecord.dutyGradeRelId}"/>	
	
	
	<input type="button" id="close" value="关闭" onclick="closeDiv()">
	<br/><br/>
	<div class="form-group">
	<label for="visit" class="col-sm-2 control-label">初/复诊：</label>
			<div class="col-sm-5">
				<select style="width: 100px;"  id="isFirstVisit" name="isFirstVisit">
				    <option value="">请选择</option>
				    <c:if test="${visitType=='1'}">
				    	<option value="1">初诊</option>
				    </c:if>
						<option value="2">复诊</option>
				</select>	
			</div>
			<span id="vmessage" style="color:red;margin-left:40px"></span>
	</div>
	<div class="form-group" style="display:none" id="time">
	<label for="cardType" class="col-sm-2 control-label">医保类型：</label>
			<div class="col-sm-5">
				<select class="mSelect"  class="mSelect"  id="cardType" style="width:100px;height:25px" onchange="setVal(this.value);">
				</select>
			</div>
			<span id="wmessage2" style="color:red;margin-left:40px"></span>
	</div>
	<div class="form-group">
		<label for="cardNum" class="col-sm-2 control-label">卡号：</label>
		<div class="col-sm-5">
			<input type="text" class="form-control" id="cardNum" name="cardNum" placeholder="医保卡或就诊卡卡号">
		</div>
		<div class="col-sm-5 help-block Validform_checktip"></div>
		<span id="wmessage1" style="color:red;margin-left:40px"></span>
	</div>
	<c:forEach items="${thirdParams}" var="thirdParam" varStatus="status">
		<c:set var="thirdKey" value="${fn:split(thirdParam, '#')[0]}" />
		<c:set var="thirdLabel" value="${fn:split(thirdParam, '#')[1]}" />
		
		<div class="form-group">
			<label for="${thirdKey}" class="col-sm-2 control-label">
				${thirdLabel}:
				<!-- 
				<c:if test="${thirdParam=='cardNumber'}">第三方医院卡号：</c:if>
				<c:if test="${thirdParam=='cardPassword'}">第三方医院密码:</c:if>
				-->
			</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="${thirdKey}" name="${thirdKey}" placeholder="">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<span id="${thirdKey}Msg" style="color:red;margin-left:40px"></span>
		</div>
	</c:forEach>
	<c:if test="${exCode!=null && exCode==3001}">
		<div class="form-group">
			<label for="idNumber" class="col-sm-2 control-label">平台ID：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="idNumber" name="idNumber" placeholder="输入身份证">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<span id="id_12320_wmessage" style="color:red;margin-left:40px"></span>
		</div>
		<div class="form-group">
			<label for="pw12320" class="col-sm-2 control-label">平台密码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="pw12320" name="pw12320" placeholder="输入12320平台密码">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<span id="pw_12320_wmessage" style="color:red;margin-left:40px"></span>
		</div>
	</c:if>
	
	<br/><br/>
	<div style="margin-left:180px">
	<button type="button" id="patBut" onclick="gotoPatient();" class="btn btn-primary">预 约</button></div>
	</form>
	</div>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	
});
function setResId(patientId,type,cardNO,idNumber,patientName){
	if(type==""|| typeof(type)=="undefined"){
		type = 0;
	}
	$("#medicareCardType").val(type);
	$("#medicareNumber").val(cardNO);
	$("#patientId").val(patientId);
	$("#idNumber").val(idNumber);
	$("#idNumber").text(idNumber);
	$("#patientName").val(patientName);
	
	document.getElementById("time").style.display="block";
	$("#cardType").empty(); 
	var option = "";
	option = $("<option>").val(0).text("请选择");
	$("#cardType").append(option); 
	option = $("<option>").val(1).text("医保卡");
	$("#cardType").append(option);
	option = $("<option>").val(2).text("就诊卡");
	$("#cardType").append(option);
	option = $("<option>").val(3).text("自费");
	$("#cardType").append(option);
	$("#cardType").val(type);
	if(type=="1"||type=="2"){
		$("#cardNum").val(cardNO);
	}else{
		$("#cardNum").val("");
	}
	openDiv();
}
function setVal(type){
	var cardNO = $("#medicareNumber").val();
	if(type=="1"){
		$("#cardNum").val(cardNO);
	}else{
		$("#cardNum").val("");
	}
	$("#cardType").val(type);
}
function gotoPatient(){
	var cardType = $("#cardType").val();
	var cardNum = $("#cardNum").val();
	var isFirstVisit = $("#isFirstVisit").val();
	
	$("#medicareNumber").val(cardNum);
	$("#medicareCardType").val(cardType);
	
	if(isFirstVisit==""||isFirstVisit=="0"||  typeof(isFirstVisit)=="undefined"){
		$('#vmessage').text("请选择初/复诊类型！");
		return;
	}

	if(cardType==""||cardType=="0"||  typeof(cardType)=="undefined"){
		$('#wmessage2').text("请选择医保类型！");
		return;
	}
	if(cardType!="3"){
		if(cardNum==""){
			$('#wmessage1').text("请填写卡号！");
			return;
		}else{
			$('#wmessage1').text("");
		}
	}
	
	//第三方医院
	var array = new Array();
	var _thirdParams = new Array();
	<c:forEach items="${thirdParams}" var="a">
		<c:set var="thirdKey" value="${fn:split(a, '#')[0]}" />
	   	array.push(${thirdKey});
	</c:forEach>
	if(array.length>0){
		for(var i=0;i<array.length;i++){
			var param = array[i].id;
			var value = $('#'+param).val();
			if(value==""||  typeof(value)=="undefined"){
				$('#'+param+'Msg').text("请填写相关信息！");
				return;
			}else{
				$('#'+param+'Msg').text("");
				_thirdParams.push(param+"-"+value);
			}
		}
	}
	
	//12320平台验证
	var njCheck = "${exCode}";
	if(njCheck != "" && typeof(njCheck)!="undefined" && njCheck==3001){
		var pw12320 = $("#pw12320").val();
		var idNumber = $("#idNumber").val();
		if(idNumber==""||  typeof(idNumber)=="undefined"){
			$('#id_12320_wmessage').text("请填写身份证信息！");
			return;
		}
		if(pw12320==""||  typeof(pw12320)=="undefined"){
			$('#pw_12320_wmessage').text("请填写平台密码！");
			return;
		}
	}
	
	$("#thirdValues").val(_thirdParams);
	this.form1.submit();
}

function subObj(obj){
    $.each(obj,function(key,val){
        if($.isPlainObject(val) || $.isArray(val)){
            subObj(val);
        }else{
            alert(key+'='+val);
        }
    });
}
function openDiv() {
	$("#divSCA").OpenDiv();
}

function closeDiv() {
	$("#divSCA").CloseDiv();	
}
</script>
</body>
</html>