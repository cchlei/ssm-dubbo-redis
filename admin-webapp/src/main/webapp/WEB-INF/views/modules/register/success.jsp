<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>挂号成功页面</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/register/industry" method="POST">
		<input id="recordId" name="recordId" type="hidden" value="${recordId}"/>
		<div >
			<h4 ></br></br>
	<c:if test="${message!=null}">${message}</c:if>
			</h4>
		</div>
	<c:if test="${message==null}">
		<label style="font-size:20px;margin-left:65px;">
			<c:if test="${registrationRecord.isGuide==1 || registrationRecord.isGuide==2}">预约成功!</c:if>
			<c:if test="${registrationRecord.isGuide==5}">预约排队中</c:if>
		</label>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">就诊医院：</label>
			<div class="col-sm-5">
			${registrationRecord.hospName}
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">科室：</label>
			<div class="col-sm-5">
			${registrationRecord.departmentName}
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">科室医生：</label>
			<div class="col-sm-5">
			${registrationRecord.doctorName}
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">门诊类型：</label>
			<div class="col-sm-5">
			${resource.resourceTpyeText}
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">挂号费用：</label>
			<div class="col-sm-5">
			${resource.expense}
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">支付方式：</label>
			<div class="col-sm-5">
			去医院支付
			</div>
		</div>
		---------------------------------------------------------------------------------
	    <div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">就诊日期：</label>
			<div class="col-sm-5">
				<fmt:formatDate value="${resource.resourceDate}" pattern="yyyy-MM-dd"/>&nbsp;
				<c:if test="${resource.week==7}">星期日</c:if>
				<c:if test="${resource.week==6}">星期六</c:if>&nbsp;
				<c:if test="${resource.week==5}">星期五</c:if>&nbsp;
				<c:if test="${resource.week==4}">星期四</c:if>&nbsp;
				<c:if test="${resource.week==3}">星期三</c:if>&nbsp;
				<c:if test="${resource.week==2}">星期二</c:if>&nbsp;
				<c:if test="${resource.week==1}">星期一</c:if>&nbsp;
				<c:if test="${resource.ampm==1}">上午</c:if>
				<c:if test="${resource.ampm==2}">下午</c:if>	
				<c:if test="${resource.timespanStart!=''}">
				<fmt:formatDate value="${resource.timespanStart}" pattern="HH:mm"/>
				</c:if>	
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">取号时间：</label>
			<div class="col-sm-5">
			${registrationRecord.retrieveTime}
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">取号地点：</label>
			<div class="col-sm-5">
			${registrationRecord.retrieveAddress}
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">重发短信：</label>
			<div class="col-sm-5">
			<button type="button" class="btn btn-primary" onclick="sendsms('${registrationRecord.registrationRecordId}')">重 发 </button>
			</div>
		</div>
		
		---------------------------------------------------------------------------------
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">患者姓名：</label>
			<div class="col-sm-5">
			${registrationRecord.patientName}
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">
			<c:if test="${registrationRecord.idType==1}">身份证号：</c:if>
			<c:if test="${registrationRecord.idType==2}">社保卡：</c:if>
			<c:if test="${registrationRecord.idType==3}">驾驶证：</c:if>
			<c:if test="${registrationRecord.idType==0}">其他：</c:if>
			</label>
			<div class="col-sm-5">
			${registrationRecord.idCard}
			</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">手机号：</label>
			<div class="col-sm-5">
			${registrationRecord.phoneNum}
			</div>
		</div>
	</c:if>		
		<c:choose>
			<c:when test="${vip==1}">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn" style="color:white; background-color: blue;" onclick="history.go(-2)">返 回</button>
			</c:when>  
			<c:when test="${vip==2}">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn" onclick="history.go(-3)">返 回</button> &nbsp;&nbsp;&nbsp;&nbsp;
                <button type="button" class="btn btn-primary btn-sm" onclick="preView('${registrationRecord.hospName}','${registrationRecord.patientName}','${registrationRecord.phoneNum}','${registrationRecord.idCard}','${registrationRecord.departmentName}','${registrationRecord.doctorName}','<fmt:formatDate value='${registrationRecord.diagnosisDate}' pattern='yyyy-MM-dd'/>','${registrationRecord.expenseText}','${registrationRecord.retrieveAddress}','<fmt:formatDate value='${registrationRecord.registrationDate}' pattern='yyyy-MM-dd HH:mm:ss'/>','${registrationRecord.retrieveTime}','${registrationRecord.ampm}','<fmt:formatDate value='${registrationRecord.timespanStart}' pattern='HH:mm'/>','<fmt:formatDate value='${registrationRecord.timespanEnd}' pattern='HH:mm'/>');">打 印 </button>
			</c:when>
		    <c:when test="${vip==3}">
		    	<c:if test="${message==null}">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="">录入项目信息</button>
		    	</c:if>
		    	<c:if test="${message!=null}">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn" onclick="history.go(-3)">返 回</button>
		    	</c:if>
			</c:when>
			<c:otherwise>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn" onclick="history.go(-3)">返 回</button>
			</c:otherwise>  
		</c:choose> 
		<!-- 
		<c:if test="${vip==1}">
		<button type="button" class="btn" style="color:white; background-color: blue;" onclick="history.go(-2)">返 回</button>
		</c:if>
		<c:if test="${vip!=1}">
		<button type="button" class="btn" onclick="history.go(-3)">返 回</button>
		</c:if>
		 -->
