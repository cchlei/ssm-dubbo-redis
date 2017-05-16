<%@ page contentType="text/html;charset=UTF-8"%><%@ include
	file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>定时导入管理</title>


</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">基础数据导入管理</a></li>
	</ul>
	<br />
	<div>
		<table>
			<tr>
				<td width="230">
					<label>平台:</label> 
					<select class="mSelect" id="selectAgentId" onchange="selectSomething()">
							<option value="">请选择平台</option>
							<c:forEach items="${agentList}" var="agent" varStatus="status">
								<c:if test="${someKey == agent.agentId}">
									<option value="${agent.agentId}" selected="selected">${agent.agentName}</option>
								</c:if>
								<c:if test="${someKey != agent.agentId}">
									<option value="${agent.agentId}">${agent.agentName}</option>
								</c:if>
							</c:forEach>
					</select>
				</td>
				<td class="text-center" width="80">
					<form id="form-list" name="form" role="form" action="${ctx}/import_quartz/list" method="POST">
						<input name="someKey" type="hidden" value="${someKey}"/>
						<button type="button" id="serach-list">查询</button>
					</form>
				</td>
				<td class="text-center" width="80">
					<form id="form-exec" name="form" role="form" action="${ctx}/import_quartz/exec" method="POST">
						<input name="someKey" type="hidden" value="${someKey}"/>
						<input name="category" type="hidden" value="1"/>
						<button type="button" id="serach-exec">导 入</button>
					</form>
				</td>
				<td class="text-center" width="80">
					<a href="javascript:modify()">新增</a>
				</td>
			</tr>
		</table>
	</div>
	<br />
	<div>
		<table class="table table-bordered table-hover tablesorter" id="tableDoctor">
			<thead>
				<tr>
					<th class="text-center">配置</th>
					<th class="text-center">医院编号</th>
					<th class="text-center">医院名称</th>
					<th class="text-center">状态</th>
					<th class="text-center">科室</th>
					<th class="text-center">医生</th>
					<!-- <th class="text-center">创建时间</th> -->
					<th class="text-center">完成时间</th>
					<th class="text-center">周期</th>
					<th class="text-center">操作</th>
				</tr>
			</thead>
			<c:forEach items="${quartzs}" var="data" varStatus="status">
			<tr>
				<td class="text-center">${confMaps[data.someKey]}</td>
				<td class="text-center">${data.hospitalCode}</td>
				<td class="text-center">${data.hospitalName}</td>
				<td class="text-center">
					<c:if test="${data.style == 1}">待处理</c:if>
					<c:if test="${data.style == 2}"><font color="red">科室</font></c:if>
					<c:if test="${data.style == 3}"><font color="green">科室</font></c:if>
					<c:if test="${data.style == 4}"><font color="red">医生</font></c:if>
					<c:if test="${data.style == 5}"><font color="green">完成</font></c:if>
					<c:if test="${data.style == 99}"><font color="gray">暂停</font></c:if>
				</td>
				<td class="text-center">${data.depCount}</td>
				<td class="text-center">${data.doctorCount}</td> 
				<!-- 
				<td class="text-center">
					<fmt:formatDate value="${data.createTime}" pattern="yyyyMMdd HH:mm:ss" />
				</td>
				 -->
				<td class="text-center">
					<fmt:formatDate value="${data.completeTime}" pattern="yyyyMMdd HH:mm:ss" />
				</td>
				<td class="text-center">
					<c:if test="${data.loop == true}">周期性</c:if>
					<c:if test="${data.loop == false}">一次性</c:if>
				</td>
				<td class="text-center">
					<a href="javascript:modify('${data.quartzKey}')">修改</a>
					<a class="quartz-del" del_id="${data.quartzKey}" href="#">删除</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
<script type="text/javascript">
var ctx = "${ctx}", baseurl = "${baseurl}";
$(document).ready(function() {
	$("#selectAgentId").bind("change", function(){
		$("input[name='someKey']").val($(this).val());
	});
	$("#serach-exec").bind("click", function(){
		var inputvalue = $("#form-exec :input").val();
		if(inputvalue){
			var agent_name = $("#selectAgentId option:selected").text();
			$.confirm("确定要开始导入 "+ agent_name +" 的基础数据么?", function() {
				$("#form-exec").submit();
			});
		}else{
			$.alert("请选择一项!");
		}
	});
	$("#serach-list").bind("click", function(){
		$("#form-list").submit();
	});
	$(".quartz-del").bind("click", function(){
		if ($(this).attr('del_id')) {
			var quartzKey = $(this).attr('del_id');
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get(ctx +"/import_quartz/del/" + quartzKey, function(json) {
					var msg = "";
					if (json.message) {
						msg = json.message;
					}
					$.alert(msg, function() {
						window.location.reload();
					});
				}, "json");
			});
		}
	});
});
function modify(k){
	var title = "新增", urlString = baseurl + "import_quartz/to", actionString = baseurl +'import_quartz/modify';
	if(k){
		title = "修改";
		urlString = urlString + "?quartzKey="+ k;
	}	
	var refresh = false;
	var lindex = layer.open({
		 type: 2,
		 title: title,
		 area: ['768px', '450px'],
		 fixed: false, //不固定
		 maxmin: false, 
		 offset: '100px',
		 content: [urlString, 'no'],
		 btn:'提交', 
		 yes: function(index, layero){
			 var body = layer.getChildFrame('body', index);
			 var form = body.find("form");
			 $.ajax({
				 type:	'POST',
				 url:	actionString,
				 contentType:	'application/json',
				 data:	JSON.stringify(form.serializeObject()),
				 success:	function(result) {
					refresh = result.success;
					if(result.success){
						body.find("#div-message").html("<font class='green'>"+ result.message +"</span>");
					}else{
						body.find("#div-message").html("<font class='red'>"+ result.message +"</span>");
					}
	             },
				 error:	function(result) {
	               body.find("#div-message").html("<span class='red'>操作异常,稍后再试</span>");   
	             }
			 });
		 },cancel: function(index, layero){
			 if(refresh){
				 window.location.reload(); 
			 }
		 } 
	});
}
</script>
</body>
</html>