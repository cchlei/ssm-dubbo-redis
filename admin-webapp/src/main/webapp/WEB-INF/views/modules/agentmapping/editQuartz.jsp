<%@ page contentType="text/html;charset=UTF-8"%><%@ include
	file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>编辑</title>
<style type="text/css">
	#div-message .red{
		color: red;
	}
	#div-message .green{
		color: green;
	}
</style>
</head>

<body>
	<div id="layer_show_div" style="width: 600px; margin-top: 20px">
		<form class="form-horizontal form-input" name="form" role="form" action="${ctx}/import_quartz/modify" method="POST">
			<input type="hidden" name="quartzKey"  value="${quartz.quartzKey}">
			<div class="form-group">
				<label for="from-category" class="col-sm-3 control-label">类别</label>
				<div class="col-sm-9">
					<select name="category" class="form-control" id="from-category" value="${quartz.category}">
					  <option value ="">请选类型</option>
					  <option value ="1">平台</option>
					  <option value ="2">单个医院</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="from-someKey" class="col-sm-3 control-label">配置编号</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="someKey" id="from-someKey" value="${quartz.someKey}"/>
				</div>
			</div>
			<div class="form-group">
				<label for="from-hospitalCode" class="col-sm-3 control-label">医院编号</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="hospitalCode" id="from-hospitalCode" value="${quartz.hospitalCode}"/>
				</div>
			</div>
			<div class="form-group">
				<label for="from-hospitalName" class="col-sm-3 control-label">医院名称</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="hospitalName" id="from-hospitalName" value="${quartz.hospitalName}"/>
				</div>
			</div>
			<div class="form-group">
				<label for="from-style" class="col-sm-3 control-label">状态</label>
				<div class="col-sm-9">
					<select name="style" class="form-control" id="from-style" value="${quartz.style}">
					  <option value ="">请选处理状态</option>
					  <option value ="1">待处理</option>
					  <option value ="2">正在导入科室</option>
					  <option value ="3">科室导入完成</option>
					  <option value ="4">开始导入医生</option>
					  <option value ="5">医生导入完成</option>
					  <option value ="99">暂停</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="from-loop" class="col-sm-3 control-label">周期</label>
				<div class="col-sm-9">
					<select name="loop" class="form-control" id="from-loop" value="${quartz.loop}">
					  <option value ="true">周期性导入</option>
					  <option value ="false">一次性导入</option>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<div class="col-sm-12" id="div-message" style="text-align: center"></div>
			</div>
		</form>
	</div>
	
<script type="text/javascript">
$(document).ready(function() {
	 $("select").each(function(i){
		 $(this).val($(this).attr("value"));
	 });
});
</script>
</body>
</html>