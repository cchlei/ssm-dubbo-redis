<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>版本管理记录列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">版本管理记录列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/sysmgr/list" method="GET">
	<%-- 版本名称：<input type="text"  id="versionName" name="versionName"  value="${version.versionName}"/>&nbsp;&nbsp;&nbsp; --%>
	版本类型：<select class="mSelect"  class="mSelect"  id="versionType" name="versionType">
	             <option value="">请选择</option>
				 <option value="0">android</option>
				 <option value="1">android资源文件</option>
				 <option value="2">ios</option>
				 <option value="3">ios资源文件</option>
				</select>&nbsp;&nbsp;&nbsp;
	<input type="submit" value="查询" />
	<a href="${ctx}/code.jsp?type=3" target="_blank">生成最新版医生端下载二维码</a>
	<input type="hidden" id="appType" name="appType" value="${appType}">
	<input type="hidden" id="versionTypeHid" name="versionTypeHid" value="${versionType}">
	</form>
   <%--  <input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/> --%>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 版本管理记录列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">版本号</th>
				<th class="text-center">版本名称</th>
				<th class="text-center">版本类型</th>
				<th class="text-center">文件地址</th>
				<th class="text-center">是否强制</th>
				<th class="text-center">创建时间</th>
				<th class="text-center">生效时间</th>
				<!-- <th class="text-center">功能描述</th>
				<th class="text-center">备注</th> -->
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${versionList}" var="version" varStatus="status">
			<tr>
			<td>${version.versionCode}</td>
			<td>${version.versionName}</td>
			<td><span id="versionTypeShow" name="versionTypeShow">${version.versionType}</span></td>
			<td>${version.fileAddress}</td>
			<td><span id="isForceUpdateShow" name="isForceUpdateShow">${version.isForceUpdate}</span></td>
			<td><fmt:formatDate value="${version.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
			<td><fmt:formatDate value="${version.effectTime}" pattern="yyyy-MM-dd HH:mm"/></td>
			<td><a href="javascript:deleteById(${version.id})">删除</a></td>
			</tr>
	       </c:forEach> 
		</table>
	</div>
<script type="text/javascript">
$(document).ready(function() {
	optionSelect();
	changeStatues();
});

function deleteById(id)
{
	var ctx = "${ctx}";

	var confirmStr ="确认删除此条记录吗？";
	$.confirm(confirmStr, function() {
			$.get(ctx+"/sysmgr/delete",{'id':id}, 
						function(json)
						{
		 			         var msg = "";
					         if (json.message) {
						         msg = json.message;
					         }
		 			         //alert(msg);			       
							 $.alert(msg, function() {
									window.location.href = ctx+'/sysmgr/list?appType=0';
							 });  
						}, "json");
	});

}
function optionSelect()
{
	var versionType=$("#versionTypeHid").val();
	$("#versionType option[value='"+versionType+"']").attr("selected", "selected");
}

function changeStatues()
{
	
	$("span[name='versionTypeShow']").each(function() {
		if($(this).text() == 0)
		{
			$(this).text('android');
		}else if($(this).text() == 1)
		{
			$(this).text('android资源');
		}else if($(this).text() == 2)
		{
			$(this).text('ios');
		}else if($(this).text() == 3)
		{
			$(this).text('ios资源文件');
		}
		
	});
	
	$("span[name='isForceUpdateShow']").each(function() {
		if($(this).text() == 0)
		{
			$(this).text('否');
		}else if($(this).text() == 1)
		{
			$(this).text('是	');
		}
		
	});
	
}

</script>
</body>
</html>