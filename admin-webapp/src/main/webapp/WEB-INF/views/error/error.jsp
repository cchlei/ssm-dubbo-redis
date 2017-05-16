<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%response.setStatus(200);%>
<%
	Throwable ex = null;
	if (exception != null)
		ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request.getAttribute("javax.servlet.error.exception");
	//记录日志
	if (ex!=null){
		Logger logger = LoggerFactory.getLogger("error.jsp");
		logger.error(ex.getMessage(), ex);
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>errorpage - 系统业务错误</title>
</head>
<body>
	<div class="container-fluid">
		<div class="page-header"><h1>系统发生业务错误.</h1></div>
		<%-- <p>错误信息：</p><p>
		<%out.print(ex+"<br/>");%> --%>
		</p>
		<div><a href="javascript:history.go(-1)" class="btn">返回上一页</a></div>
	</div>
</body>
</html>