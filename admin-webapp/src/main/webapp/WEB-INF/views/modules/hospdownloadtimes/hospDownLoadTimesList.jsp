<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院二维码下载次数</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医院二维码下载次数</a></li>
	</ul>
	
	<div>
	<form name="form" role="form" action="${ctx}/hospDownLoadTimes/list" method="GET">
	开始日期：<input class="Wdate" type="text" name="startDate" id="startDate" value="${params.startDate}" onClick="WdatePicker()">
	结束日期：<input class="Wdate" type="text" name="endDate" id="endDate" value="${params.endDate}" onClick="WdatePicker()"> &nbsp;&nbsp;
	<%-- <c:if test="${params.isCount==1}">
		<input type="checkbox"  name="isCount" id="isCount"  checked="checked" value="${params.isCount}"/>汇总统计
	</c:if>
	<c:if test="${params.isCount!=1}">
		<input type="checkbox" name="isCount" id="isCount" value="${params.isCount}"/>汇总统计
	</c:if> --%>
	汇总方式：<select class="mSelect"  class="mSelect"  id="isCount" name="isCount">
	<c:choose>
	<c:when test="${params.isCount==''||params.isCount==null}">
						<option value="" selected="selected">请选择</option>
    					<option value="1">按医院汇总</option>
						<option value="2">按地区汇总</option>
	</c:when>
	<c:when test="${params.isCount==1}">
						<option value="">请选择</option>
    					<option value="1" selected="selected">按医院汇总</option>
						<option value="2">按地区汇总</option>
	</c:when>
	<c:when test="${params.isCount==2}">
						<option value="" selected="selected">请选择</option>
    					<option value="1">按医院汇总</option>
						<option value="2" selected="selected">按地区汇总</option>
	</c:when>
	<c:otherwise>
   	    <option value="" selected="selected">请选择</option>
    	<option value="1">按医院汇总</option>
		<option value="2">按地区汇总</option>
	</c:otherwise>
	</c:choose>
	</select>
	&nbsp;&nbsp;医院名称：<input type="text" id="hospName" name="hospName" value="${params.hospName }">
	<%-- 医院ID：<input type="text"  id="hospId" name="hospId"   style="width:80px;" value="${params.hospId}"/> --%>
	<button type="button"   onclick="subBut();">查询</button>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医院二维码下载次数
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<c:if test="${params.isCount==''||params.isCount==null}">
					<th class="text-center">日期</th>
				</c:if>
				<c:choose>
   					<c:when test="${params.isCount==2}">  
        				<th class="text-center">地区</th>
   					</c:when>
   					<c:otherwise> 
    					<th class="text-center">医院ID</th>
						<th class="text-center">医院名称</th>
   					</c:otherwise>
				</c:choose>
				<th class="text-center">下载次数</th>
				<th class="text-center">关注次数</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="downloadTimes" varStatus="status">
			<tr>
				<c:if test="${params.isCount==''||params.isCount==null}">
					 <td  class="text-center"><fmt:formatDate value="${downloadTimes.downloadDate}" pattern="yyyy-MM-dd"/></td>
				</c:if>
				<c:choose>
   					<c:when test="${params.isCount==2}">  
        				<td  class="text-center">${downloadTimes.areaName}</td>
   					</c:when>
   					<c:otherwise> 
    					<td  class="text-center">${downloadTimes.hospId}</td>
						<td  class="text-center">${downloadTimes.hospName}</td>
   					</c:otherwise>
				</c:choose>
				<td  class="text-center">${downloadTimes.downTimes}</td>
				<td  class="text-center">${downloadTimes.subscribeTimes}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
    <page:page pager="${page}" linkUrl="${ctx}/hospDownLoadTimes/list?startDate=${params.startDate}&endDate=${params.endDate}&hospId=${params.hospId}&byDay=${params.byDay}&isCount=${params.isCount}&hospName=${params.hospName }"/>	
<script type="text/javascript">



function subBut(){
/* 	var pCheckBox = $("[name = isCount]:checkbox").prop('checked');
	if(pCheckBox){
		$("[name = isCount]:checkbox").val(1);
		}else{
			$("[name = isCount]:checkbox").val(0);
		} */
	if($("#isCount").val()==2){
		$("#hospName").val("");
	}
	this.form.submit();  
	};


$(document).ready(function() {
/* 	 $("[name = isCount]:checkbox").bind("click", function () {
		var pCheckBox = $("[name = isCount]:checkbox").prop('checked');
		if(pCheckBox){
			$("[name = isCount]:checkbox").val(1);
		}else{
			$("[name = isCount]:checkbox").val(0);
		}
	 });  */
	if("${params.isCount}"!=""){
		$("#isCount").val("${params.isCount}");
	}	
	 
	 
	if($("#isCount").val()==2){
		$("#hospName").val("");
	}
	
	$("#isCount").change(function(){
		if($("#isCount").val()==2){
			$("#hospName").val("");
		}
	});
	
});

</script>
</body>
</html>