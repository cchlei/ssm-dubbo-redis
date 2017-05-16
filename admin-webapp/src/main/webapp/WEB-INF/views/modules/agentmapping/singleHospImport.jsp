<%@ page contentType="text/html;charset=UTF-8"%><%@ include
	file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>统计管理</title>
</head>

<body>
	<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">数据导入</a></li>
	</ul>
	<br />
	<div class="form-group">
		<form name="form" class="form-horizontal form-input" role="form" action="${ctx}/import/singleHospImport" method="GET">
			平台ID:<input name="agentId" id="agentId">
			旧医院ID:<input name="oldHospId" id="oldHospId">
			新医院ID:<input name="newHospId" id="newHospId">
			<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在导入...">导入</button>
		</form>
		<br />
		<ul>
			<li><label style="color: red">旧医院必须为已启用的医院</label></li>
		</ul>
	</div>


	<script type="text/javascript">
		var ctx = "${ctx}";

		$(document).ready(function() {
			if ("${date}" != "") {
				$("#date").val("${date}");
			}
			$(".form-input").Validform({
				postonce : true,
				ajaxPost : true,
				beforeSubmit : function(curform) {
					$('#fat-btn').button('loading');
				},
				callback : function(json, statusText) {
					$.alert(json.message);
					errorValidate("msg-info", '');

					$('#fat-btn').button('reset');
				}
			});

		});
	</script>
</html>