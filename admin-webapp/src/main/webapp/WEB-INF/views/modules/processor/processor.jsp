<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>标签列表</title>

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
		<li class="active"><a href="javascript:void(0)">前置机列表</a></li>
	</ul>
	<div>
		<form  name="form" role="form" action="${ctx}/processor/list" method="POST">
			    渠道类型：<select class="mSelect"  id="interfaceType" name="interfaceType">
					    <option value="">请选择</option>
						<option value="0">第三方医院调用pavo接口</option>
						<option value="1">pavo调用第三方接口</option>
						<option value="2">前置机</option>
					</select>
			<input type="submit" value="查询" />
		</form>
   		<a href="${ctx}/processor/toAddorEdit" >添加前置机</a> 
    </div>

<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>前置机信息查询列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<th class="text-center" width="200px">前置机</th>
				<th class="text-center">唯一编号</th>
				<th class="text-center">接入类型</th>
				<th class="text-center">处理方式</th>
				<th class="text-center">地区</th>
				<th class="text-center">最早预约时间</th>
				<th class="text-center">最迟预约时间</th>
				<th class="text-center">JSON配置</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="today"/>
			<c:forEach items="${hospitalConfList}" var="hospitalConf" varStatus="status">
				<tr>
					<td class="text-center">${hospitalConf.hospName}</td>
					<td class="text-center">${hospitalConf.hospitalId}</td>
					<td class="text-center">
						<c:if test="${hospitalConf.interfaceType == null}">
							未知类型(请检查)
						</c:if>
						<c:if test="${hospitalConf.interfaceType == 0}">
							第三方医院调用pavo接口
						</c:if>
						<c:if test="${hospitalConf.interfaceType == 1}">
							pavo调用第三方接口
						</c:if>
						<c:if test="${hospitalConf.interfaceType == 2}">
							前置机
						</c:if>
					</td>
					<td class="text-center">${hospitalConf.groupKey}</td>
					<td class="text-center">${areaMap[hospitalConf.areaId]}</td>
					<td class="text-center">${hospitalConf.beginRegisterTime}</td>
					<td class="text-center">${hospitalConf.overRegisterTime}</td>
					<td class="text-center">
						<div class="json-div" id="${hospitalConf.hospitalId}">
							<div class="div-record-json" id="${hospitalConf.hospitalId}-json-div" style="display: none">
								${hospitalConf.conf}
							</div>
							<a href="javascript:void(0)">查看</a>
						</div>
					</td>
					<td class="text-center">
						<a href="${ctx}/processor/toAddorEdit?hospitalId=${hospitalConf.hospitalId}">修改</a>
						<a href="javascript:void(0)" onclick="dlt('${hospitalConf.hospitalId}');return false">删除</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
<script>
$(document).ready(function() {
	//查询条件赋值
	if("${interfaceType}"!=""){
		$("#interfaceType").val("${interfaceType}");
	}

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
	
	/*
	$('div .div-record-json').each(function(i){
		try {
			$(this).JSONView($.parseJSON($(this).text()));
		} catch (e) {}
	})
	*/
});
function dlt(hospitalId) {
	var url = "${ctx}/processor/delete" + "?hospitalId= " + hospitalId;
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