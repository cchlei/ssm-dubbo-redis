<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>挂号记录列表</title>
</head>

<body>
	<!-- <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">2014-12-01（星期一）</a></li>
	</ul> -->
	
	
	<div id="recordDiv">
	<form name="form" role="form" action="${ctx}/webregrecord/list" method="GET" style="height:34px">
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	<input id="flag" name="flag" type="hidden" value="${flag}"/>
	<%-- <input class="Wdate" type="text" name="date" id="date"  value="${date}" onClick="WdatePicker()">&nbsp; --%>
	开始日期：<input class="Wdate" type="text" name="queryDiagnosisDateBegin" id="queryDiagnosisDateBegin"  style="width:120px;" value="${queryDiagnosisDateBegin}" onClick="WdatePicker({minDate:'%y-%M-{%d-15}',maxDate:'#F{$dp.$D(\'queryDiagnosisDateEnd\')}'})">&nbsp;&nbsp;&nbsp;
		截止日期：<input class="Wdate" type="text" name="queryDiagnosisDateEnd" id="queryDiagnosisDateEnd"  style="width:120px;"  value="${queryDiagnosisDateEnd}" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryDiagnosisDateBegin\')}',maxDate:'%y-%M-{%d+15}'})">
	<select class="mSelect"  class="mSelect"  id="isGuide" name="isGuide">
		<option value="2">已接诊</option>
		<option value="3">已拒绝</option>
		<option value="4">已标记爽约</option>
	</select>
	<select style="width: 100px;"  id="sortOrder" name="sortOrder">
	    <option value="">请选择</option>
	    <c:if test="${sortOrder==1}">
			<option value="1" selected="selected">医生排序</option>
			<option value="2">就诊时间排序</option>
			<option value="3">初诊/复诊排序</option>
	    </c:if>
	    <c:if test="${sortOrder==2}">
	    	<option value="1">医生排序</option>
			<option value="2" selected="selected">就诊时间排序</option>
			<option value="3">初诊/复诊排序</option>
	    </c:if>
	    <c:if test="${sortOrder==3}">
	    	<option value="1">医生排序</option>
			<option value="2">就诊时间排序</option>
			<option value="3" selected="selected">初诊/复诊排序</option>
	    </c:if>
		<c:if test="${sortOrder==null}">
	    	<option value="1">医生排序</option>
			<option value="2">就诊时间排序</option>
			<option value="3">初诊/复诊排序</option>
	    </c:if>
	</select>	
	<%-- <input id="d424" class="Wdate" type="text" name="date" id="date" value="${date}" onfocus="WdatePicker({dateFmt:'yyyy-M-d H:mm:ss'})"/> --%>
	&nbsp;&nbsp;<input type="submit" value="查询" />
	<c:if test="${isGuide==2 || isGuide==null}">
	&nbsp;&nbsp;<button type="button" class="btn" style="float: right;"onclick="submitRed();">确 认</button>&nbsp;&nbsp;
		<button type="button" class="btn" style="float: right;margin-right: 10px;"onclick="resetRadio();">重 置</button>&nbsp;&nbsp;
	</c:if>
	</form>
	
	
	<div class="panel panel-default">
		<c:forEach items="${hospDiclist}" var="resourceType" varStatus="status">
			<div>
			<table class="table table-bordered table-hover tablesorter" id="table${resourceType.dictId}">
			<thead>
			 <tr>
			<th colspan="10">
				<div class="panel-heading">
				<h4 class="panel-title"><strong>
					<%--  ${resourceType.key.dictName} --%>
					 ${resourceType.dictName}
					 </strong>
				</h4>
			    </div>
			</th>
			</tr>
			<tr  style="background-color:#aaa">
			    <!-- <th class="text-center">编号</th> -->
				<th class="text-center" width="70px">医生</th>
				<th class="text-center" width="80px">科室</th>
				<th class="text-center" width="70px">就诊人</th>
				<th class="text-center">性别</th>
				<th class="text-center" width="140px">证件号码</th>
				
				<th class="text-center"width="110px">处理</th>
				
				<th class="text-center" width="110px">联系电话</th>
				<th class="text-center">就诊时间</th>
				<th class="text-center">初/复诊</th>
				<th class="text-center">社保卡号/就诊卡号</th>
			</tr>
			</thead>
		</table>
		</div>
		</c:forEach>
		<!-- </form> -->
	</div>
	</div>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	var isGuide = "${isGuide}";
	if(isGuide==""){
		isGuide="2";
	}
		$("#isGuide").val(isGuide);
	var hospId = $("#hospId").val();
	//var diagnosisDate = $("#date").val();
	var queryDiagnosisDateBegin = $("#queryDiagnosisDateBegin").val();
	var queryDiagnosisDateEnd = $("#queryDiagnosisDateEnd").val();
	var sortOrder = "${sortOrder}";
	var url = ctx+"/webregrecord/queryProcessed";
	var sortOrder = "${sortOrder}";

	var hospDiclist = eval("${hdlist}");
	if("${hdlist}"!=""){
		 for(var j=0; j<hospDiclist.length; j++) 
		{ 
			tableId = hospDiclist[j].dictId;
				
			$.ajax({  
				type : "post",  
				url : url,  
				data : {'hospId':hospId,'resourceTpye':hospDiclist[j].dictId,'queryDiagnosisDateBegin':queryDiagnosisDateBegin,'queryDiagnosisDateEnd':queryDiagnosisDateEnd,'isGuide':isGuide,'sortOrder':sortOrder},  
				async : false,  
				asyncBoolean:false,
				success : function(data){  
					 if(data.length==0){
						 document.getElementById("table"+hospDiclist[j].dictId).style.display="none";
					 }
					 $.each(data, function(i, n) { 
							addDataRow("table"+hospDiclist[j].dictId,n,i);
					}); 
				}  
		    });
		}  
	}
	
});

