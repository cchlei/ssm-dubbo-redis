<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>资讯新闻列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">资讯新闻列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/news/list" method="GET">
	标题：<input type="text"  id="title" name="title"  value="<c:out value='${newsInfo.title}'/>"/>&nbsp;&nbsp;&nbsp;
	权重：<input type="text"  id="weight" name="weight"   value="${newsInfo.weight}"/>&nbsp;&nbsp;&nbsp;
	<%-- 是否推荐到首页：<select class="mSelect"  class="mSelect"  id="ifHomePage" name="ifHomePage">
				 <c:if test="${newsInfo.ifHomePage==2}">
				 <option value="2" selected="selected">否</option>
				 <option value="1">是</option>
				 </c:if>
				 <c:if test="${newsInfo.ifHomePage==1}">
				 <option value="2">否</option>
				 <option value="1" selected="selected">是</option>
				 </c:if>
				 <c:if test="${newsInfo.ifHomePage=='0'}">
				 <option value="0">请选择</option>
				 <option value="2">否</option>
				 <option value="1">是</option>
				 </c:if>
				</select>
	&nbsp;&nbsp;&nbsp; --%>
	所属标签：
	<select class="mSelect"  class="mSelect"  id="tag" name="tag">
	<option value="0">请选择</option>
	<c:forEach items="${newsTags}" var="tags" varStatus="index">
		<c:if test="${newsInfo.tag==tags.tagId}">
			<option value="${tags.tagId}" selected="selected">${tags.tagName}</option>
		</c:if>
	    <c:if test="${newsInfo.tag!=tags.tagId}">
			<option value="${tags.tagId}">${tags.tagName}</option>
		</c:if>
	</c:forEach>
	</select>
	&nbsp;&nbsp;&nbsp;<input type="button"  onclick="searchBut();" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="${ctx}/news/toAddorEdit">添加资讯</a>
	</form>
	
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 资 讯 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
			    <th class="text-center">图片</th>
				<th class="text-center">标题</th>
				<!-- <th class="text-center">关键字</th> -->
				<th class="text-center">摘要</th>
				<!-- <th class="text-center">是否推荐到首页</th> -->
				<th class="text-center">阅读数</th>
				<th class="text-center">权重</th>
				<th class="text-center">导医通端是否显示</th>
				<th class="text-center">体检宝端是否显示</th>
				<th class="text-center">发布人</th>
				<th class="text-center">修改时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${newsList}" var="news" varStatus="status">
			<tr>
				<td class="text-center">${status.count}</td>
				<td class="text-center"><img src="${ctx}/showImage/showImg?path=${news.imageurl}" id="img1" width="100px" height="100px"  /></td>
				<td>${news.title}</td>
				<%-- <td>${news.keywords}</td> --%>
				<td>${news.abstracts}...</td>
				<%-- <td>
				<c:if test="${news.ifHomePage=='2'}">否</c:if>
				<c:if test="${news.ifHomePage=='1'}">是</c:if>
				</td> --%>
				<td>${news.readTimes}</td>
				<td>${news.weight}</td>
				<td class="text-center">
				<c:if test="${news.pavoShow=='0'}">否</c:if>
				<c:if test="${news.pavoShow=='1'}">是</c:if>
				</td>
				<td  class="text-center">
				<c:if test="${news.physicalShow=='0'}">否</c:if>
				<c:if test="${news.physicalShow=='1'}">是</c:if>
				</td>
				<td>${news.userId}</td>
				<td><fmt:formatDate value="${news.modifyTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><a href="${ctx}/news/toAddorEdit?newsId=${news.newsId}">修改</a>&nbsp;<a href="#" del_id="${news.newsId}">删除</a></td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/news/list?title=${params.title}&weight=${params.weight}&tag=${params.tag}"/>
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
				$.get("${ctx}/news/delete/"+id, function(json) {
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
		   alert("查询条件“权重”请输入整数！");
		   return;
		}
	if(weight==""||weight==null){
		$("#weight").val(0);
	}
	var title = $("#title").val();
	$("#title").val($.trim(title));
	this.form.submit();
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