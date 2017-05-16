<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>新增任务调度</title>

<script type="text/javascript">
var ctx = "${baseurl}";

</script>
</head>
<body>
	<div class="panel panel-default">
		<form class="form-horizontal form-input" name="form" id="form" action="${ctx}/schedule/insert" method="POST">
			<div class="form-group">
				调度编号：<input type="text"  id="scheduleKey" name="scheduleKey"  value="${scheduleKey}"/>
			</div>
			<div class="form-group">
				调度名称：<input type="text"  id="scheduleName" name="scheduleName" />
			</div>
			<div class="form-group">
				调度计划：<input type="text"  id="cronExpression" name="cronExpression"/>
			</div>
			<div class="form-group">
				调度说明：<input type="text"  id="description" name="description"/>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<span id="msg-info" style="margin-left:280px;">
						<button type="button" class="btn btn-primary" onclick="addWhiteBut()">确定</button>
					</span>
				</div>
			</div>
		</form>
	</div>	
</body>
</html>