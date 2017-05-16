<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生信息编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<%-- <li><a href="${ctx}/hospDep/list?hospId=${hospId}">医院科室编辑</a></li> --%>
		<li class="active"><a href="javascript:void(0)">现场挂号  </a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form"  id="form" role="form" action="${ctx}/register/sceneregister" method="POST">
		<input id="diagnosisDate" name="diagnosisDate" type="hidden" value="<fmt:formatDate value='${registrationRecord.diagnosisDate}' pattern='yyyy-MM-dd'/>"/>
		<input id="timespanStart" name="timespanStart" type="hidden" value="${timespanStart}"/>
		<input id="timespanEnd" name="timespanEnd" type="hidden" value="${timespanEnd}"/>
	    <input id="resourceId" name="resourceId" type="hidden" value="${registrationRecord.resourceId}"/>
		
		<input id="agentId" name="agentId" type="hidden" value="${registrationRecord.agentId}"/>
		<input id="hospId" name="hospId" type="hidden" value="${registrationRecord.hospId}"/>
		<input id="hospName" name="hospName" type="hidden" value="${registrationRecord.hospName}"/>
		<input id="doctorId" name="doctorId" type="hidden" value="${registrationRecord.doctorId}"/>
		<input id="doctorName" name="doctorName" type="hidden" value="${registrationRecord.doctorName}"/>
		<input id="departmentId" name="departmentId" type="hidden" value="${registrationRecord.departmentId}"/>
		<input id="departmentName" name="departmentName" type="hidden" value="${registrationRecord.departmentName}"/>
		
		<input id="resourceTpye" name="resourceTpye" type="hidden" value="${registrationRecord.resourceTpye}"/>
		<input id="resourceTpyeText" name="resourceTpyeText" type="hidden" value="${registrationRecord.resourceTpyeText}"/>	
		<input id="memberId" name="memberId" type="hidden" value="${registrationRecord.memberId}"/>
		<input id="ampm" name="ampm" type="hidden" value="${registrationRecord.ampm}"/>
		<input id="expense" name="expense" type="hidden" value="${registrationRecord.expense}"/>	
		<input id="vip" name="vip" type="hidden" value="${vip}"/>	
		<input id="retrieveAddress" name="retrieveAddress" type="hidden" value="${registrationRecord.retrieveAddress}"/>
		
		<input id="thirdParams" name="thirdParams" type="hidden" value="${thirdParams}"/>
		<input id="thirdValues" name="thirdValues" type="hidden" value="${thirdValues}"/>
		<input id="thirdpartyId" name="thirdpartyId" type="hidden" value="${registrationRecord.thirdpartyId}"/>	
		<input id="dutyGradeRelId" name="dutyGradeRelId" type="hidden" value="${registrationRecord.dutyGradeRelId}"/>	
		<input id="visitType" name="visitType" type="hidden" value="${visitType}"/>

		<div class="form-group">
			<label for="patientName" class="col-sm-2 control-label"><span style="color:red;">*</span>患 者 姓 名：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="patientName" name="patientName" placeholder="患者姓名" datatype="*1-10"
					nullmsg="请输入患者姓名！" errormsg="患者姓名至少1个字符,最多10个字符！" value="${registrationRecord.patientName}" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>

		<div class="form-group">
			<label for="sex" class="col-sm-2 control-label">性&nbsp;&nbsp;别：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="sex" name="sex">
					<c:if test="${registrationRecord.sex==1||registrationRecord.sex==null}">
						<option value="1" selected="selected">男</option>
						<option value="2">女</option>
					</c:if>
					<c:if test="${registrationRecord.sex==2}">
						<option value="1" >男</option>
						<option value="2" selected="selected">女</option>
					</c:if>
				</select>		
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="isMarried" class="col-sm-2 control-label">是 否 已 婚：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="isMarried" name="isMarried">
					<c:if test="${registrationRecord.isMarried==1||registrationRecord.isMarried==null}">
						<option value="1" selected="selected">已婚</option>
						<option value="2">未婚</option>
					</c:if>
					<c:if test="${registrationRecord.isMarried==2}">
						<option value="1" >已婚</option>
						<option value="2" selected="selected">未婚</option>
					</c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="birthday" class="col-sm-2 control-label">出 生 日 期：</label>
			<div class="col-sm-5">
				<input class="Wdate" type="text" name="birthday" id="birthday"  onClick="WdatePicker()" value="<fmt:formatDate value='${registrationRecord.birthday}' pattern='yyyy-MM-dd'/>">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>		
		<div class="form-group">
			<label for="phoneNum" class="col-sm-2 control-label"><span style="color:red;">*</span>手&nbsp;机 &nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="phoneNum" name="phoneNum" placeholder="手机号" datatype="m"
					nullmsg="请输入手机号！" errormsg="请输入正确的手机号！" value="${registrationRecord.phoneNum}">
			</div>
			<div>
				<button type="button" onclick="getDataByPhone();">自动填充数据</button>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<!-- 
		<div class="form-group">
			<label for="email" class="col-sm-2 control-label"><span style="color:red;">*</span>邮&nbsp;箱：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="email" name="email" placeholder="邮箱" datatype="e"
					nullmsg="请输入邮箱地址！" errormsg="请输入正确的邮箱地址！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		 -->
		<div class="form-group">
			<label for="patientAddress" class="col-sm-2 control-label">患 者 地 址：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="patientAddress" name="patientAddress" placeholder="患者地址" datatype="*0-30"
					nullmsg="请输入患者地址！" errormsg="请输入30个以内的字符！" value="${registrationRecord.patientAddress}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group"> 
			<label for="diagnosisDate" class="col-sm-6 control-label">就诊医院：${registrationRecord.hospName} - 科室：${registrationRecord.departmentName} - 医生：${registrationRecord.doctorName}</label>
		</div>
		<div class="form-group"> 
			<label for="diagnosisDate" class="col-sm-2 control-label"> 就 诊 时 间：</label>
			<div class="col-sm-5">
				<fmt:formatDate value="${registrationRecord.diagnosisDate}" pattern="yyyy-MM-dd"/>
				<c:if test="${registrationRecord.ampm==1}">上午</c:if>
				<c:if test="${registrationRecord.ampm==2}">下午</c:if>
				<c:if test="${! empty registrationRecord.timespanStart}">
					<fmt:formatDate value="${registrationRecord.timespanStart}" pattern="hh:mm"/> - 
				<fmt:formatDate value="${registrationRecord.timespanEnd}" pattern="hh:mm"/>  
				</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="resourceTpye" class="col-sm-2 control-label"> 挂 号 类 型：</label>
			<div class="col-sm-5">
				${registrationRecord.resourceTpyeText}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="successfulRegisteredNum" class="col-sm-2 control-label">挂&nbsp;号&nbsp;费：</label>
			<div class="col-sm-4">
				${registrationRecord.expense}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>		
		
		<div class="form-group">
			<label for="idType" class="col-sm-2 control-label"><span style="color:red;">*</span>证 件 类 型：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="idType" name="idType">
					<c:if test="${registrationRecord.idType==1||registrationRecord.idType==null}">
						 <option value="1" selected="selected">身份证</option>
						 <option value="2">社保卡</option>
						 <option value="3">驾驶证</option>
						 <option value="0">其它</option>
					</c:if>
					<c:if test="${registrationRecord.idType==2}">
						 <option value="1">身份证</option>
						 <option value="2" selected="selected">社保卡</option>
						 <option value="3">驾驶证</option>
						 <option value="0">其它</option>
					</c:if>		
					<c:if test="${registrationRecord.idType==3}">
						 <option value="1">身份证</option>
						 <option value="2">社保卡</option>
						 <option value="3" selected="selected">驾驶证</option>
						 <option value="0">其它</option>
					</c:if>	
					<c:if test="${registrationRecord.idType==0}">
						 <option value="1">身份证</option>
						 <option value="2">社保卡</option>
						 <option value="3">驾驶证</option>
						 <option value="0" selected="selected">其它</option>
					</c:if>										 
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="idCard" class="col-sm-2 control-label"><span style="color:red;">*</span>证 &nbsp; 件 &nbsp;号：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="idCard" name="idCard" placeholder="证件号"  value="${registrationRecord.idCard}">
			</div>
			<div>
				<button type="button" onclick="getDataByCardId();">自动填充数据</button>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="visit" class="col-sm-2 control-label"><span style="color:red;">*</span>初/复诊：</label>
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
		<div class="form-group">
			<label for="medicareCardType" class="col-sm-2 control-label"><span style="color:red;">*</span>医 保 卡 类 型：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="medicareCardType" name="medicareCardType">
					<c:if test="${registrationRecord.medicareCardType==1||registrationRecord.medicareCardType==null}">
						 <option value="1" selected="selected">医保卡</option>
						 <option value="2">就诊卡</option>
						 <option value="3">自费</option>
					</c:if>
					<c:if test="${registrationRecord.medicareCardType==2}">
						 <option value="1">医保卡</option>
						 <option value="2" selected="selected">就诊卡</option>
						 <option value="3">自费</option>
					</c:if>
					<c:if test="${registrationRecord.medicareCardType==3}">
						 <option value="1">医保卡</option>
						 <option value="2">就诊卡</option>
						 <option value="3" selected="selected">自费</option>
					</c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="medicareNumber" class="col-sm-2 control-label">医 保 卡 号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="medicareNumber" name="medicareNumber" placeholder="医 保 卡 号" datatype="*0-30"  
					nullmsg="请输入医保卡号！" errormsg="请输入30位以内字符！" value="${registrationRecord.medicareNumber}">
			</div>
			<div>
				<button type="button" onclick="getDataByMedicare();">自动填充数据</button>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		
	<c:if test="${exCode!=null && exCode==3001}">
		<div class="form-group">
			<label for="idNumber" class="col-sm-2 control-label">平台ID：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="idNumber" name="idNumber" placeholder="输入身份证" value="${idNumber}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<span id="id_12320_wmessage" style="color:red;margin-left:40px"></span>
		</div>
		<div class="form-group">
			<label for="pw12320" class="col-sm-2 control-label">平台密码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="pw12320" name="pw12320" placeholder="输入12320平台密码" value="${pw12320}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<span id="pw_12320_wmessage" style="color:red;margin-left:40px"></span>
		</div>
	</c:if>

	<c:forEach items="${thirdParams}" var="thirdParam" varStatus="status">
		<c:set var="thirdKey" value="${fn:split(thirdParam, '#')[0]}" />
		<c:set var="thirdLabel" value="${fn:split(thirdParam, '#')[1]}" />
		<div class="form-group">
			<label for="${thirdParam}" class="col-sm-2 control-label">
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
	
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
				
				<!-- 
				<button type="button" id="patBut" onclick="gotoPatient();" class="btn btn-primary">保 存</button></div>
				 -->
			</div>
		</div>
		
		<div >
			<h4 ></br></br>
				<c:if test="${message!=null}">${message}</c:if>
			</h4>
		</div>		
	</form>
	<br />
