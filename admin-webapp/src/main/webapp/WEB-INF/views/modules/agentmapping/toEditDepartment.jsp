<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>科室关联映射编辑</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">科室关联映射编辑</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form" role="form" action="${ctx}/agentMapping/updateDepMapping" method="POST">
	    <input type="hidden" name="agentId" id="agentId" value="${myMappingBean.agentDepartmentRef.agentId}"/>
	    <input type="hidden" name="myDepartmentId" id="myDepartmentId" value="${myMappingBean.agentDepartmentRef.myDepartmentId}"/>
		<div style="margin-left:300px;margin-top:10px">
		 ${myMappingBean.hosp.hospName}- ${myMappingBean.department.departmentName}&nbsp;&nbsp;映射关系修改：<input type="text" name="departmentId" id="departmentId">
		<br/>
		<br/>
		<br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
		&nbsp;&nbsp;
		<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
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
			ajaxPost : true,
			beforeSubmit:function(curform){
				
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
						$.alert(json.message, function(){
							window.location.reload();
							//window.location.href = '${ctx}/agentMapping/hospList?agentId='+json.results;
						});
				} else {
					errorValidate('msg-info', json.message + ',' + "");
					
				}
				$('#fat-btn').button('reset');
			}
		});
	});
</script>
</html>