<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生排班列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生排班列表</a></li>
	</ul>
	
	<div>
	<form name="form" role="form" action="${ctx}/timeslice/timeSliceList" method="GET">
	姓名：<input type="text"  id="doctorName" name="doctorName"  value="<c:out value='${params.doctorName}'/>"/>&nbsp;&nbsp;&nbsp;
	服务项目：<select class="mSelect" id="type" name="type">
		<option value="">请选择</option>
		<option value="1">图文咨询</option>
		<option value="2">电话咨询</option>
		<option value="3">视频咨询</option>
	</select>&nbsp;&nbsp;&nbsp;
	服务时间：<select class="mSelect" id="timeSlice" name="timeSlice">
		<option value="">请选择</option>
		<option value="0">全天</option>
		<option value="1">上午</option>
		<option value="2">下午</option>
		<option value="3">晚上</option>
	</select>
	&nbsp;&nbsp; <button type="submit" class="btn">查询</button>&nbsp;&nbsp;<span style="color:blue">需填写医生姓名才可查询结果！</span>
	</form>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医生排班列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">医生姓名</th>
				<th class="text-center">周几</th>
				<th class="text-center">服务时间</th>
				<th class="text-center">图文咨询</th>
				<th class="text-center">图文咨询价格</th>
				<th class="text-center">电话咨询</th>
				<th class="text-center">电话咨询价格</th>
				<th class="text-center">视频咨询</th>
				<th class="text-center">视频咨询价格</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="timeSlice" varStatus="status">
			<tr>
			    <td  class="text-center">${timeSlice.doctorName}</td>
			    <td  class="text-center">
			    <c:if test="${timeSlice.week==0}">周日</c:if>
			    <c:if test="${timeSlice.week==1}">周一</c:if>
			    <c:if test="${timeSlice.week==2}">周二</c:if>
			    <c:if test="${timeSlice.week==3}">周三</c:if>
			    <c:if test="${timeSlice.week==4}">周四</c:if>
			    <c:if test="${timeSlice.week==5}">周五</c:if>
			    <c:if test="${timeSlice.week==6}">周六</c:if>
			    </td>
			    <td  class="text-center">
			    <c:if test="${timeSlice.timeSlice==0}">全天</c:if>
			    <c:if test="${timeSlice.timeSlice==1}">上午</c:if>
			    <c:if test="${timeSlice.timeSlice==2}">下午</c:if>
			    <c:if test="${timeSlice.timeSlice==3}">晚上</c:if>
			    </td>
			    <td  class="text-center">
			    <c:if test="${timeSlice.im==1}">图文咨询</c:if>
			    <c:if test="${timeSlice.im==0}">--</c:if>
			    </td>
			    <td  class="text-center">
			    <c:if test="${timeSlice.im==1}">${doctorImPrice}</c:if>
			    <c:if test="${timeSlice.im==0}">--</c:if>
			    </td>
			    <td  class="text-center">
			    <c:if test="${timeSlice.phone==1}">电话咨询</c:if>
			    <c:if test="${timeSlice.phone==0}">--</c:if>
			    </td>
			    <td  class="text-center">
			    <c:if test="${timeSlice.phone==1}">${doctorPhonePrice}</c:if>
			    <c:if test="${timeSlice.phone==0}">--</c:if>
			    </td>
			    <td  class="text-center">
			    <c:if test="${timeSlice.video==1}">视频咨询</c:if>
			    <c:if test="${timeSlice.video==0}">--</c:if>
			    </td>
			    <td  class="text-center">
			    <c:if test="${timeSlice.video==1}">${doctorVideoPrice}</c:if>
			    <c:if test="${timeSlice.video==0}">--</c:if>
			    </td>
				
			</tr>
			</c:forEach>
		</table>
	</div>
    <page:page pager="${page}" linkUrl="${ctx}/timeslice/timeSliceList?doctorName=${params.doctorName}&timeSlice=${params.timeSlice}&type=${params.type}"/>
    
    	
<script type="text/javascript">
var ctx = "${ctx}";
	$(document).ready(function() {
		//查询条件赋值
		var timeSlice = "${params.timeSlice}";
		$("#timeSlice").val(timeSlice);
		
		var type = "${params.type}";
		$("#type").val(type);
		
	});
	
	

</script>
</body>
</html>