<%-- </div> --%>
<script type="text/javascript">
	var ctx = "${ctx}";
	$(document).ready(function() {
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
			beforeSubmit:function(curform){
				var cardtype = $("#medicareCardType").val();
				var cardnumber = $("#medicareNumber").val();
				var isFirstVisit = $("#isFirstVisit").val();
				var idCard = $("#idCard").val();
				if(idCard=="" || typeof(idCard)=="undefined"){
					alert("请输入证件号！");
					return false;
				}
				var length = idCard.length;
				if(length!=15&&length!=18){
					alert("身份证必须是15位或是18位");
					return false;
				}
				if(isFirstVisit==""||isFirstVisit=="0"||  typeof(isFirstVisit)=="undefined"){
					$('#vmessage').text("请选择初/复诊类型！");
					return false;
				}
				if(cardtype==1||cardtype==2){
					if(cardnumber=="" || typeof(cardnumber)=="undefined"){
						alert("请输入医保卡或就诊卡！");
						return false;
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
				$('#fat-btn').button('loading');
			}
		});

	});
	function ifShow(value){
		if(value==1){
			document.getElementById("showDoctCode").style.display="block";
		}else{
			document.getElementById("showDoctCode").style.display="none";
		}
	}
    function setTGText(obj){
    	var teachGradeText = obj.options[obj.selectedIndex].text;
		$("#teachGradeText").val(teachGradeText);
	}
    function getDataByPhone(){
    	var phoneNum = $("#phoneNum").val();
    	if(phoneNum=="" || typeof(phoneNum)=="undefined"){
    		alert('请先输入手机号后再操作。');
    		return;
    	}else{
			$.ajax({  
				type : "post",  
				url : ctx+"/register/getDateByMobile",  
				data : "phoneNum=" + phoneNum,  
				async : false,  
				success : function(data){
					json =(new Function("","return "+data))(); 
					$("#patientName").val(json.patientName);
					$("#sex").val(json.sex);
					$("#isMarried").val(json.isMarried);
					$("#birthday").val(json.birthday);
					$("#phoneNum").val(json.phoneNum);
					$("#patientAddress").val(json.patientAddress);
					$("#idType").val(json.idType);
					$("#idCard").val(json.idCard);
					$("#isFirstVisit").val(json.isFirstVisit);
					$("#medicareCardType").val(json.medicareCardType);
					$("#medicareNumber").val(json.medicareNumber);
				}  
		    });
    	}
    }
    
    
    
    function getDataByCardId(){
    	var idCard = $("#idCard").val();
    	if(idCard=="" || typeof(idCard)=="undefined"){
    		alert('请先输入身份证后再操作。');
    		return;
    	}else{
			$.ajax({  
				type : "post",  
				url : ctx+"/register/getDateByCardID",  
				data : "idCard=" + idCard,  
				async : false,  
				success : function(data){
					json =(new Function("","return "+data))(); 
					$("#patientName").val(json.patientName);
					$("#sex").val(json.sex);
					$("#isMarried").val(json.isMarried);
					$("#birthday").val(json.birthday);
					$("#phoneNum").val(json.phoneNum);
					$("#patientAddress").val(json.patientAddress);
					$("#idType").val(json.idType);
					$("#idCard").val(json.idCard);
					$("#isFirstVisit").val(json.isFirstVisit);
					$("#medicareCardType").val(json.medicareCardType);
					$("#medicareNumber").val(json.medicareNumber);
				}  
		    });
    	}
    }
    
    function getDataByMedicare(){
    	var medicareNumber = $("#medicareNumber").val();
    	if(medicareNumber=="" || typeof(medicareNumber)=="undefined"){
    		alert('请先输入医保卡号后再操作。');
    		return;
    	}else{
			$.ajax({  
				type : "post",  
				url : ctx+"/register/getDateByMedicare",  
				data : "medicareNumber=" + medicareNumber,  
				async : false,  
				success : function(data){
					json =(new Function("","return "+data))(); 
					$("#patientName").val(json.patientName);
					$("#sex").val(json.sex);
					$("#isMarried").val(json.isMarried);
					$("#birthday").val(json.birthday);
					$("#phoneNum").val(json.phoneNum);
					$("#patientAddress").val(json.patientAddress);
					$("#idType").val(json.idType);
					$("#idCard").val(json.idCard);
					$("#isFirstVisit").val(json.isFirstVisit);
					$("#medicareCardType").val(json.medicareCardType);
					$("#medicareNumber").val(json.medicareNumber);
				}  
		    });
    	}
    }
</script>
</html>