</form>
<div id="printer" style="display:none">
	<br/>
	<div style="padding:0 0.6cm;text-align:center;">
		<h2><span>导医通</span> </h2>
		<h2><span id="p_hospname"></span> </h2>
   		<span style="font-size: 14px; ">现场实名制预约回执单</span>
	</div>
    <ul style='line-height:18px; font-size: 12px;list-style-type:none;margin:0.5cm 0.1cm 0.5cm 0.6cm;'>
    	<li>患者姓名:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_patientName"></span></li>
    	<li>联系电话:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_phoneNum"></span></li>
    	<li>证件号码:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_idCard"></span></li>
    	<li>预约科室:&nbsp;&nbsp;<span id="p_departmentName"></span></li>
    	<li>预约专家:&nbsp;&nbsp;<span id="p_doctorName"></span></li>
    	<li>就诊时间:&nbsp;&nbsp;<span id="p_diagnosisDate"></span></li>
    	<li>挂号费用:&nbsp;&nbsp;<span id="p_expenseText"></span></li>
    	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（请以医院公布价格为准）</li>
    	<li>取号时间:&nbsp;&nbsp;<span id="p_retrieveTime"></span></li>
    	<li>取号地点:&nbsp;&nbsp;<span id="p_retrieveAddress"></span></li>
    	<li>---------------------------------------------------------</li>
    	<li>取消预约:&nbsp;&nbsp;<span>（取消预约的注意事项）</span><div style='margin-bottom: 10px;'>请提早两个工作日致电400-920-2323.</div></li>
    	<li>停诊通知:&nbsp;&nbsp;<span>（停诊通知的注意事项）</span><div style='margin-bottom: 10px;'>未定</div></li>
  		<li>爽约:&nbsp;&nbsp;<span id="">（失约的处理）</span><div style='margin-bottom: 10px;'>爽约3次，您将进入导医通预约黑名单！</div></li>
    	<li><span id="p_registrationDate"></span><div style='margin-bottom: 10px;'>（预约当日的日期/时间）</div></li>
    	<li>---------------------------------------------------------</li>
    	<li>免责声明:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>未定</div></li>
    	<li>APP下载的二维码</li>
    	<li style="text-align:center;"><img width="100" height="100" alt="二维码" src="../static/images/dimBarCode.jpg"></li>
    </ul>
