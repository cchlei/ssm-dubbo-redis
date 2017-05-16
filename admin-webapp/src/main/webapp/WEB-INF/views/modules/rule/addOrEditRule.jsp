<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>规则编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">规则编辑</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/rule/save" method="POST">
	<input id="ifExist" name="ifExist" type="hidden"/>
	    <c:if test="${ruleInfo!=null}">
			<input id="ruleId" name="ruleId" type="hidden" value="${ruleInfo.ruleId}"/>
	    </c:if>
		<div class="form-group">
			<label for="ruleName" class="col-sm-2 control-label"><span style="color:red;">*</span>规则名称：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="ruleName" name="ruleName" clos="15" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength1">最多输入200个字符</div>
		</div>
		
		<div class="form-group" id="ruleCode" >
			<label for="hospCode" class="col-sm-2 control-label"><span style="color:red;">*</span>规&nbsp;则&nbsp;编 &nbsp;码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="ruleCode" name="ruleCode" placeholder="规则编码" datatype="n1-6"
					nullmsg="请输入规则编码！" errormsg="规则编码为6位数字！" value="${ruleInfo.ruleCode}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">6位数字</div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="ruleType" class="col-sm-2 control-label"><span style="color:red;">*</span>规&nbsp;则&nbsp;类&nbsp;型：</label>
			<div class="col-sm-5">
				<select class="mSelect"  class="mSelect"  id="ruleType" name="ruleType">
				 <c:if test="${ruleInfo.ruleType==1||ruleInfo.ruleType==null}">
				 <option value="1" selected="selected">通用</option>
				 <option value="2">渠道</option>
				 </c:if>
				 <c:if test="${ruleInfo.ruleType==2}">
				 <option value="1">通用</option>
				 <option value="2" selected="selected">渠道</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="isEnabled" class="col-sm-2 control-label">状 &nbsp;&nbsp;态 ：</label>
			<div class="col-sm-4">
				<select class="sSelect"  class="sSelect"  id="isEnabled" name="isEnabled">
				 <c:if test="${ruleInfo.isEnabled==0}">
				 <option value="0" selected="selected">禁用</option>
				 <option value="1">启用</option>
				 </c:if>
				 <c:if test="${ruleInfo.isEnabled==1||ruleInfo.isEnabled==null}">
				 <option value="0">禁用</option>
				 <option value="1" selected="selected">启用</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
	</form>
	<br />
<%-- </div> --%>
<script type="text/javascript">
		var ctx = "${ctx}";
		var nameFlag=true;
	$(document).ready(function() {
		var rule = "${ruleInfo}";
		var ruleId = null;
		if(rule!=""){
			document.form1.action=ctx+"/rule/update"; 
			ruleId = $("#ruleId").val();
			 var ruleName =  "${ruleInfo.ruleName}";
			 if(ruleName!=""){
				  $("#ruleName").val(ruleName); 
				}
			
		}
		
		//验证规则编码有没有重复
		$("input[name='ruleCode']").blur(function (){
		var url = "${ctx}/rule/ifExist";
		var ruleCode = this.value;
		 $.post(url,{'ruleCode':ruleCode,'ruleId':ruleId},function (data){
				if(!data.success){
					$('#wmessage').text("该规则编码已存在！");
					document.getElementById("wmessage").style.display="block";
					$("#ifExist").val("1");
				}else{
					$("#ifExist").val("0");
					document.getElementById("wmessage").style.display="none";
				}
		 });
		});
		
		//控制规则名称输入字数
		$("#ruleName").keyup(function(){
			 var a=200-$("#ruleName").val().length;
			 $("#nLength1").html("您还可以输入"+a+"个字符");
			 if(a<=0){
			   alert("字数不能超过200");
			   nameFlag = false;
			 }else{
			   nameFlag = true;
			 }
		 });
		
		
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
				var ifExist = $("#ifExist").val();
				if(ifExist=="1"){
					alert("该规则编码已存在！");
					return false;
				}
				if(!nameFlag){
					alert("规则名称字数过多！");
					return false;
				}
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						window.location.href = '${ctx}/rule/list';
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
</script>
</html>