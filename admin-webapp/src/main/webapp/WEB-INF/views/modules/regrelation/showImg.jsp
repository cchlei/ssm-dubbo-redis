<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>注册医生列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<c:forEach items="${imgList}" var="img" varStatus="status">
	       <img src ="${img}" width="50%" height="30%"></img><br/><br/>
	</c:forEach>
<script>
</script>
</body>