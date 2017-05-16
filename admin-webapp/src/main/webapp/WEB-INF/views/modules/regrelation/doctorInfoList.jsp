<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>注册医生列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">注册医生列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/regrelation//getRegisterDoctorInfoList" method="GET">
	姓名：<input type="text"  id="doctorRegisterName" name="doctorRegisterName"  value="${selectInfo.doctorRegisterName}"/>&nbsp;&nbsp;&nbsp;
	医院：<input type="text"  id="hospital" name="hospital"   value="${selectInfo.hospital}"/>&nbsp;&nbsp;&nbsp;
	科室: <input type="text"  id="department" name="department"  value="${selectInfo.department}"/>&nbsp;&nbsp;&nbsp;
	审核状态：
	<select class="mSelect"  class="mSelect"  id="statues" name="statues" >
	<option value="-1">全部</option>
	<option value="0">未审核</option>
	<option value="1">审核已通过</option>
	<option value="2">审核未通过</option>
	</select>
	<input type="hidden" name="statuesIndex" id="statuesIndex" value="${selectInfo.statues}">
	&nbsp;&nbsp;&nbsp;<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</form>
	
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 注册医生列表
			</h4>
		</div>
 		<table class="table table-bordered table-hover tablesorter" style="table-layout:fixed;word-break:break-all">
			<thead>
			<tr>
			    <th class="text-center" style="width:10%; ">姓名</th>
			    <th class="text-center" style="width:20%; ">医院</th>
				<th class="text-center" style="width:10%; ">科室</th>
				<th class="text-center" style="width:10%; ">电话</th>
				<th class="text-center" style="width:15%; ">邮件地址</th>
				<th class="text-center" style="width:15%; ">执业证书</th>
				<th class="text-center" style="width:10%; ">审核状态</th>
				<th class="text-center" style="width:10%; ">审核</th>
				<th class="text-center" style="width:10%; ">关联</th>
			</tr>
			</thead>
			<input type="hidden" name="downFilePath" id ="downFilePath" value="${downFilePath}"/>
			<c:forEach items="${doctorInfoList}" var="doctorInfo" varStatus="idxStatus">
			<tr>
			    <input type="hidden" id ="indexId" name="indexId" value="${idxStatus.index}">
			    <input type="hidden" id ="doctorRegisterId" name ="doctorRegisterId" value="${doctorInfo.doctorRegisterId}"/>
				<td class="text-center"><span id="doctorRegisterName">${doctorInfo.doctorRegisterName}</span></td>		
				<td><span id="hospital">${doctorInfo.hospital}</span></td>
				<td><span id="department">${doctorInfo.department}</span></td>
				<td>${doctorInfo.phone}</td>
				<td>${doctorInfo.email}</td>
				<td class="text-center"><img src="${downFilePath}?path=${doctorInfo.certificateImg}" id="img1" name="img1" width="100px" height="100px" onclick="showImgWindow('${doctorInfo.certificateImg}')"/></td>
				<td class="text-center"><span id="statuesName" name="statuesName">${doctorInfo.statues}</span></td>
				<td class="text-center">
				<a class="passA" href="javascript:pass(0,${doctorInfo.doctorRegisterId},1)">通过</a>
				<a class="nopassA" href="javascript:pass(0,${doctorInfo.doctorRegisterId},2)">不通过</a>
				</td>
				<td class="text-center"><a class="examineA" href ="javascript:examine(${doctorInfo.doctorRegisterId},'${doctorInfo.doctorRegisterName}','${doctorInfo.hospital}','${doctorInfo.department}')">关联</a></td>
			</tr>
			</c:forEach>
		</table>			
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/regrelation/getRegisterDoctorInfoList?doctorRegisterName=${selectInfo.doctorRegisterName}&hospital=${selectInfo.hospital}&department=${selectInfo.department}&statues=${selectInfo.statues}"/>
<script type="text/javascript">
$(document).ready(function() {
	optionSelected();
	changeStatues();
	updateImg();
});
function changeStatues()
{
	
	$("span[name='statuesName']").each(function(index,element) {
		if($(this).text() == 0)
		{
			$(this).text('未审核');
			$(".examineA").eq(index).hide();
			
		}else if($(this).text() == 1)
		{
			$(this).text('已通过');
			$(".passA").eq(index).hide();
		}else if($(this).text() == 2)
		{
			$(this).text('未通过');
			$(".nopassA").eq(index).hide();
			$(".examineA").eq(index).hide();
		}	
	});
}
function optionSelected()
{
	var statuesValue =$("#statuesIndex").val();
	//alert(statuesValue);
	//alert(statuesValue);
	//alert($("#statues").val());
	//$("#statues").find("option").eq(statuesValue).attr("selected","selected");
	$("#statues option[value='"+statuesValue+"']").attr("selected", "selected");
	//$("#statues option[value='']")
	//$("#statues").attr("value",statuesValue);
}
function examine(doctorRegisterId,doctorRegisterName,hospital,department){

	var url="getRelevanceDoctorInfoList";
	//window.location.href="getRelevanceDoctorInfoList?doctorRegisterId="+doctorRegisterId;
	window.location.href="${ctx}/regrelation/getRelevanceDoctorInfoList?doctorRegisterId="+doctorRegisterId;
	//$.post(url,{'doctorRegisterId':doctorRegisterId,'doctorRegisterName':doctorRegisterName,'hospital':hospital,'department':department});
}
function showImgWindow(img)
{
	var ctx = "${ctx}";
	window.open (ctx+"/regrelation/toShowImg?img="+img , "_blank",
    "height=200,width=500,scrollbars=yes,location=no left=200 top=200");
}
function updateImg()
{
	var downFilePath = $("#downFilePath").val();
	$("img").each(function() {
	   var src =$(this).attr("src");
	   var pathTemp =src.split("|");
	   var path =pathTemp[0];
	   $(this).attr("src",path);
	  // alert($(this).attr("src"));
	  // alert($("#img1")[0].src); 
	});
}
function pass(doctorId,doctorRegisterId,statues)
{
	var ctx = "${ctx}";
	var confirmStr ="确认审核通过吗？";
	if(statues ==2)
	{
		confirmStr="确认审核不通过吗？";
	}
	$.confirm(confirmStr, function() {
		$.get(ctx+"/regrelation/saveDoctorInfoStatues",{'doctorId':doctorId,'doctorRegisterId':doctorRegisterId,'statues':statues}, 
				function(json)
				{

 			         var msg = "";
			         if (json.message) {
				         msg = json.message;
			         }
 			         //alert(msg);			       
					 $.alert(msg, function() {
							window.location.href = ctx+'/regrelation/getRegisterDoctorInfoList';
							changeStatues();
					 });  
				}, "json");
	});
}

</script>
</body>
</html>