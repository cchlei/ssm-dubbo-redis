<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>医生文章列表 - 医生文章管理</title>
<style type="text/css">
.contioner .imgdiv {
	float: left;
	width: 100px;
}

.contioner .imgurl {
	float: left;
	cursor: pointer;
	padding: 3px;
}

.contioner .desc {
	padding-top: 10px;
	width: 100px;
}
</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生文章列表</a></li>
	</ul>
	<br />
	<div class="form-group">
		<form name="form" role="form" action="${ctx}/doctorArticle/list" method="GET">
			医生名称： <input id="doctorName" name="doctorName" type="text"
				value="${params.doctorName}" />&nbsp;&nbsp;&nbsp;
			文章标题: <input id="articleTitle" name="articleTitle" type="text"
				value="${params.articleTitle}" />&nbsp;&nbsp;&nbsp;
			<button type="submit" class="btn" value="" >搜索</button>
		</form>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>医生文章列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
				<tr>
					<th class="text-center" width="20">发布时间</th>
					<th class="text-center" width="10%">医生名称</th>
					<th class="text-center" width="60%">文章标题</th>
					<th class="text-center" width="10">操作</th>
				</tr>
			</thead>
			<c:forEach items="${articleList }" var="article">
				<tr>
					<td class="text-center"><fmt:formatDate
							value="${article.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td class="text-center">${article.doctorUserName}</td>
					<td class="text-center">${article.articleTitle}</td>
					<td class="text-center"><a href="${ctx}/doctorArticle/info/${article.articleId}">查看</a></td>
					
				</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}"
		linkUrl="${ctx}/doctorArticle/list?params.doctorName=${params.doctorName}&params.articleTitle=${params.articleTitle}" />
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		 /*-----------查询 start---------*/
		function subBut(){
			
			var standardDepIdChild = $("#standardDepIdChild").val();
			if(standardDepIdChild == ""){
				alert("请选择科室!");
				return;
			}
			var departmentId = $("#standardDepIdChild").val();
			 if(departmentId!=0){
			   $("#departmentId").val(departmentId);
			 } 
			this.form.submit();  
		};
		/*------------查询 end---------*/
		
	</script>
</body>
</html>