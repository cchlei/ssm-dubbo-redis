<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>发送信息查询列表</title>
</head>
<body>
	<form name="form"  action="${ctx}/sms/smsList1">
    <input type="hidden" id="page" name="page" value="${page}"/>
	发送手机号：<input type="text"  id="phone" name="phone"   style="width:100px;" value="${smsMsg.phone}"/>
	身份证号码：<input type="text"  id="idcard" name="idcard"   style="width:160px;" value="${smsMsg.idcard}"/>
	挂号类型：<select class="mSelect"  class="mSelect"  id="isGuide" name="isGuide" >
	    <option value="">请选择</option>
		<option value="1">手机APP挂号</option>
		<!-- <option value="2">第三方挂号</option> -->
		<!-- <option value="3">客服人工挂号</option> -->
		<option value="4">VIP挂号类型挂号</option>
		<option value="5">现场挂号</option>
		<!-- <option value="6">电话挂号</option> -->
		<option value="7">行业项目挂号</option>
		<option value="8">医院web端挂号</option>
	</select>
	发送时间：<input class="Wdate" type="text" name="sendTime" id="sendTime"  value="<fmt:formatDate value="${smsMsg.sendTime}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;
	<input type="button" onclick="subBut()"  value="查询" />
    </form>
    <div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>发送信息查询列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<th class="text-center">发送时间</th>
				<th class="text-center">发送手机号</th>
			    <th class="text-center">就诊人身份证</th>
				<th class="text-center">发送内容</th>
				<th class="text-center">发送状态</th>
			</tr>
			</thead>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="today"/>
			<c:forEach items="${smsMsgList}" var="smsMsg" varStatus="status">
			<tr>
				<td>
				<fmt:formatDate value="${smsMsg.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>${smsMsg.phone}</td>
				
				<td>${smsMsg.idcard}</td>
				<td>${smsMsg.cont}</td>
				<td>
				<c:choose>
					<c:when test="${smsMsg.userResult=='NULL'}">发送中</c:when>  
					<c:when test="${smsMsg.userResult=='DELIVRD'}">成功</c:when>  
				    <c:when test="${smsMsg.userResult=='BLACKMB'}">拒收</c:when>
				    <c:when test="${smsMsg.userResult=='History'}">成功</c:when>
				    <c:when test="${smsMsg.userResult=='CU3:10' || sms.userResult=='UNDELIV'}">用户关机</c:when>
					<c:otherwise>${smsMsg.userResult}</c:otherwise>
				</c:choose>
				</td>
				
			</tr>
			</c:forEach>
		</table>
	</div>
	<c:if test="${!empty params.idcard || !empty params.phone}">
		<page:page pager="${page}" linkUrl="${ctx}/sms/smsList1?isGuide=${params.isGuide}&idcard=${params.idcard}&phone=${params.phone}&sendTime=${params.sendTime}"/>	
	</c:if>
	<c:if test="${empty params.idcard && empty params.phone}">
		<page:page pager="${page}" linkUrl="${ctx}/sms/smsList?phone=${phone}"/>	
	</c:if>
	
	
<script type="text/javascript">
$(document).ready(function() {
	//查询条件赋值
	if("${smsMsg.registrationRecordSource}"!=""){
		$("#isGuide").val("${smsMsg.registrationRecordSource}");
	}
	
});
var ctx = "${ctx}";
function subBut(){
	var phone = $("#phone").val();
	var idcard = $("#idcard").val();
	if(phone == "" && idcard == ""){
		if(phone == "" && idcard != ""){
			this.form.submit();
			return;
		}else if(phone != "" && idcard == ""){
			this.form.submit();
			return;
		}else{
			alert("电话或者身份证必须有一个不为空");
		}
		
	}else{
		this.form.submit();
	}
	
}
</script>
</body>
</html>