<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>可预约号源列表</title>
<style>
#divSCA
      {
          position: fixed !important;
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
	
		<label style="font-size:20px;">${registrationRecord.hospName}-${registrationRecord.departmentName}-${registrationRecord.doctorName}-可预约号源列表：</label>
	<div>
	<input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/>
	<div class="panel panel-default">
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">日期</th>
				<th class="text-center">星期</th>
				<th class="text-center">上下午</th>
				<th class="text-center">挂号类型</th>
				<th class="text-center">价格</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${resourceList}" var="resource" varStatus="status">
			<tr>
				<td><fmt:formatDate value="${resource.resourceDate}" pattern="yyyy-MM-dd"/></td>
				<td>
				<c:if test="${resource.week==7}">星期日</c:if>
				<c:if test="${resource.week==6}">星期六</c:if>
				<c:if test="${resource.week==5}">星期五</c:if>
				<c:if test="${resource.week==4}">星期四</c:if>
				<c:if test="${resource.week==3}">星期三</c:if>
				<c:if test="${resource.week==2}">星期二</c:if>
				<c:if test="${resource.week==1}">星期一</c:if>
				</td>
				<td>
				<c:if test="${resource.ampm==1}">上午</c:if>
				<c:if test="${resource.ampm==2}">下午</c:if>
				</td>
				<td>${resource.resourceTpyeText}</td>
				<td>${resource.expense}</td>
				<td>
					<c:if test="${resource.resourceStatus==2}">约满</c:if>
					<c:if test="${resource.resourceStatus!=2}">
						<button type="button"  class="btn btn-primary" 
						onclick="setResId('${resource.resourceTpyeText}','${resource.resourceTpye}','${resource.expense}','${resource.agentId}','${resource.hospId}','${resource.departmentId}','${resource.resourceId}',
						'<fmt:formatDate value="${resource.resourceDate}" pattern="yyyy-MM-dd"/>',
						'${resource.ampm}','${resource.retrieveAddress}');">预约</button>
					</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
	
	<div id="divSCA">
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/webregister/patientList" method="POST">
	<input id="resourceId" name="resourceId" type="hidden"/>
	<input id="retrieveAddress" name="retrieveAddress" type="hidden"/>
	<input id="creatorId" name="creatorId" type="hidden" value="${registrationRecord.creatorId}"/>
	<input id="creatorName" name="creatorName" type="hidden" value="${registrationRecord.creatorName}"/>


	<input id="agentId" name="agentId" type="hidden" value="${registrationRecord.agentId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${registrationRecord.hospId}"/>
	<input id="hospName" name="hospName" type="hidden" value="${registrationRecord.hospName}"/>
	<input id="doctorId" name="doctorId" type="hidden" value="${registrationRecord.doctorId}"/>
	<input id="doctorName" name="doctorName" type="hidden" value="${registrationRecord.doctorName}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${registrationRecord.departmentId}"/>
	<input id="departmentName" name="departmentName" type="hidden" value="${registrationRecord.departmentName}"/>
	
	<input id="resourceTpye" name="resourceTpye" type="hidden" value="${registrationRecord.resourceTpye}"/>
	<input id="resourceTpyeText" name="resourceTpyeText" type="hidden" value="${registrationRecord.resourceTpyeText}"/>
	<input id="diagnosisDate" name="diagnosisDate" type="hidden" />
	<input id="memberId" name="memberId" type="hidden" value="${registrationRecord.memberId}"/>
	<input id="ampm" name="ampm" type="hidden" value="${registrationRecord.ampm}"/>
	<input id="timespanStart" name="timespanStart" type="hidden" value="${registrationRecord.timespanStart}"/>
	<input id="timespanEnd" name="timespanEnd" type="hidden" value="${registrationRecord.timespanEnd}"/>
	<input id="expense" name="expense" type="hidden" value="${registrationRecord.expense}"/>	
	<input id="vip" name="vip" type="hidden" value="${vip}"/>	
	<input id="hospConfig" name="hospConfig" type="hidden" value="${hospConfig}"/>
	<input id="thirdpartyId" name="thirdpartyId" type="hidden" value="${thirdpartyId}"/>	
	<input id="dutyGradeRelId" name="dutyGradeRelId" type="hidden" value="${dutyGradeRelId}"/>	

	<input type="button" id="close" value="关闭" onclick="closeDiv()">
	<br/><br/>
	<c:if test="${vip!=2 && vip!=3 && vip !=4 && vip !=5}">
		<div class="form-group">
				<label for="phoneNum" class="col-sm-2 control-label">手机号：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="phoneNum" name="phoneNum" placeholder="手机号">
				</div>
				<div class="col-sm-5 help-block Validform_checktip">用户注册手机号</div>
				<br/><br/><span id="wmessage1" style="color:red;margin-left:180px"></span>
				
		</div>
	</c:if>
	
	<div class="form-group" style="display:none" id="time">
	<label for="timeSp" class="col-sm-2 control-label">时间：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="timeSp" style="width:150px;height:25px" onchange="setVal(this.value);">
				</select>
			</div>
			<br/><br/><span id="wmessage2" style="color:red;margin-left:180px"></span>
	</div>
	<br/><br/><br/><br/>
	<div style="margin-left:180px">
	<button type="button" id="patBut" onclick="gotoPatient();" class="btn btn-primary">预 约</button></div>
	</form>
	</div>
	<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	$("#agentId").val("");
	$("#resourceId").val("");
});
function setResId(resourceTpyeText,resourceTpye,expense,agentId,hospId,departmentId,resourceId,resourceDate,ampm,retrieveAddress){
	//alert(resourceTpyeText+","+resourceTpye+","+expance+","+agentId+","+hospId+","+departmentId+","+resourceId+","+isTimeSpan+","+resourceDate+","+ampm+".");
	var doctorId = $("#doctorId").val();
	var vip = $("#vip").val();
	var url = ctx+"/register/getTimeSpan";
	$("#resourceTpyeText").val(resourceTpyeText);
	$("#ampm").val(ampm);
	$("#expense").val(expense);
	$("#resourceDate").val(resourceDate);
	$("#diagnosisDate").val(resourceDate);
	$("#resourceId").val(resourceId);
	$("#retrieveAddress").val(retrieveAddress);
	var _flag = false;
	$.ajax({ 
		type : "post",  
		url : ctx+"/register/getTimeSpan",  
		data : {'resourceTpyeText':resourceTpyeText,'resourceTpye':resourceTpye,'expense':expense,'resourceId':resourceId,'agentId':agentId,'hospId':hospId,'departmentId':departmentId,'doctorId':doctorId,'resourceDate':resourceDate,'ampm':ampm,'vip':vip},  
		async : false,  
		success : function(data){  
			if(!data.success){
				json = eval(data);
				var flag = false;
				if(typeof json=="string"){//约满
					alert(json.substring(4,json.length));
					return;
				}else{
					_flag = true;
					for(var i=0; i<json.length; i++) 
					{
						var isTimespan = json[i].isTimespan;
						if(isTimespan==2){
							flag = true;//不分时段
							break;
						}
					}
				}
				if(flag){//不分时段
					//$("#resourceId").val(resourceId);
					$("#agentId").val(agentId);
					$("#hospConfig").val(json[0].hospConfig);//第三方合作医院挂号需要的数据（card,cardpassword）
					$("#thirdpartyId").val(json[0].thirdpartyId);//第三方合作医院号源Id
					
					//$("#ampm").val(json[0].ampm);
					$("#departmentId").val(json[0].departmentId);
					$("#departmentName").val(json[0].departmentName);
					$("#doctorId").val(json[0].doctorId);
					$("#doctorName").val(json[0].doctorName);
					//$("#expense").val(json[0].expense);
					$("#hospId").val(json[0].hospId);
					$("#hospName").val(json[0].hospName);
					$("#resourceTpye").val(json[0].resourceTpye);
					//$("#diagnosisDate").val(json[0].resourceDate);
					$("#timespanEnd").val(json[0].timespanEnd);
					$("#timespanStart").val(json[0].timespanStart);
					$("#dutyGradeRelId").val(json[0].dutyGradeRelId);
					//("#resourceTpyeText").val(json[0].resourceTpyeText);
					document.getElementById("time").style.display="block";
					var option = "";
					if(ampm=='1'){
						option = $("<option>").val(0).text("上午");	
					}
					if(ampm=='2'){
						option = $("<option>").val(0).text("下午");
					}
				    $("#timeSp").append(option); 
					//$("#timeSp").append("不分时段");
				}else{//分时段
					$("#resourceId").val("");
					document.getElementById("time").style.display="block";
					$("#timeSp").empty(); 
				    var option = "";
				    option = $("<option>").val(0).text("请选择");
				    $("#timeSp").append(option); 

					for(var i=0; i<json.length; i++) 
					{ 
						var rsid = json[i].resourceId;
						var third = json[i].agentId+"@"+json[i].ampm+"@"+json[i].departmentId+"@"+json[i].departmentName+"@"+json[i].doctorId+"@"+json[i].doctorName+"@"+json[i].expense+"@"+json[i].hospId+"@"+json[i].hospName+"@"+json[i].resourceDate+"@"+json[i].resourceTpye+"@"+json[i].resourceDate+"@"+json[i].timespanEnd+"@"+json[i].timespanStart+"@"+json[i].resourceTpyeText+"@"+json[i].resourceId+"@"+json[i].hospConfig+"@"+json[i].thirdpartyId+"@"+json[i].dutyGradeRelId;
						option = $("<option>").val(third).text(json[i].timespanStart);
					    $("#timeSp").append(option);
					    
//						if(rsid!="" && typeof(rsid)!="undefined"){
//							option = $("<option>").val(rsid).text(json[i].timespanStart);
//						    $("#timeSp").append(option); 
//						}else{
//							option = $("<option>").val(third).text(json[i].timespanStart);
//							$("#timeSp").append(option);
//						}
					} 
				}
			}
		}  
    });
	if(_flag){
		openDiv();
	}
}
function setVal(resourceId){
//	if(resourceId.length>50){
		var strs = resourceId.split("@");
		//json[i].agentId+"@"+json[i].ampm+"@"+json[i].departmentId+"@"+json[i].departmentName+"@"+json[i].doctorId+"@"+json[i].doctorName+
		//"@"+json[i].expense+"@"+json[i].hospId+"@"+json[i].hospName+"@"+json[i].resourceDate+"@"+json[i].resourceTpye+"@"+json[i].specialtyDesc
		//+"@"+json[i].timespanEnd+"@"+json[i].timespanStart;
		$("#agentId").val(strs[0]);
		$("#ampm").val(strs[1]);
		$("#departmentId").val(strs[2]);
		$("#departmentName").val(strs[3]);
		$("#doctorId").val(strs[4]);
		$("#doctorName").val(strs[5]);
		$("#expense").val(strs[6]);
		$("#hospId").val(strs[7]);
		$("#hospName").val(strs[8]);
		$("#resourceTpye").val(strs[10]);
		$("#diagnosisDate").val(strs[11]);
		$("#timespanEnd").val(strs[12]);
		$("#timespanStart").val(strs[13]);
		$("#resourceId").val(resourceId);
		$("#resourceTpyeText").val(strs[14]);
		$("#resourceId").val(strs[15]);
		$("#hospConfig").val(strs[16]);
		$("#thirdpartyId").val(strs[17]);
		$("#dutyGradeRelId").val(strs[18]);
//	}else{
//		var start = $("#timeSp").find("option:selected").text();
//		$("#timespanStart").val(start);
//		$("#resourceId").val(resourceId);
//	}
}
function gotoPatient(){
	var vip = $("#vip").val();
	var agentId = $("#agentId").val();
	if(vip=='2' || vip=='3' || vip == '4' || vip=='5'){
		var resourceId = $("#resourceId").val();

		if(agentId.length>0){
			//第三方挂号，resourceId为空.
		}else{
			if(resourceId==""){
				$('#wmessage2').text("请选择时间段！");
				return;
			}
			if(resourceId.length>50){
				$("#resourceId").val("");
			}
		}
		this.form1.submit();
	}else{
		var phoneNum = $("#phoneNum").val();
		var resourceId = $("#resourceId").val();
		if(phoneNum==""){
			$('#wmessage1').text("请填写手机号！");
			return;
		}
	    if(phoneNum.length!=11)
	    {
	        $('#wmessage1').text("请输入有效的手机号码！");
			return;
	    }
	    var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
	    if(!myreg.test(phoneNum))
	    {
	        $('#wmessage1').text("请输入有效的手机号码！");
			return;
	    }
	    var flag = false;
		$.ajax({  
			type : "post",  
			url : ctx+"/register/checkMobile",  
			data : "phoneNum=" + phoneNum,  
			async : false,  
			success : function(data){  
				flag  = eval("(" + data + ")");  
				
			}  
	    });
		if(!flag){
			$('#wmessage1').text("此号码未找到注册用户！");
			return;
		}
		if(agentId.length>0){
			//第三方医院			
		}else{
			if(resourceId==""){
				$('#wmessage2').text("请选择时间段！");
				return;
			}
		}
		if(resourceId.length>50){
			$("#resourceId").val("");
		}
		
		this.form1.submit();
	}
}
function openDiv() {
	$("#divSCA").OpenDiv();
}

function closeDiv() {
	$("#resourceId").val("");
	document.getElementById("time").style.display="block";
	$("#timeSp").empty(); 
	$("#divSCA").CloseDiv();	
}
</script>
</body>
</html>