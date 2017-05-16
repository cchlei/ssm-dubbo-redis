<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>任务调度</title>
<style type="text/css">
	#div-message .red{
		color: red;
	}
	#div-message .green{
		color: green;
	}
</style>


<script type="text/javascript">
var ctx = "${ctx}", baseurl = "${baseurl}";
function show_log(n,k){
	layer.open({
		 type: 2,
		 title: n +'调度日志,只显示最近20条记录',
		 area: ['800px', '820px'],
		 fixed: false, //不固定
		 maxmin: false,
		 content: [baseurl +'schedule/log/list/'+ k, 'no']
	});
}

function del(n,k){
	layer.confirm('确认要删除['+ n+']?', {icon: 3, title:'操作确认'}, function(index){
		var url = ctx+"/schedule/delete";
		$.post(url,{'scheduleId':k},function(data){
			if(data.success){
				layer.alert(data.message, {icon: 6}, function(){
					window.location.reload();
				});
			}else{
				layer.alert(data.message, {icon: 6});
			}
		});
	});
}
function fettle(n, k){
	layer.confirm('确认要切换['+ n+']?', {icon: 3, title:'操作确认'}, function(index){
		var url = ctx+"/schedule/fettle";
		$.post(url,{'scheduleId':k},function(data){
			if(data.success){
				layer.alert(data.message, {icon: 6}, function(){
					window.location.reload();
				});
			}else{
				layer.alert(data.message, {icon: 6});
			}
		});
	});
}
function state(n, k){
	layer.confirm('确认要切换['+ n+']?', {icon: 3, title:'操作确认'}, function(index){
		var url = ctx+"/schedule/state";
		$.post(url,{'scheduleId':k},function(data){
			if(data.success){
				layer.alert(data.message, {icon: 6}, function(){
					window.location.reload();
				});
			}else{
				layer.alert(data.message, {icon: 6});
			}
		});
	});
}
function execute(n, k){
	layer.confirm('确认要立即执行['+ n+']?', {icon: 3, title:'操作确认'}, function(index){
		var url = ctx+"/schedule/execute";
		$.post(url,{'scheduleId':k},function(data){
			if(data.success){
				layer.alert(data.message, {icon: 6}, function(){
					window.location.reload();
				});
			}else{
				layer.alert(data.message, {icon: 6});
			}
		});
	});
}
function insert(){
	send(ctx +'/schedule/insert', '新增调度任务');
}

function update(id){
	send(ctx +'/schedule/update', '修改调度任务',
		id,
		$("#"+ id +"_destination").html(),
		$("#"+ id +"_key").html(),
		$("#"+ id +"_name").html(),
		$("#"+ id +"_expression").html(),
		$("#"+ id +"_description").html(),
		$("#"+ id +"_category").attr("value")
	);
}

function send(urlstring, title, id, dest, key, name, expression, description, category){
	var refresh = false;
	var index = layer.open({
		 type: 1, title: title, offset: '100px', area: '420px', fixed: false, maxmin: false,
		 content: $('#layer_show_div'),
		 btn:'提交', yes: function(index, layero){
			var ctx = "${ctx}", form = $(layero).find("form");
			$.ajax({
				type:'POST',
				url:urlstring,
				contentType:'application/json',
				data:JSON.stringify(form.serializeObject()),
				success:function(data) {
					refresh = data.success;
					if(data.success){
						$("#div-message").html("<font class='green'>"+ data.message +"</span>");
					}else{
						$("#div-message").html("<font class='red'>"+ data.message +"</span>");
					}
	            },
				error:function(data) {
	               	$("#div-message").html("<span class='red'>操作异常,稍后再试</span>");   
	            }
			});
		 },cancel: function(index, layero){
			 if(refresh){
				 window.location.reload(); 
			 }
		 },success: function(index, layero){
			 var form = $(layero).find("form");
			 $("#from-id").val(id);
			 $("#from-destination").val(dest);
			 $("#from-scheduleKey").val(key);
			 $("#from-scheduleName").val(name);
			 $("#from-cronExpression").val(expression);
			 $("#from-description").val(description);
			 if(category){
				 $("#from-category").val(category);
			 }else{
				 $("#from-category").val("1");
			 }
		 }    
	});
}


