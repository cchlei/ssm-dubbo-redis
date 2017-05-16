<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>统计管理</title>
</head>

<body>
		<div class="form-group">
		<form name="form" role="form" action="${ctx}/statistics/statisticsNareaRecordNum" method="GET">
			<input type="hidden" id="sim" name="sim" value="0" />
			<input type="hidden" id="type" name="type" value="${type}" />
			来源：<select class="mSelect"  class="mSelect"  id="source" name="source">
			    <option value="">请选择</option>
				<option value="1">人工挂号</option>
				<option value="4">VIP挂号</option>
				<option value="5">现场挂号</option>
				<option value="7">项目预约</option>
				<option value="9">网站预约</option>
				<option value="10">区域预约</option>
				<option value="12">合作医院</option>
				<option value="13">云挂号</option>
			</select> 		
			统计维度<font color="#FF0000">*</font>：<select class="mSelect"  class="mSelect"  id="dimension" name="dimension" onchange=" checkvisible(this.value)">
			    <option value="">请选择</option>
				<option value="date">日期</option>
				<!-- <option value="parea">省级城市</option>
				<option value="area">地级城市</option> -->
				<option value="hosp">医院</option>
				<option value="creator">操作人</option>
				<option value="invitation">邀请码</option>
				<option value="dau">活跃用户</option>
				<option value="new_users">新增用户</option>
				<option value="new_patients">新增病人</option>
				<option value="wxsource">合作渠道</option>
			</select> 
			开始日期<font color="#FF0000">*</font>：<input class="Wdate" type="text" name="queryBeginDate" id="queryBeginDate"  style="width:120px;" value="" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'queryEndDate\')}'})">
			截止日期<font color="#FF0000">*</font>：<input class="Wdate" type="text" name="queryEndDate" id="queryEndDate"  style="width:120px;"  value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryBeginDate\')}'})">
			&nbsp;&nbsp;
			<input type="submit" id="searchDoc" value="查询" onclick="return check(this.form)"/>
			<br><br>
<%-- 			所在地：<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent">
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
			</select> --%>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div id="unCount"  style="display: inline;">
				<c:if test="${isCount==1}">
					<input type="checkbox"  name="isCount" id="isCount"  checked="checked" value="${isCount}"/>包含渠道
				</c:if>
				<c:if test="${isCount!=1}">
					<input type="checkbox" name="isCount" id="isCount" value="${isCount}"/>包含渠道
				</c:if>
			</div>
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
	
	 $("[name = isCount]:checkbox").bind("click", function () {
			var pCheckBox = $("[name = isCount]:checkbox").prop('checked');
			if(pCheckBox){
				$("[name = isCount]:checkbox").val(1);
			}else{
				$("[name = isCount]:checkbox").val(0);
			}
		 }); 
	 checkvisible("${dimension}");
	 //alert("${dimension}");
});
 
	 
function check(form) {
	var source = form.source.value;
	if(source=='1' || source=='') {
		if(form.dimension.value=='creator'){
		       alert("人工挂号无法按操作人维度统计!");
		       return false;
		}
	}
	var pCheckBox = $("[name = isCount]:checkbox").prop('checked');
	if(pCheckBox){
		$("[name = isCount]:checkbox").val(1);
		}else{
			$("[name = isCount]:checkbox").val(0);
		}
	return true;
}

var ascending = false;
var a = 0;
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


function checkvisible(select){
	if(select!="date"&&select!="parea"&& select!="area"&& select!="hosp"&&select!="creator"){
		$("#unCount").hide();
	}else{
		$("#unCount").show()
	}
	
}
</script>
</html>