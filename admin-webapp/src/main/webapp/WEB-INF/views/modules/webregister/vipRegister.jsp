<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生信息编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<%-- <li><a href="${ctx}/hospDep/list?hospId=${hospId}">医院科室编辑</a></li> --%>
		<li class="active"><a href="javascript:void(0)">VIP挂号</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1"  id="form" role="form" action="${ctx}/webregister/vipregister" method="POST">
		<input id="hospId" name="hospId" type="hidden" value="${registrationRecord.hospId}"/>
		<input id="hospName" name="hospName" type="hidden" value="${registrationRecord.hospName}"/>
		<input id="doctorId" name="doctorId" type="hidden" value="${registrationRecord.doctorId}"/>
		<input id="doctorName" name="doctorName" type="hidden" value="${registrationRecord.doctorName}"/>
		<input id="departmentId" name="departmentId" type="hidden" value="${registrationRecord.departmentId}"/>
		<input id="departmentName" name="departmentName" type="hidden" value="${registrationRecord.departmentName}"/>
		<input id="resourceTpyeText" name="resourceTpyeText" type="hidden" />
	    
		<div class="form-group">
			<label for="patientName" class="col-sm-2 control-label"><span style="color:red;">*</span>患 者 姓 名：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="patientName" name="patientName" placeholder="患者姓名" datatype="*1-10"
					nullmsg="请输入患者姓名！" errormsg="患者姓名至少1个字符,最多10个字符！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="sex" class="col-sm-2 control-label">性&nbsp;&nbsp;别：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="sex" name="sex">
				 <option value="1" selected="selected">男</option>
				 <option value="2">女</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="isMarried" class="col-sm-2 control-label">是 否 已 婚：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="isMarried" name="isMarried">
				 <option value="1" selected="selected">已婚</option>
				 <option value="2">未婚</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="birthday" class="col-sm-2 control-label">出 生 日 期：</label>
			<div class="col-sm-5">
				<input class="Wdate" type="text" name="birthday" id="birthday"  onClick="WdatePicker()">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>		
		<div class="form-group">
			<label for="phoneNum" class="col-sm-2 control-label"><span style="color:red;">*</span>手&nbsp;机 &nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="phoneNum" name="phoneNum" placeholder="手机号" datatype="m"
					nullmsg="请输入手机号！" errormsg="请输入正确的手机号！" >
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
					nullmsg="请输入患者地址！" errormsg="请输入30个以内的字符！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group"> 
			<label for="diagnosisDate" class="col-sm-6 control-label">就诊医院：${registrationRecord.hospName} - 科室：${registrationRecord.departmentName} - 医生：${registrationRecord.doctorName}</label>
		</div>
		<div class="form-group"> 
			<label for="diagnosisDate" class="col-sm-2 control-label"><span style="color:red;">*</span>就 诊 时 间：</label>
			<div class="col-sm-5">
				<input class="Wdate" type="text" name="diagnosisDate" id="diagnosisDate" datatype="*1-30" nullmsg="请输入就诊时间！" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="idType" class="col-sm-2 control-label"><span style="color:red;">*</span>证 件 类 型：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="idType" name="idType">
				 <option value="1" selected="selected">身份证</option>
				 <option value="2">社保卡</option>
				 <option value="3">驾驶证</option>
				 <option value="0">其它</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="idCard" class="col-sm-2 control-label"><span style="color:red;">*</span>证 &nbsp; 件 &nbsp;号：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="idCard" name="idCard" placeholder="证件号" datatype="*15-18"  
					nullmsg="请输入15到18位字符！" errormsg="请输入15到18位字符！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="medicareCardType" class="col-sm-2 control-label"><span style="color:red;">*</span>医 保 卡 类 型：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="medicareCardType" name="medicareCardType">
				 <option value="1" selected="selected">医保卡</option>
				 <option value="2">就诊卡</option>
				 <option value="3">自费</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="medicareNumber" class="col-sm-2 control-label">医 保 卡 号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="medicareNumber" name="medicareNumber" placeholder="医 保 卡 号" datatype="*0-18"  
					nullmsg="请输入医保卡号！" errormsg="请输入18位字符！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="resourceTpye" class="col-sm-2 control-label"><span style="color:red;">*</span>挂 号 类 型：</label>
			<div class="col-sm-5">
				<select class="mSelect"  id="resourceTpye" name="resourceTpye">
				 <option value="">请选择</option>
				 <c:forEach items="${dicList}" var="dic" varStatus="status">
				 	<option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="successfulRegisteredNum" class="col-sm-2 control-label">挂&nbsp;号&nbsp;费：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="expense" name="expense" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="0">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
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
				var checkText=$("#resourceTpye").find("option:selected").text();
				$("#resourceTpyeText").val(checkText);
				
				if(checkText=='请选择'){
					alert("请选择挂号类型！");
					return false;
				}
				
				var cardtype = $("#medicareCardType").val();
				var cardnumber = $("#medicareNumber").val();
				if(cardtype==1||cardtype==2){
					if(cardnumber=="" || typeof(cardnumber)=="undefined"){
						alert("请输入医保卡或就诊卡！");
						return false;
					}
				}
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
    function gotoPatient(){
    	var checkText=$("#resourceTpye").find("option:selected").text();
		$("#resourceTpyeText").val(checkText);
    	var cardtype = $("#medicareCardType").val();
		var cardnumber = $("#medicareNumber").val();
		if(checkText=='请选择'){
			alert("请选择挂号类型！");
			return false;
		}
		if(cardtype==1||cardtype==2){
			if(cardnumber=="" || typeof(cardnumber)=="undefined"){
				alert("请输入医保卡或就诊卡！");
				return false;
			}
		}
    	this.form.submit();
    }    
</script>
</html>