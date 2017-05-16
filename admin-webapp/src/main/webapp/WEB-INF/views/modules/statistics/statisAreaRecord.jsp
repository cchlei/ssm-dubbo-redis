<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>统计管理</title>
</head>

<body>
		<div class="form-group">
		<form name="form" role="form" action="${ctx}/statistics/statisticsAreaRecordNum" method="GET">
			<input type="hidden" id="type" name="type" value="${type}" />
			统计维度<font color="#FF0000">*</font>：<select class="mSelect"  class="mSelect"  id="dimension" name="dimension">
			    <option value="">请选择</option>
				<option value="date">日期</option>
				<option value="parea">省级城市</option>
				<option value="area">地级城市</option>
				<option value="hosp">医院</option>
				<option value="creator">操作人</option>
			</select> 
			开始日期<font color="#FF0000">*</font>：<input class="Wdate" type="text" name="queryBeginDate" id="queryBeginDate"  style="width:120px;" value="" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'queryEndDate\')}'})">
			截止日期<font color="#FF0000">*</font>：<input class="Wdate" type="text" name="queryEndDate" id="queryEndDate"  style="width:120px;"  value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryBeginDate\')}'})">
			所在地：<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent">
				<option value="0">请选择</option>
				<c:forEach items="${areaList}" var="area" varStatus="status">
					<c:if test="${area.parentId==0}">
						<c:choose>
							<c:when test="${areaIdParent!=null && areaIdParent==area.areaId}">
								<option value="${area.areaId}" selected="selected">${area.areaName}</option>
							</c:when>
							<c:otherwise>
								<option value="${area.areaId}">${area.areaName}</option>
							</c:otherwise>
						</c:choose> 	
					</c:if>
				</c:forEach>
			</select>
			&nbsp;&nbsp;
			<input type="submit" id="searchDoc" value="查询" onclick="return check(this.form)"/>
		</form>
		</div>

     <div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 数据信息
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter table2">
			<thead>
			<tr>
			    <th class="text-center">名称</th>
				<th class="text-center">数量</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="resource" varStatus="status">
			<tr>
				<td>${resource.name}</td>
				<td>${resource.count}</td>
			</tr>
			</c:forEach>
		</table>
	</div>

<script type="text/javascript">
var ctx = "${ctx}";
 $(document).ready(function() {
	if("${queryBeginDate}"!=""){
		$("#queryBeginDate").val("${queryBeginDate}");
	}
	if("${queryEndDate}"!=""){
		$("#queryEndDate").val("${queryEndDate}");
	}
	if("${dimension}"!=""){
		$("#dimension").val("${dimension}");
	}
	if("${source}"!=""){
		$("#source").val("${source}");
	}
});

var ascending = false;
function sort(){
    var sorted = $('.results-row').sort(function(a,b){
        return (ascending ==
               (convertToNumber($(a).find('.price').html()) < 
                convertToNumber($(b).find('.price').html()))) ? 1 : -1;
    });
    ascending = ascending ? false : true;

    $('.results').html(sorted);
}
var convertToNumber = function(value){
    return parseFloat(value.replace('$',''));
}
</script>
</html>