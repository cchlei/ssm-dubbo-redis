<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>医生文章详情 - 医生文章管理</title>
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
		<li class="active"><a href="javascript:void(0)">医生文章详情</a></li>
	</ul>
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-file"></i>医生文章详情
			</h4>
		</div>
		<div>
			<div class="text" id="u33" align="center" style="font-size: larger; font-weight: bold;">
				<p>
					<span>${doctorArticle.articleTitle}</span>
				</p>
			</div>
			<div class="text" id="u38" align="center">
				<p>
					<span><fmt:formatDate value="${doctorArticle.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
				</p>
			</div>
			<div class="text" id="u35" style="margin: 2px 20px;">
				<p>
					<span>${doctorArticle.articleContent}</span>
				</p>
			</div>
		</div>
		<div class="text" align="center" style="padding: 20px 0px;">
			<button onclick="history.go(-1)" class="btn" type="button">返 回</button>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	</script>
</body>
</html>