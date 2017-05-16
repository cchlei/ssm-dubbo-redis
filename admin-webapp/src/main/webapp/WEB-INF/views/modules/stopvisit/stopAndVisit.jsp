<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>停复诊管理</title>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">停复诊管理</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/stopAndVisit/save" method="POST">
	    <c:if test="${doctorStopDiag!=null}">
			<input id="stopId" name="stopId" type="hidden" value="${doctorStopDiag.stopId}"/>
	    </c:if>
	    <input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/>
	    <input id="departmentId" name="departmentId" type="hidden" value="${departmentId}"/>
	    <input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	   <!--  <input id="dates" name="dates" type="hidden" /> -->
	    <span style="color:blue;margin-left:50px;">注：多次编辑仅以最新一次为有效停复诊操作，且仅以今天以后2个月内的数据为有效停诊数据</span>
	    <%-- <div class="form-group">
			<label for="stopType" class="col-sm-2 control-label">停&nbsp;诊&nbsp;类&nbsp;型：</label>
			<div class="col-sm-5">
			<select class="mSelect"  class="mSelect"  id="stopType" name="stopType" onchange="ifShow(this.value);">
				 <c:if test="${doctorStopDiag.stopType==1||doctorStopDiag.stopType==null}">
				 <option value="1" selected="selected">暂时</option>
				 <option value="2">永久</option>
				 </c:if>
				 <c:if test="${doctorStopDiag.stopType==2}">
				 <option value="1">暂时</option>
				 <option value="2" selected="selected">永久</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<!-- <br/><br/><span id="wmessage1" style="color:red;margin-left:180px;display:none"></span> -->
		</div> --%>
		
	    <%-- <div class="form-group" id="stopType1" style="display: none">
			<label for="stopDate" class="col-sm-2 control-label">停诊日期：</label>
			<div class="col-sm-5">
				<input class="Wdate" type="text" name="stopDate" id="stopDate" onClick="WdatePicker({minDate:'%y-%M-{%d+1}',maxDate:'#F{$dp.$D(\'recoverDate\')}'})" value="<fmt:formatDate value="${doctorStopDiag.stopDate}" pattern="yyyy-MM-dd"/>"/>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
		</div> --%>
		
		<div id='calendar'  style="width:600px; height:600px;margin-left:90px;">
		<br/>
		停诊时间：<br/>
		开始日期：<input class="Wdate" type="text" name="beginDate" id="beginDate"  style="width:120px;" value="" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}'})">&nbsp;&nbsp;&nbsp;
		截止日期：<input class="Wdate" type="text" name="endDate" id="endDate"  style="width:120px;"  value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}'})">
		&nbsp;<button type="button" id="fat-btn" class="btn btn-primary btn-sm" onclick="syn();">同 步</button>
		<br/>
		<br/> 
		<br/>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="button" id="fat-btn" class="btn btn-primary" onclick="submitBut()">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
		</div>
		
		<%-- <c:if test="${doctorStopDiag.stopType==2}">
		<div class="form-group">
			<label for="saytext" class="col-sm-2 control-label">立&nbsp; 即&nbsp; 复&nbsp; 诊：</label>
			<div class="col-sm-4">
				<button type="button" id="recoverButton" onclick="recoverNow();" class="btn btn-primary">复诊</button>
			</div>
			<div class="col-sm-5 help-block Validform_checktip">点击按钮当天开始复诊</div>
		</div>
		</c:if> --%>
		
		<!-- <div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="button" id="fat-btn" class="btn btn-primary" onclick="submitBut()">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div> -->
	</form>
	<br />
	<%-- <label style="font-size:15px;">医生所有停诊情况</label>
	<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">停诊日期</th>
				<th class="text-center">复诊日期</th>
				<th class="text-center">复诊类型</th>
				<th class="text-center">原因</th>
				<th class="text-center">操作人</th>
				<th class="text-center">操作时间</th>
			</tr>
			</thead>
		    <c:forEach items="${sdLogList}" var="doctorStopDiagLog" varStatus="status">
			<tr>
			<td class="text-center">${status.count}</td>
			<td><fmt:formatDate value="${doctorStopDiagLog.stopDate}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${doctorStopDiagLog.recoverDate}" pattern="yyyy-MM-dd"/></td>
			<td>
			<c:if test="${doctorStopDiagLog.recoverDiagType==1}">未复诊</c:if>
			<c:if test="${doctorStopDiagLog.recoverDiagType==2}">系统</c:if>
			<c:if test="${doctorStopDiagLog.recoverDiagType==3}">人为</c:if>
			</td>
			<td>${doctorStopDiagLog.cause}</td>
			<td>${doctorStopDiagLog.operatorName}</td>
			<td><fmt:formatDate value="${doctorStopDiagLog.operationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			</c:forEach> 
		</table> --%>
