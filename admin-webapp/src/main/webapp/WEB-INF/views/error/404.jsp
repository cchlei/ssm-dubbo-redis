<%@ page contentType="text/html;charset=UTF-8"%><%response.setStatus(200);%><!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>404 - 页面不存在</title>
</head>
<body>
	<div class="container-fluid">
		<div class="page-header"><h1>页面不存在.</h1></div>
		<div><a href="javascript:history.go(-1)" class="btn">返回上一页</a> <a href="<%=request.getContextPath()%>/">返回首页</a></div>
	</div>
</body>
</html>