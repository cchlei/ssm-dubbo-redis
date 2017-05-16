<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>修改任务调度</title>

<script type="text/javascript">
var ctx = "${baseurl}";

</script>
</head>
<body>
	<div style="margin: 10px">
		<form class="form-horizontal form-input" name="form" id="form" action="${ctx}/schedule/update" method="POST">
			<div class="form-group">
				<label for="versionCode" class="col-sm-2 control-label">调度编号</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="scheduleKey" value="${scheduleKey}" disabled="disabled" />
				</div>
			</div>
			<div class="form-group">
				<label for="versionCode" class="col-sm-2 control-label">调度名称</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="scheduleName" value="${scheduleName}"/>
				</div>
			</div>
			<div class="form-group">
				<label for="versionCode" class="col-sm-2 control-label">调度计划</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="cronExpression" value="${cronExpression}"/>
				</div>
			</div>
			<div class="form-group">
				<label for="versionCode" class="col-sm-2 control-label">调度说明</label>
				<div class="col-sm-5">
					<textarea  class="form-control" name="description" value="${description}"  clos="10" rows="5"/>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
			</div>
		</form>
		
	<form id="schedule-form" action="" method="POST" class="form-horizontal form-input" style="display: none">
		<div class="form-group">
			<label for="from-scheduleKey" class="col-sm-2 control-label">调度编号</label>
			<div>
				<input type="text" class="form-control" name="scheduleKey" id="from-scheduleKey" />
			</div>
		</div>
		<div class="form-group">
			<label for="from-scheduleName" class="col-sm-2 control-label">调度名称</label>
			<div>
				<input type="text" class="form-control" name="scheduleName" id="from-scheduleName" />
			</div>
		</div>
		<div class="form-group">
			<label for="from-cronExpression" class="col-sm-2 control-label">调度计划</label>
			<div>
				<input type="text" class="form-control" name="cronExpression" id="from-cronExpression" />
			</div>
		</div>
		<div class="form-group">
			<label for="from-description" class="col-sm-2 control-label">调度说明</label>
			<div>
				<textarea class="form-control" name="description" clos="10" rows="5" id="from-description" value="" />
			</div>
		</div>
	</form>
	</div>	
</body>
</html>