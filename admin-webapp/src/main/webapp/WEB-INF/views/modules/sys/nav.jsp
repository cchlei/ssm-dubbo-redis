<%@ page contentType="text/html;charset=UTF-8"%>
<div align="left" style="float: left; width: 60%; padding-left: 50px;">
	<c:if test="${belongHospName != ''}"><h2>${belongHospName}</h2></c:if>
	<c:if test="${belongHospName == null or belongHospName == ''}"><h2>后台系统管理</h2></c:if>
</div>	
<div align="right" style="float: right; width: 40%; padding-right: 50px;">
	<a onclick="window.location.href='${ctx}/account/logout';" href="javascript:void(0);" target="mainFrame">退出</a>
</div>
	
	