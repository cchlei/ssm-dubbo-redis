<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>集中平台列表</title>

<style>
.div-record
      {
          height: 30px;
          font-size: 16px;
          padding: 3px;
      } 
.div-record-json
      {
          font-size: 16px;
          padding: 3px;
      } 
.div-label-title
      {
      	font-weight:normal;
          color: blue;
      } 
.div-label-content
      {
      font-weight:normal;
          padding-left: 3px;
          padding-right: 3px;
          text-decoration:underline;
      }  
.writing-mode-tb-rl
{
	width: 30px;
	writing-mode:tb-rl;
	font-size: 18px;
	letter-spacing:8px;
} 
.td-center{
	 text-align:center; 
}
</style>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">集中平台列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/agent/list" method="GET">
    	<a href="${ctx}/agent/toAddorEdit">添加平台</a>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 集中平台列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
				<tr>
					<th class="text-center" width="200px">平台</th>
					<th class="text-center">唯一编号</th>
					<th class="text-center">接入类型</th>
					<th class="text-center">处理方式</th>
					<th class="text-center">地区</th>
					<th class="text-center">状态</th>
					<th class="text-center">最后修改时间</th>
					<th class="text-center">JSON配置</th>
					<th class="text-center">操作</th>
				</tr>
			</thead>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="today"/>
			<c:forEach items="${agentList}" var="agent" varStatus="status">
				<tr>
					<td class="text-center">${agent.agentName}</td>
					<td class="text-center">${agent.agentId}</td>
					<td class="text-center">
						<c:if test="${agent.interfaceType == null}">
							未知类型(请检查)
						</c:if>
						<c:if test="${agent.interfaceType == 1}">
							pavo调用第三方接口
						</c:if>
						<c:if test="${agent.interfaceType == 2}">
							第三方医院调用pavo接口
						</c:if>
					</td>
					<td class="text-center">${agent.groupKey}</td>
					<td class="text-center">${areaMap[agent.areaId]}</td>
					<td class="text-center">
						<c:if test="${agent.status == 0}"><span style="color:red;">禁用</span></c:if>
				 		<c:if test="${agent.status == 1}">开通</c:if>
					</td>
					<td class="text-center">
						<fmt:formatDate value="${agent.lastModifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td class="text-center">
						<div class="json-div" id="${agent.agentId}">
							<div class="div-record-json" style="display: none">
								${agent.conf}
							</div>
							<a href="javascript:void(0)">查看</a>
						</div>
					</td>
					<td class="text-center">
						<a href="${ctx}/agent/toAddorEdit?agentId=${agent.agentId}">修改</a>
						<a href="javascript:void(0)" onclick="dlt('${agent.agentId}');return false">删除</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
<script type="text/javascript">
$(document).ready(function() {

	$('div .json-div').each(function(){
		var a_json = $(this).find("a");
		var div_json = $(this).find("div");
		try{
			div_json.JSONView($.parseJSON(div_json.text()));
		}catch(err){ }
		var layer_index = 0;
		a_json.mouseover(function(){
			layer_index = layer.tips(div_json.html(), a_json, {
				  tips: [4, '#838B8B'],
				  area: ['300px'],
				  time:0
			});
		});
		a_json.mouseleave(function(){
			layer.close(layer_index);
		});
	});
});

function dlt(agentId) {
	var url = "${ctx}/agent/deleteAgentHospital" + "?agentId= " + agentId;
	/* $("#dlt").bind("click", function(){ */
	$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
		$.get(url, function(json) {
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
</script>
</body>
</html>