<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>挂号记录列表</title>
<style>
#queryDiagnosisDateBegin,#queryDiagnosisDateEnd{padding-top\0:6px;}
@media Print { .Noprn { DISPLAY: none }}
   
   @media   print{   
  .printSize   { font-size:18px}
  .printSize2   { font-size:12px}
  }   

}
 
</style>
    
    
</head>

<body>
	<!-- <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">2014-12-01（星期一）</a></li>
	</ul> -->
	<div id="wrapper" style="position: fixed; background: white;z-index: 10" class="printSize2 Noprn">
	<div style="position: relative;float: left;">
		<form class="form-horizontal form-input" name="form" role="form" action="${ctx}/regrecord/list" method="GET">
		<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
		<input id="flag" name="flag" type="hidden" value="${flag}"/>
		<br/>
	<!-- 	<div id="recordDiv" style="position: relative;"> -->
		<%-- <form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/regrecord/saveFeedBack" method="POST"> --%>
		<%-- <span style="font-size:18px;">${date}</span>&nbsp;&nbsp; --%>
		<%-- <input class="Wdate" type="text" name="date" id="date"  value="${date}" onClick="WdatePicker({minDate:'%y-%M-{%d}'})"> --%>
		<span style="font-size:18px;line-height:34px;" id="paitentNum"></span><br/>
		开始日期：<input class="Wdate"  type="text" name="queryDiagnosisDateBegin" id="queryDiagnosisDateBegin"  style="width:120px;height:24px;vertical-align:middle" value="${queryDiagnosisDateBegin}" onClick="WdatePicker({minDate:'%y-%M-{%d-15}',maxDate:'#F{$dp.$D(\'queryDiagnosisDateEnd\')}'})">&nbsp;&nbsp;&nbsp;
		截止日期：<input class="Wdate" type="text" name="queryDiagnosisDateEnd" id="queryDiagnosisDateEnd"  style="width:120px; height:24px;vertical-align:middle"  value="${queryDiagnosisDateEnd}" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryDiagnosisDateBegin\')}',maxDate:'%y-%M-{%d+15}'})">&nbsp;&nbsp;&nbsp;
		<input type="hidden" name="queryDiagnosisDateBegin1" id="queryDiagnosisDateBegin1" value="${queryDiagnosisDateBegin}"/>
		<input type="hidden" name="queryDiagnosisDateEnd1" id="queryDiagnosisDateEnd1" value="${queryDiagnosisDateEnd}"/>
		<select  style="width: 100px; padding-bottom:10"  name="resourceTpye" id="resourceTpye">
			  <option value="">门诊选择</option>
			<c:forEach items="${hospDiclist}" var="dic" varStatus="status">
			  <c:if test="${resourceTpye==dic.dictId}">
			  	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
			  </c:if>
			  <c:if test="${resourceTpye!=dic.dictId}">
			  	<option value="${dic.dictId}">${dic.dictName}</option>
			  </c:if>
			  
			</c:forEach>
		</select>
		<select style="width: 100px;"  id="sortOrder" name="sortOrder">
		    <option value="">排序选择</option>
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
		&nbsp;&nbsp;<input type="button" onclick="searchBut()"  value="查询" />
		</form>
		</div>
		<c:if test="${flag!=1}">
		<div style="float:right; height:100px;position: relative;bottom: 10;right: 0;">
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="button" class="btn" onclick="submitRed();">确 认</button>&nbsp;&nbsp;
		<button type="button" class="btn" onclick="reset();">重 置</button>&nbsp;&nbsp;
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="checkbox" id="reception" name="reception" onclick="ifCheck();"/>全部接诊
		&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="button" class="btn"  onclick="javascript:window.print()">打 印</button>&nbsp;&nbsp; 
			
		<button type="button" class="btn" onclick="download()">导 出</button></div></div>
		
	</div>
	</c:if>
	<div class="panel panel-default printSize">
		<c:forEach items="${hospDiclist}" var="resourceType" varStatus="status">
			<div>
			<table class="table table-bordered table-hover tablesorter" id="table${resourceType.dictId}">
			<thead>
			 <tr>
			<th colspan="10">
				<div class="panel-heading">
				<h4 class="panel-title"><strong>
					 ${resourceType.dictName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;导医通 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span  class="paitentNum2" style="font-size:18px;line-height:34px;" ></span>
					 </strong>
				</h4>
			    </div>
			</th>
			</tr>
			<tr  style="background-color:#aaa">
			    <!-- <th class="text-center">编号</th> -->
			    
				<th class="text-center" nowrap="nowrap" width="70px">医&nbsp;&nbsp;&nbsp;&nbsp;生</th>
				<th class="text-center"  nowrap="nowrap" width="80px">&nbsp;&nbsp;科&nbsp;&nbsp;&nbsp;&nbsp;室&nbsp;&nbsp;</th>
				<th class="text-center" nowrap="nowrap">就诊时间</th>
				<th class="text-center" nowrap="nowrap">初/复诊</th>
				<th class="text-center" nowrap="nowrap" width="70px">就诊人</th>
				<th class="text-center">性别</th>
				<th class="text-center" nowrap="nowrap">社保卡号/就诊卡号</th>
				<th class="text-center" width="140px">证件号码</th>
				<th class="text-center" width="110px">联系电话</th>
				<c:if test="${flag!=1}">
				<th class="text-center Noprn"width="110px">确认处理</th>
				</c:if>
			</tr>
			</thead>
		</table>
		</c:forEach>
		<!-- </form> -->
	</div>
	</div>
	
<script type="text/javascript">
/* function doPrint() { 
	bdhtml=window.document.body.innerHTML; 
	sprnstr="<!--startprint-->"; //开始打印标识字符串有17个字符
	eprnstr="<!--endprint-->"; //结束打印标识字符串
	prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17); //从开始打印标识之后的内容
	prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr)); //截取开始标识和结束标识之间的内容
	window.document.body.innerHTML=prnhtml; //把需要打印的指定内容赋给body.innerHTML
	window.print(); //调用浏览器的打印功能打印指定区域 

	window.document.body.innerHTML=bdhtml;//重新给页面内容赋值；
	}
ie9不兼容暂且屏蔽
 */




//获取表格宽度值，并把宽度值赋予搜索栏。
var kuandu = $('.table').width();
$('#wrapper').css({'width':kuandu});
//设置表格起始位置为搜索栏的长度。
$('.panel').css({'position':'absolute','top':$('#wrapper').height()});


var ctx = "${ctx}";
var tableId = "";
var paitentNum =0;
$(document).ready(function() {
	
	var hospId = $("#hospId").val();
	//var diagnosisDate = $("#date").val();
	var queryDiagnosisDateBegin = $("#queryDiagnosisDateBegin").val();
	var queryDiagnosisDateEnd = $("#queryDiagnosisDateEnd").val();
	var resourceTpye = "${resourceTpye}";
	var sortOrder = "${sortOrder}";
	
	var url = ctx+"/regrecord/queryUntreated";
	var hospDiclist = eval("${hdlist}");
	if("${hdlist}"!=""){
		 for(var j=0; j<hospDiclist.length; j++) 
		{
			if(resourceTpye!=""&&resourceTpye!=null){
				if(resourceTpye!=hospDiclist[j].dictId){
					document.getElementById("table"+hospDiclist[j].dictId).style.display="none";
					continue;
				}
			}
			tableId = hospDiclist[j].dictId;
			$.ajax({  
				type : "post",  
				url : url,  
				data : {'hospId':hospId,'resourceTpye':hospDiclist[j].dictId,'queryDiagnosisDateBegin':queryDiagnosisDateBegin,'queryDiagnosisDateEnd':queryDiagnosisDateEnd,'sortOrder':sortOrder},  
				async : false,  
				asyncBoolean:false,
				success : function(data){  
					 if(data.length==0){
						 document.getElementById("table"+hospDiclist[j].dictId).style.display="none";
					 }
					 paitentNum+=data.length;
					 $.each(data, function(i, n) { 
							addDataRow("table"+hospDiclist[j].dictId,n,i);
					}); 
					 //document.getElementByTagName_r("strong").innerText = "未处理挂号人数："+paitentNum+"";
					 $('.paitentNum2').text("未处理挂号人数："+paitentNum);
				}  
		    });
			
		}  
	}
	document.getElementById("paitentNum").innerText = "未处理挂号人数："+paitentNum+"";
	
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
   thirdCell.innerHTML = date;
   
   if(data.isFirstVisit=='1'){
	   forthCell.innerHTML = "初诊";
   	
   }else if(data.isFirstVisit=='2'){
	   forthCell.innerHTML = "复诊";
   }
   
   fifthCell.innerHTML = data.patientName;
   
   if(data.sex==1){
	   sixthCell.innerHTML = "男";
   }else{
	   sixthCell.innerHTML = "女";
   }
   
   if(data.medicareNumber==null){
	   sevenCell.innerHTML = "";
   }else{
	   sevenCell.innerHTML = data.medicareNumber;
   }
   
   eightCell.innerHTML = data.idCard;
   nineCell.innerHTML = data.phoneNum;
   
   var a =  "<input type='radio'  name='aa"+tableId+num+"' class='a' value='"+data.registrationRecordId+",RECEIVE'/>接诊 ";
   a += "<input type='radio'   name='aa"+tableId+num+"'  class='b' value='"+data.registrationRecordId+",DENY'/>拒绝 ";
   tenCell.innerHTML = a;
   tenCell.setAttribute("class", "Noprn");
   
   
}



function searchBut(){
	/* var selectDate = $("#date").val();
	var d = new Date();
	var b = new Date(selectDate);
	var year = d.getFullYear();
	var month = d.getMonth() + 1;
	var date = d.getDate();
	var c = new Date(year+"-"+month+"-"+date);
	if(b<c){
		alert("不能选择今天之前的日期！");
		$("#date").val(year+"-"+month+"-"+date);
		return;
	} */
	this.form.submit();
}

function reset(){
	$('input:checkbox[name=reception]').attr('checked',false);
	$("input[type='radio']").attr('checked',false);
}

function download(){
	var hospId = $("#hospId").val();
	var queryBeginDate1 = $("#queryDiagnosisDateBegin1").val();
	var queryEndDate1 = $("#queryDiagnosisDateEnd1").val();
	//alert(queryBeginDate1+"="+queryEndDate1);
	var url="${ctx}/regrecord/download?hospId="+hospId+"&queryBeginDate="+queryBeginDate1+"&queryEndDate="+queryEndDate1;
	window.open(url);
}

function ifCheck(){
	var allReception = $("#reception").is(':checked');
	if(allReception){
		$("input[type='radio'].a").prop('checked',true);
	}else{
		$("input[type='radio'].a").prop('checked',false);
	}
}

function submitRed(){
var allReception = $("#reception").is(':checked');//是否全部接诊 true/false
var message = "确定处理挂号信息吗？处理后不可恢复！";
var checkedRadio = $("input[type='radio']:checked");
var length = checkedRadio.length;

if(allReception){
	message = "您勾选了'全部接诊'，确认对本页所有挂号记录全部接诊吗？";
}else{
	if(length==0){
		alert("您未对当前页面做任何处理！");
		return;
	}
}
$.confirm(message, function() {
	var url = ctx+"/regrecord/saveFeedBack";
	var hospId=$("#hospId").val();
	var date=$("#date").val();
	var baseData = ("\"hospId\":\""+hospId+"\",\"date\":\""+date+"\",");
	var jsonDate = "{";
	jsonDate += baseData;
	
	if(length==0){
		return
	/* }else if(allReception==true){
		jsonDate +="\"allReception\":\""+allReception+"\"}"; */
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