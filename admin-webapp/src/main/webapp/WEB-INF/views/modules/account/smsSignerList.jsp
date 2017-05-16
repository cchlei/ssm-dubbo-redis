<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>短信列表</title>
</head>

<body>

	<form name="form" role="form" action="${ctx}/smsSigner/list" method="GET" style="height:34px">
	医院Id：<input type="text"  id="hospId" name="hospId"   style="width:100px;" value="${hospId}"/>
	短信签名：<input type="text"  id="signer" name="signer"   style="width:100px;" value="${signer}"/>
		<input type="hidden" id="page" name="page" value="${page}"/>
	&nbsp;&nbsp;<input type="submit" value="查询" />
	</form>
	<a href="${ctx}/smsSigner/save" >添加</a>	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 短 信 签名列 表 （签名是发送短信是的标识如：【导医通】）
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<!-- <th class="text-center">挂号记录ID</th> -->
				<th class="text-center">医院ID</th>
				<th class="text-center">医院签名</th>
				<th class="text-center">短信模板id</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${smsSigner}" var="sms" varStatus="status">
			<tr>
				<td>${sms.hospId}</td>
				<td>${sms.hospSigner}</td>
				<td>${sms.templateKey}</td>
				<td>
					<%-- <a href="${ctx}/processor/updateToPage?hospitalId=${hospitalConf.hospitalId}">修改</a>&nbsp;
					<a href="javascript:void(0)" onclick="dlt(${hospitalConf.hospitalId});return false">删除</a>&nbsp; --%>
					<a href="${ctx}/smsSigner/save?hospId=${sms.hospId}">修改</a>&nbsp;
					<a href="javascript:void(0)" onclick="dlt(${sms.hospId});return false">删除</a>&nbsp;
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/smsSigner/list?hospId=${hospId}"/>
<script type="text/javascript">
function dlt(hospId) {
	
	var url = "${ctx}/smsSigner/delete" + "?hospId=" + hospId
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