</script>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">任务调度列表</a></li>
	</ul>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>任务调度列表
				<span style="float: right;">
					<a href="javascript:insert();">新增任务调度</a>
					&nbsp;
					<a href="javascript:location.reload();">刷新任务调度</a>
				</span>
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
				<tr>
				    <th class="text-center">任务名称</th>
					<th class="text-center">目的地</th>
					<th class="text-center">类型</th>
					<th class="text-center">任务编号</th>
					<th class="text-center">调度计划</th>
					<th class="text-center">状态</th>
					<th class="text-center">执行状态</th>
					<th class="text-center">操作</th>
				</tr>
			</thead>
			<c:forEach items="${schedules}" var="s" varStatus="status">
				<tr>
				    <td  class="text-center" id="${s.id}_name">${s.scheduleName}</td>
					<td  class="text-center" id="${s.id}_destination">${s.destination}</td>
					<td  class="text-center" id="${s.id}_category" value="${s.category}">
						<c:if test="${s.category==2}">订阅</c:if>
						<c:if test="${s.category==1}">队列</c:if>
					</td>
					<td  class="text-center" id="${s.id}_key">${s.scheduleKey}</td>
					<td  class="text-center" id="${s.id}_expression">${s.cronExpression}</td>
					<td  class="text-center">
						<c:if test="${s.fettle==1}">开启</c:if>
						<c:if test="${s.fettle==2}">暂停</c:if>
						&nbsp;
						<a href="javascript:fettle('${s.scheduleName}','${s.id}');">切换</a>
					</td>
					<td  class="text-center">
						<c:if test="${s.state==1}">执行中</c:if>
						<c:if test="${s.state==2}">完成</c:if>
						&nbsp;
						<a href="javascript:state('${s.scheduleName}','${s.id}');">切换</a>
					</td>
					<td  class="text-center">
						<a href="javascript:execute('${s.scheduleName}','${s.id}');">执行</a>
						<a href="javascript:update('${s.id}');">修改</a>
						<a href="javascript:del('${s.scheduleName}','${s.id}');">删除</a>
						<a href="javascript:show_log('${s.scheduleName}','${s.id}');">日志</a>
					</td>
				</tr>
				<tr>
				    <td  class="text-center"  colspan="8"  id="${s.id}_description">${s.description}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id="layer_show_div" style="display: none; width: 400px; margin-top: 20px">
		<form id="schedule-form" action="" method="POST" class="form-horizontal form-input">
			<input type="hidden" name="id" id="from-id" />
			<div class="form-group">
				<label for="from-destination" class="col-sm-3 control-label">目的地</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="destination" id="from-destination" />
				</div>
			</div>
			<div class="form-group">
				<label for="from-scheduleKey" class="col-sm-3 control-label">任务编号</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="scheduleKey" id="from-scheduleKey" />
				</div>
			</div>
			<div class="form-group">
				<label for="from-scheduleName" class="col-sm-3 control-label">调度名称</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="scheduleName" id="from-scheduleName" />
				</div>
			</div>
			<div class="form-group">
				<label for="from-schedulecategory" class="col-sm-3 control-label">调度类型</label>
				<div class="col-sm-9">
					<select name="category" class="form-control" id="from-category">
					  <option value ="1">队列模式</option>
					  <option value ="2">订阅模式</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="from-cronExpression" class="col-sm-3 control-label">调度计划</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="cronExpression" id="from-cronExpression" />
				</div>
			</div>
			<div class="form-group">
				<label for="from-description" class="col-sm-3 control-label">调度说明</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="description" clos="10" rows="5" id="from-description" ></textarea>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-12" id="div-message" style="text-align: center"></div>
			</div>
		</form>
	</div>
</body>
</html>