//table添加一行（赋值）
function addDataRow(tableId,data,num){
		 var bodyObj=document.getElementById(tableId);  
		 bodyObj.style.display = '';
		    if(bodyObj==null)   
		    {  
		        alert("Body of Table not Exist!");  
		        return;  
		    }  
		    var rowCount = bodyObj.rows.length;  
		    var newRow = bodyObj.insertRow(rowCount++);    
		    var firstCell = newRow.insertCell(0);
		    var secondCell = newRow.insertCell(1);
		    var thirdCell = newRow.insertCell(2);
		    var forthCell = newRow.insertCell(3);
		    var fifthCell = newRow.insertCell(4);
		    var sixthCell = newRow.insertCell(5);
		    var sevenCell = newRow.insertCell(6);
		    var eightCell = newRow.insertCell(7);
		    var nineCell = newRow.insertCell(8);
		    var tenCell = newRow.insertCell(9);
		   
		    firstCell.innerHTML = data.doctorName;
		    secondCell.innerHTML = data.departmentName;
		    thirdCell.innerHTML = data.patientName;
		    if(data.sex==1){
			    forthCell.innerHTML = "男";
		    }else{
		    	forthCell.innerHTML = "女";
		    }
		    fifthCell.innerHTML = data.idCard;
		    var a =  "<input type='radio'  name='aa"+tableId+num+"' value='"+data.registrationRecordId+",MISSED'/>爽约 ";
		    if(data.isGuide==2){
		    	if(data.registrationRecordSource==4){//vip挂号记录
		    		 sixthCell.innerHTML = "";
		    	}else{
		    		 sixthCell.innerHTML = a;
		    	}
		    }else if(data.isGuide==3){
			    sixthCell.innerHTML = "已拒绝";
		    }else if(data.isGuide==4){
			    sixthCell.innerHTML = "已标记爽约";
		    }
		    sevenCell.innerHTML = data.phoneNum;
		    var date = "";
		    date += new Date(data.diagnosisDate).toLocaleDateString();
		    if(data.ampm==1){
		    	date += "上午";
		    }else{
		    	date += "下午";
		    }
		    if(data.timespanStart!=""&&data.timespanStart!=null){
		    	var date1 = new Date(data.timespanStart);
		    	date+=date1.getHours()+":"+date1.getMinutes();
		    } 
		   
		    eightCell.innerHTML = date;
		    if(data.isFirstVisit=='1'){
		    	nineCell.innerHTML = "初诊";
		    	
		    }else if(data.isFirstVisit=='2'){
		    	nineCell.innerHTML = "复诊";
		    }
		    tenCell.innerHTML = data.medicareNumber;
		   
		 }



function resetRadio(){
	$("input[type='radio']").attr('checked',false);
}

function download(){
	var hospId = $("#hospId").val();
	var date = $("#date").val();
	var url="${ctx}/webregrecord/download?hospId="+hospId+"&date="+date;
    window.open(url);
}

	
function submitRed(){
	$.confirm("确定处理挂号信息吗？处理后不可恢复！", function() {
		var url = ctx+"/webregrecord/saveMiss";
		var checkedRadio = $("input[type='radio']:checked");
		var length = checkedRadio.length;
		var hospId=$("#hospId").val();
		var date=$("#date").val();
		var baseData = ("\"hospId\":\""+hospId+"\",\"date\":\""+date+"\",");
		var jsonDate = "{";
		jsonDate += baseData;
		
		if(length==0){
			return
		}else{
			jsonDate += "\"list\":[";
			for (var i = 0;i<length;i++){
				var oneRadio = checkedRadio.eq(i).val().split(",");
				jsonDate += ("{\"recordId\":\""+oneRadio[0]+"\",\"guideType\":\""+oneRadio[1]+"\"");
				jsonDate += "},";	 
			}
			jsonDate=jsonDate.substring(0,jsonDate.length-1);
			jsonDate += "]}";
		}
			//alert(jsonDate);
			var result1 = eval('(' + jsonDate + ')');
		  $.ajax({
	         type: "POST",
	         url:url,
	         dataType: "json",
	         contentType:"application/json",
	         data:$.toJSON(result1), 
	         success: function(data){
	        	 alert(data.message);
	        	 window.location.reload();
	         }
         });    
	});	
	}

</script>
</body>
</html>