<script type="text/javascript">
var ctx = "${ctx}";
var stopTypeFlag = 0;
var daysHavEvent  = {};
	$(document).ready(function() {
		var dates = eval("${dates}");
		if("${dates}"!=""){
			//alert(typeof(dates));
			if(dates!=""){
				for(var i=0; i<dates.length; i++) 
				{ 
					daysHavEvent[dates[i].start] = true;
				} 
			}
		}
		$('#calendar').fullCalendar({
	        
			buttonText: {
			today: '今天',
			month: '月',
			week: '周',
			day: '天'
			},
			allDayText: '全天',
			monthNames: ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],
			monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
			dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
			dayClick : function(date, jsEvent, view) {
				
				sdate = date.format();
				//alert(sdate);
				if(!daysHavEvent[sdate]){
					$('#calendar').fullCalendar( 'addEventSource', [{
							id:date,
							allDay:true,
							title: '停诊',
							start: sdate,
							
							end: sdate				
						}] );
			
					daysHavEvent[sdate] = true;
				}

			},
			eventClick: function(calEvent, jsEvent, view) {
		
				$('#calendar').fullCalendar( 'removeEvents' , calEvent.id );
				var key = calEvent.start.format();
				daysHavEvent[key] = false;
				
			},
			editable: true,
			allDayDefault:true,
			events: dates
	    });
	    
	    
	    
		var dsd = "${doctorStopDiag}";
		/* if(dsd!=""){
			url=ctx+"/stopAndVisit/update"; 
			//var stopType = "${doctorStopDiag.stopType}";
			//ifShow(stopType);
		} */
		
		
		});
	//同步时间段停诊	
	function syn(){
		var beginDate=$("#beginDate").val();
		var endDate=$("#endDate").val();
		if(beginDate=="" || endDate==""){
			alert("请选择停诊开始时间和结束时间！");
			return;
	    }
		var begin = new Date(beginDate.replace(/-/g, '/'));
		var end = new Date(endDate.replace(/-/g, '/'));
		
		var date = beginDate;
		if(!daysHavEvent[date]){
			$('#calendar').fullCalendar( 'addEventSource', [{
				id:date,
				allDay:true,
				title: "停诊",
				start: date,
				end: date				
			}] );
			daysHavEvent[date] = true;
		}
		
		for(var i = 0; begin < end; i ++){
			begin.setDate(begin.getDate() + 1);
			var tar = begin.getFullYear() + "-" + ((begin.getMonth() + 1) < 10 ? ("0" + (begin.getMonth() + 1)) : (begin.getMonth() + 1)) + "-" + (begin.getDate() < 10 ? ("0" + begin.getDate()) : begin.getDate());  
			var date = tar;
			if(!daysHavEvent[date]){
				$('#calendar').fullCalendar( 'addEventSource', [{
					id:date,
					allDay:true,
					title: "停诊",
					start: date,
					end: date				
				}] );
				daysHavEvent[date] = true;
			}
		}

		
	}
	
	function recoverNow(){
		var url = ctx+"/stopAndVisit/recoverNow";
		var stopDate = $("#stopDate").val();
		var a = new Date();
		var b = new Date(stopDate);
		if(b>a){
			alert("停诊日期大于今天，不能点击复诊按钮！");
			return;
		}
		var stopId = $("#stopId").val();
		$.post(url,{'stopId':stopId},function (data){
			if(data.success){
				alert(data.message);
				window.location.reload();
			}
		});
	}
	
	function submitBut(){
		var count = 0;
		var url = ctx+"/stopAndVisit/save";
		var dsd = "${doctorStopDiag}";
		if(dsd!=""){
			url=ctx+"/stopAndVisit/update"; 
		}
		//url=ctx+"/stopAndVisit/update"; 
		var stopId=$("#stopId").val();
		var hospId=$("#hospId").val();
		var doctorId=$("#doctorId").val();
		var departmentId=$("#departmentId").val();
		//时间段选择方式停复诊
		//var beginDate=$("#beginDate").val();
		//var endDate=$("#endDate").val();
		var myBean = "{";
		/* if((beginDate!=""&&endDate=="")||beginDate==""&&endDate!=""){
			alert("请选择停诊开始时间和结束时间！");
			return;
		}else if(beginDate!=""&&endDate!=""){
			myBean = ("{\"beginDate\":\""+beginDate+"\",\"endDate\":\""+endDate+"\",");
		}else{
			myBean = ("{\"beginDate\":\""+""+"\",\"endDate\":\""+""+"\",");
		} */
		
		
		var baseData = ("\"hospId\":\""+hospId+"\",\"doctorId\":\""+doctorId+"\",\"departmentId\":\""+departmentId+"\",");
		if(stopId!=""&&stopId!=null&&stopId!="undefined"){
			baseData += ("\"stopId\":\""+stopId+"\",");
		} 
		var jsonDate = myBean+"\"dsdBean\":{";
		jsonDate += baseData;
		var temp = "";
		//jsonDate += "\"stopDate\":[";
		obj=daysHavEvent;
		//alert(obj);
		for (var prop in obj) {  
			  if (obj.hasOwnProperty(prop)) {   
			   //alert("prop: " + prop + " value: " + obj[prop]) 
			    if(obj[prop]){
			    	var now = getNow();
					var selectDate = new Date(prop.replace(/-/g, '/'));
					var twoWeekLater = new Date(GetDateStr2(2).replace(/-/g, '/'));//往后推60天
					//alert("now="+now+"selectDate="+selectDate+"twoWeekLater="+twoWeekLater);
					//alert("twoWeekLater>selectDate="+(twoWeekLater>selectDate));
					//alert("selectDate>now="+(selectDate>now));
					//alert('sss'+(twoWeekLater>selectDate)+(selectDate>=now));
			    	if((twoWeekLater>=selectDate) && (selectDate>=now)){
			    		count++;
			    		temp += ("\""+prop+"\"");
			    		temp += ",";	
			    	}
			    }
			  }  
			}  
		if(parseInt(count)<1){
			alert("该医生2个月内没有停诊信息！");
			//jsonDate=jsonDate.substring(0,jsonDate.length-1);
			//jsonDate += (null);
			jsonDate += "}}";
			//return;
		}else{
			//temp=temp.substring(0,temp.length-1);
			jsonDate += "\"stopDate\":[" + temp + "]}}";
			//jsonDate=jsonDate.substring(0,jsonDate.length-1);
			//jsonDate += "]}";
		}
		var result1 = eval('(' + jsonDate + ')');
		//alert(result1.stopDate.length);
		if(parseInt(count)<1){//全部取消停诊时不验证是否有未就诊挂号记录了
			$.ajax({
				type : "POST",
				url : url,
				dataType : "json",
				contentType : "application/json",
				data : $.toJSON(result1),
				success : function(data) {
					alert(data.message);
					window.location.reload();
				}
			});
		}else{
			//验证提示信息
			var url2 = ctx + "/doctor/checkIfCanDo2";
			$.ajax({
				type : "post",
				url : url2,
				dataType : "json",
				contentType : "application/json",
				data : $.toJSON(result1),
				async : false,
				asyncBoolean : false,
				success : function(data) {
					if (data.success) {
						if (data.message == 1) {
							$.confirm("确定要停诊该医生吗？该医生相关号源已有客户预约还未就诊！", function() {
								$.ajax({
									type : "POST",
									url : url,
									dataType : "json",
									contentType : "application/json",
									data : $.toJSON(result1),
									success : function(data) {
										alert(data.message);
										window.location.reload();
									}
								});
							});
						} else {
							$.ajax({
								type : "POST",
								url : url,
								dataType : "json",
								contentType : "application/json",
								data : $.toJSON(result1),
								success : function(data) {
									alert(data.message);
									window.location.reload();
								}
							});
						}
					}
				}
			});
		}

	}

	function ifShow(value) {
		if (value == 1) {//暂时
			//document.getElementById("showVisit").style.display="inline-block";
			document.getElementById("stopType1").style.display = "none";
			document.getElementById("calendar").style.display = "block";
		} else {//永久
			document.getElementById("stopType1").style.display = "block";
			document.getElementById("calendar").style.display = "none";
		}
	}

	function GetDateStr(AddDayCount) {
		var dd = new Date();
		dd.setDate(dd.getDate() + AddDayCount);//获取AddDayCount天后的日期 
		var y = dd.getFullYear();
		var m = (dd.getMonth() + 1) < 10 ? "0" + (dd.getMonth() + 1) : (dd
				.getMonth() + 1);//获取当前月份的日期，不足10补0
		var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate(); //获取当前几号，不足10补0
		return y + "-" + m + "-" + d;
	}
	
	function GetDateStr2(AddMonthCount) {
		var dd = new Date();
		//dd.setDate(dd.getDate() + AddDayCount);//获取AddDayCount天后的日期 
		dd.setMonth(dd.getMonth()+AddMonthCount);//获取AddMonthCount个月后的日期
		var y = dd.getFullYear();
		var m = (dd.getMonth() + 1) < 10 ? "0" + (dd.getMonth() + 1) : (dd
				.getMonth() + 1);//获取当前月份的日期，不足10补0
		var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate(); //获取当前几号，不足10补0
		return y + "-" + m + "-" + d;
	}

	function getNow() {
		var dd = new Date();
		dd.setHours(0, 0, 0, 0);
		/* var y = dd.getFullYear(); 
		var m = (dd.getMonth()+1)<10?"0"+(dd.getMonth()+1):(dd.getMonth()+1);//获取当前月份的日期，不足10补0
		var d = dd.getDate()<10?"0"+dd.getDate():dd.getDate(); //获取当前几号，不足10补0
		//alert(y+"-"+m+"-"+d);
		dd. */
		return dd;
	}
</script>
</html>