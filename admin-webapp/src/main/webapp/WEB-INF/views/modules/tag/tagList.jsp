<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>标签列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">标签列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/tag/list" method="GET">
	标签名称：<input type="text"  id="tagName" name="tagName" value="${params.tagName}"/>&nbsp;&nbsp;&nbsp;
	排序：<input type="text"  id="weight" name="weight"   value="${params.weight}"/>&nbsp;&nbsp;&nbsp;
	状态：<select class="sSelect" class="sSelect"  id="status" name="status">
	 <c:if test="${params.status==''||params.status==null||params.status==0}">
	 <option value="0"  selected="selected">请选择</option>
	 <option value="1">启用</option>
	 <option value="2">禁用</option>
	 </c:if>
	 <c:if test="${params.status==1}">
	 <option value="0">请选择</option>
	 <option value="1" selected="selected">启用</option>
	 <option value="2">禁用</option>
	 </c:if>
	 <c:if test="${params.status==2}">
	 <option value="0">请选择</option>
	 <option value="1">启用</option>
	 <option value="2" selected="selected">禁用</option>
	 </c:if>
	</select>
	<input type="button"  onclick="searchBut();" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="${ctx}/tag/toAddorEdit">添加标签</a>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 标 签 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">标签名称</th>
				<th class="text-center">排序</th>
				<th class="text-center">状态</th>
				<th class="text-center">创建人</th>
				<th class="text-center">创建时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${newsTag}" var="tag" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td>${tag.tagName}</td>
				<td>${tag.weight}</td>
				<td>
				 <c:if test="${tag.status==2}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${tag.status==1}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${tag.tagId}','${tag.status}')">切换</button>
				<td>${tag.userId}</td>
				<td><fmt:formatDate value="${tag.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><a href="${ctx}/tag/toAddorEdit?tagId=${tag.tagId}">修改</a>&nbsp;<a href="#" del_id="${tag.tagId}">删除</a></td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/tag/list?tagName=${params.tagName}&weight=${params.weight}&status=${params.status}"/>
<script type="text/javascript">
$(document).ready(function() {
	var weight = $("#weight").val();
	if(weight==0){
		$("#weight").val("");
	}
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get("${ctx}/tag/delete/"+id, function(json) {
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

function searchBut(){
	var weight = $("#weight").val();
	if(weight!="" && !checkRate(weight)){
		   alert("查询条件“排序”请输入整数！");
		   return;
		}
	if(weight==""||weight==null){
		$("#weight").val(0);
	}
	var tagName = $("#tagName").val();
	$("#tagName").val($.trim(tagName));
	this.form.submit();
}

function changeStat(tagId,status){
	//转换地区启用禁用状态
	if(status==2){
		status=1;
	}else if(status==1){
		status=2;
	} 
	var change = tagId+","+status;
	url="${ctx}/tag/list?change="+change;
	//alert(url);
	window.location.href=url;
	
}

//判断正整数  
function checkRate(value)  
{ 
     var re = /^[1-9]+[0-9]*]*$/;
     if (!re.test(value))  
    {  
        return false;  
     }else{
    	 return true;
     }  
     
}  
</script>
</body>
</html>