</div>	
<div id="printer_shzyyy" style="display:none">
	<br/>
	<div style="padding:0 0.6cm;text-align:center;">
		<h2><span>导医通</span> </h2>
		<h2><span id="p_hospname_shzyyy"></span> </h2>
   		<span style="font-size: 14px; ">现场实名制预约回执单</span>
	</div>
    <ul style='line-height:18px; font-size: 12px;list-style-type:none;margin:0.5cm 0.1cm 0.5cm 0.6cm;'>
    	<li>患者姓名:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_patientName_shzyyy"></span></li>
    	<li>联系电话:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_phoneNum_shzyyy"></span></li>
    	<li>证件号码:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_idCard_shzyyy"></span></li>
    	<li>预约科室:&nbsp;&nbsp;<span id="p_departmentName_shzyyy"></span></li>
    	<li>预约专家:&nbsp;&nbsp;<span id="p_doctorName_shzyyy"></span></li>
    	<li>挂号时间:&nbsp;&nbsp;<span id="p_diagnosisDate_shzyyy"></span></li>
    	<li>挂号费用:&nbsp;&nbsp;<span id="p_expenseText_shzyyy"></span></li>
    	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（请以医院公布价格为准）</li>
    	<li>备注:&nbsp;&nbsp;<span id="p_retrieveTime_shzyyy"></span></li>
    	<li>取号地点:&nbsp;&nbsp;<span id="p_retrieveAddress_shzyyy"></span></li>
    	<li>---------------------------------------------------------</li>
    	<li>取消预约:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>请提早两个工作日致电400-920-2323.</div></li>
  		<li>爽约:&nbsp;&nbsp;<span id=""></span><div style='margin-bottom: 10px;'>爽约3次，您将进入导医通预约黑名单！</div></li>
    	<li><span id="p_registrationDate_shzyyy"></span><div style='margin-bottom: 10px;'>（预约当日的日期/时间）</div></li>
    	<li>---------------------------------------------------------</li>
    	<li>APP下载的二维码</li>
    	<li style="text-align:center;"><img width="100" height="100" alt="二维码" src="../static/images/dimBarCode.jpg"></li>
    </ul>
</div>
<div id="printer_fdzsyy" style="display:none">
	<br/>
	<div style="padding:0 0.6cm;text-align:center;">
		<h2><span>导医通</span> </h2>
		<h2><span id="p_hospname_fdzsyy"></span> </h2>
   		<span style="font-size: 15px; ">现场实名制预约回执单</span>
	</div>
    <ul style='line-height:18px; font-size: 16px;list-style-type:none;margin:0.5cm 0.1cm 0.5cm 0.6cm;'>
    	<li>患者姓名:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_patientName_fdzsyy"></span></li>
    	<li>联系电话:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_phoneNum_fdzsyy"></span></li>
    	<li>证件号码:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_idCard_fdzsyy"></span></li>
    	<li>预约科室:&nbsp;&nbsp;<span id="p_departmentName_fdzsyy"></span></li>
    	<li>预约专家:&nbsp;&nbsp;<span id="p_doctorName_fdzsyy"></span></li>
    	<li>就诊时间:&nbsp;&nbsp;<span id="p_diagnosisDate_fdzsyy"></span></li>
    	<li>挂号费用:&nbsp;&nbsp;<span id="p_expenseText_fdzsyy"></span></li>
    	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 14px; ">（请以医院公布价格为准）</span></li>
    	<li>取号时间:&nbsp;&nbsp;<span id="p_retrieveTime_fdzsyy"></span></li>
    	<li>取号地点:&nbsp;&nbsp;<span id="p_retrieveAddress_fdzsyy"></span></li><br/><br/>
    	<li>-------------------------------------</li>
    	<li>取消预约:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>请提早两个工作日致电400-920-2323.</div></li>
    	<li>停诊通知:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>未定.</div></li>
  		<li>爽约:&nbsp;&nbsp;<span id=""></span><div style='margin-bottom: 10px;'>爽约3次，您将进入导医通预约黑名单！</div></li>
    	<li><span id="p_registrationDate_fdzsyy"></span><div style='margin-bottom: 10px;'>（预约当日的日期/时间）</div></li>
    	<li>-------------------------------------</li><br/><br/>
    	<li>免责声明:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>未定.</div></li>
    	<li>APP下载的二维码</li>
    	<li style="text-align:center;"><img width="100" height="100" alt="二维码" src="../static/images/fdzsyyDimBarCode.jpg"></li>
    </ul>
