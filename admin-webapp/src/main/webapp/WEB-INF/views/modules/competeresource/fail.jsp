<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>抢号成功页面</title>
</head>

<body>
  		<label style="font-size:20px">
			抢号申请提交失败!
		</label><br><br>
		<label style="font-size:15px">
		${message}
		</label>
		<br><br><br>
		<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
</body>