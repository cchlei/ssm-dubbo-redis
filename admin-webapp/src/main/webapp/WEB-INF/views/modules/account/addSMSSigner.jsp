<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>标签列表</title>
</head>

<body>
<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">添加医院签名</a></li>
	</ul>
	<c:if test="${not empty hospSigner.hospId}">
		<form class="form-horizontal form-input" name="form" role="form" action="${ctx}/smsSigner/update" method="POST">
		<div class="form-group">
			<label for="hospId" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp; &nbsp;院&nbsp; &nbsp;ID：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" readonly="readonly" id="hospId" name="hospId" placeholder="医院ID" datatype="*1-20"
					nullmsg="请输入医院ID！" errormsg="医院ID至少1个字符,最多20个字符！" value="${hospSigner.hospId}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="signer" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp; &nbsp;院&nbsp; &nbsp;签 &nbsp; &nbsp;名：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="singer" name="singer" placeholder="医院签名" datatype="*1-256"
					nullmsg="请输入医院签名！" errormsg="医院签名至少1个字符,最多256个字符！" value="${hospSigner.hospSigner}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="signer" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp; &nbsp;院&nbsp; &nbsp;模&nbsp; &nbsp;板：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="templateKey" name="templateKey" placeholder="医院短信模板" datatype="*1-256"
					nullmsg="请输入短信模板ID！" value="${hospSigner.templateKey}">
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
	</c:if>
	<c:if test="${empty hospSigner.hospId}">
		<form class="form-horizontal form-input" name="form" role="form" action="${ctx}/smsSigner/saveTo" method="POST">
		<div class="form-group">
			<label for="hospId" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp; &nbsp;院&nbsp; &nbsp;ID：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control"  id="hospId" name="hospId" placeholder="医院ID" datatype="*1-20"
					nullmsg="请输入医院ID！" errormsg="医院ID至少1个字符,最多20个字符！" value="${hospSigner.hospId}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="signer" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp; &nbsp;院&nbsp; &nbsp;签 &nbsp; &nbsp;名：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="singer" name="singer" placeholder="医院签名" datatype="*1-256"
					nullmsg="请输入医院签名！" errormsg="医院签名至少1个字符,最多256个字符！" value="${hospSigner.hospSigner}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="signer" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp; &nbsp;院&nbsp; &nbsp;模&nbsp; &nbsp;板：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="templateKey" name="templateKey" placeholder="医院短信模板" datatype="*1-256"
					nullmsg="请输入短信模板ID！" value="${hospSigner.templateKey}">
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
	</c:if>
    	
    </form>
<script>
$(document).ready(function() { 
	
	/* var  hospId = ${hospSigner.hospId};
	if(null != hospId && hospId != ''){
		$("#hospId").attr("readonly","readonly");
	}  */
	
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
			if($("#cont").val()==""){
				alert("请输入正确的描述！");
				return false;
			}
			$('#fat-btn').button('loading');
		},
		callback : function(json, statusText) {
			if (json.success) {
				$.alert(json.message, function(){
					json.message
					window.location.href = '${ctx}/smsSigner/list';
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

</body>
</html>