</div>		
<script type="text/javascript">
var ctx = "${ctx}";
function sendsms(registrationRecordId){
	var url = ctx+"/register/sendsms";
	$.post(url,{'recordId':registrationRecordId},function(json){
		if(json=='success'){
			alert('短信已重新发送');
		}
	});
}
var LODOP ;
function preView(hospName,patientName,phoneNum,idCard,departmentName,doctorName,diagnosisDate,expenseText,retrieveAddress,registrationDate,retrieveTime,ampm,timestamp,endtimestamp){
	LODOP = getLodop();
    LODOP.PRINT_INIT("");
    LODOP.SET_PRINT_PAGESIZE(3,800,300,"");//这里3表示纵向打印且纸高“按内容的高度”；300表示纸宽30.0mm；30表示页底空白3.0mm
    if(ampm==1){
		ampm="上午";    	
    }
    if(ampm==2){
		ampm="下午";    	
    }
    if(hospName=="上海市中医医院" || hospName=="上海市中医医院石门路门诊部"){
        $("#p_hospname_shzyyy").text(hospName);
        $("#p_patientName_shzyyy").text(patientName);
        $("#p_phoneNum_shzyyy").text(phoneNum);
        $("#p_idCard_shzyyy").text(idCard);
        $("#p_departmentName_shzyyy").text(departmentName);
        $("#p_doctorName_shzyyy").text(doctorName);
        $("#p_diagnosisDate_shzyyy").text(diagnosisDate+" "+ampm+" "+timestamp+"-"+endtimestamp);
        $("#p_expenseText_shzyyy").text(expenseText);
        $("#p_registrationDate_shzyyy").text(registrationDate);
        $("#p_retrieveAddress_shzyyy").text(retrieveAddress);
        if(hospName=="上海市中医医院" ){
        	$("#p_retrieveTime_shzyyy").text("1号楼名专家只接受复诊预约");
        }
        if(hospName=="上海市中医医院石门路门诊部"){
        	$("#p_retrieveTime_shzyyy").text("");
        }
    	LODOP.ADD_PRINT_HTM(0,0,270,100,document.getElementById("printer_shzyyy").innerHTML);
    }else if(hospName=="复旦大学附属中山医院"){
        $("#p_hospname_fdzsyy").text(hospName);
        $("#p_patientName_fdzsyy").text(patientName);
        $("#p_phoneNum_fdzsyy").text(phoneNum);
        $("#p_idCard_fdzsyy").text(idCard);
        $("#p_departmentName_fdzsyy").text(departmentName);
        $("#p_doctorName_fdzsyy").text(doctorName);
        $("#p_diagnosisDate_fdzsyy").text(diagnosisDate+" "+ampm+" "+timestamp+"-"+endtimestamp);
        $("#p_expenseText_fdzsyy").text(expenseText);
        $("#p_retrieveAddress_fdzsyy").text(retrieveAddress);
        $("#p_registrationDate_fdzsyy").text(registrationDate);
        $("#p_retrieveTime_fdzsyy").text(retrieveTime);
        //LODOP.ADD_PRINT_RECT(0,0,305,505,2);
    	LODOP.ADD_PRINT_HTM(0,0,270,100,document.getElementById("printer_fdzsyy").innerHTML);  
    }else{
        $("#p_hospname").text(hospName);
        $("#p_patientName").text(patientName);
        $("#p_phoneNum").text(phoneNum);
        $("#p_idCard").text(idCard);
        $("#p_departmentName").text(departmentName);
        $("#p_doctorName").text(doctorName);
        $("#p_diagnosisDate").text(diagnosisDate+" "+ampm+" "+timestamp+"-"+endtimestamp);
        $("#p_expenseText").text(expenseText);
        $("#p_retrieveAddress").text(retrieveAddress);
        $("#p_registrationDate").text(registrationDate);
        $("#p_retrieveTime").text(retrieveTime);
        //LODOP.ADD_PRINT_RECT(0,0,305,505,2);
    	LODOP.ADD_PRINT_HTM(0,0,270,100,document.getElementById("printer").innerHTML);    	
    }
    
    LODOP.PREVIEW();
    //LODOP.PRINT();
}
</script>
</html>