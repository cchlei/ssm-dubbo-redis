<%@ page contentType="text/html;charset=UTF-8"%><%@ include
	file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>渠道编辑</title>
</head>

<body>
	<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">渠道资源编辑</a></li>
	</ul>
	<br />

	<form class="form-horizontal form-input" name="form1" role="form"
		action="${ctx}/wxsource/saveorupdate" method="POST">
		<div class="form-group">
		<label for="name" class="col-sm-2 control-label">渠&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;道&nbsp&nbspID: </label>
		<div class="col-sm-5">
			<input type="text" class="form-control" id="wxSourceId" name="wxSourceId"
				placeholder="渠道ID" nullmsg="请输入渠道ID" errormsg="渠道ID不可重复！"
				value="${wxsource.wxSourceId}" />
			<input type="text" class="form-control" id="sid" name="sid" style="display:none;"
				value="${sid}" />
		</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">渠道名称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="wxSourceName" name="wxSourceName"
					placeholder="渠道名称" datatype="*2-50" nullmsg="请输入渠道名称！"
					errormsg="渠道名称至少2个字符,最多50个字符！" value="${wxsource.wxSourceName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>

		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary"
					data-loading-text="正在保存...">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返回</button>
				<span id="msg-info" style="margin-left: 10px;"></span>
			</div>
		</div>
	</form>
	<br />
	<%-- </div> --%>
	<script type="text/javascript">
		$(document).ready(function() {
		var tag = "${source}";
		var ctx = "${ctx}";
		if (tag != "") {
		document.form1.action = ctx + "/wxsource/update";
		}
			$(".form-input").Validform(
					{
						showAllError : true,
						tiptype : function(msg, o,cssctl) {
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
							beforeSubmit : function(curform) {
							$('#fat-btn').button('loading');
						},
							callback : function(json,statusText) {
								if (json.success) {
									$.alert(json.message,function() 
											{
												//window.location.reload();
												window.location.href = '${ctx}/wxsource/list';
											});
									} else {errorValidate("msg-info", '');
										if (json.data.title) {
												errorValidate('title',json.message + ','+ json.data.title);
												}
											}
										$('#fat-btn').button('reset');
										}
									});

						});
	</script>
</html>