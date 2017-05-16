<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>短信列表</title>
</head>

<body>

	<form name="form" role="form" action="${ctx}/sms/list" method="GET" style="height:34px">
	手机号：<input type="text"  id="phone" name="phone"   style="width:100px;" value="${phone}"/>
		<input type="hidden" id="page" name="page" value="${page}"/>
	      发送时间：<input class="Wdate" type="text" name="sendTime" id="sendTime"  value="<fmt:formatDate value="${msg.sendTime}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;
	&nbsp;&nbsp;<input type="submit" value="查询" />
	</form>
		
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 短 信 列 表 （一般mk的都是空号停机的；其他cu的基本都是联通的失败报告；空号停机信号不好等都有可能；
				）
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<!-- <th class="text-center">挂号记录ID</th> -->
				<th class="text-center">手机号</th>
				<th class="text-center">短信内容</th>
				<th class="text-center">发送时间</th>
				<!-- <th class="text-center">返回报告</th> -->
				<th class="text-center">用户接收状态</th>
			</tr>
			</thead>
			<c:forEach items="${smslist}" var="sms" varStatus="status">
			<tr>
				<!-- <td class="text-center">${sms.recordId}</td> -->
				<td>${sms.phone}</td>
				<td>${sms.cont}</td>
				<td><fmt:formatDate value="${sms.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<!-- <td>${sms.sendResult}</td> -->
				<td> 
					<c:choose>
						<c:when test="${sms.userResult=='DELIVRD'}">成功</c:when>  
					    <c:when test="${sms.userResult=='BLACKMB'}">拒收</c:when>
					    <c:when test="${sms.userResult=='History'}">成功</c:when>
					    <c:when test="${sms.userResult=='DEPTY'}">已重发</c:when>
					    <c:when test="${sms.userResult=='DEPTYFAIL'}">重发失败</c:when>
					    <c:when test="${sms.userResult=='CU3:10' || sms.userResult=='UNDELIV'}">用户关机</c:when>
					    <c:when test="${sms.userResult=='' || sms.userResult==NULL}">发送中</c:when>
						<c:otherwise>${sms.userResult}</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/sms/list?phone=${phone}"/>
<script type="text/javascript">
</script>
</body>
</html>