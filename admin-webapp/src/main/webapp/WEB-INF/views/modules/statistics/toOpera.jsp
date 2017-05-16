<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>统计管理</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">统计管理</a></li>
	</ul>
	<br/>
		
		 <div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">挂号记录数统计：</label>
			开始日期：<input class="Wdate" type="text" name="queryBeginDate" id="queryBeginDate"  style="width:120px;" value="" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'queryEndDate\')}'})">--
		    截止日期：<input class="Wdate" type="text" name="queryEndDate" id="queryEndDate"  style="width:120px;"  value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryBeginDate\')}'})">
			
			<button type="button" class="btn" onclick="download()">导 出</button>
		</div>
		
		 <div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">注册医生数统计：</label>
			开始日期：<input class="Wdate" type="text" name="queryBeginDate2" id="queryBeginDate2"  style="width:120px;" value="" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'queryEndDate2\')}'})">--
		    截止日期：<input class="Wdate" type="text" name="queryEndDate2" id="queryEndDate2"  style="width:120px;"  value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryBeginDate2\')}'})">
			
			<button type="button" class="btn" onclick="download2()">导 出</button>
		</div>
		
		<div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">注册医生审核通过数统计：</label>
			开始日期：<input class="Wdate" type="text" name="queryBeginDate3" id="queryBeginDate3"  style="width:120px;" value="" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'queryEndDate3\')}'})">--
		    截止日期：<input class="Wdate" type="text" name="queryEndDate3" id="queryEndDate3"  style="width:120px;"  value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryBeginDate3\')}'})">
			
			<button type="button" class="btn" onclick="download3()">导 出</button>
		</div>
		
		<div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">用户数统计：</label>
			开始日期：<input class="Wdate" type="text" name="queryBeginDate4" id="queryBeginDate4"  style="width:120px;" value="" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'queryEndDate4\')}'})">--
		    截止日期：<input class="Wdate" type="text" name="queryEndDate4" id="queryEndDate4"  style="width:120px;"  value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryBeginDate4\')}'})">
			
			<button type="button" class="btn" onclick="download4()">导 出</button>
		</div>
		
<script type="text/javascript">
		var ctx = "${ctx}";
	 $(document).ready(function() {
		
		

	});
	 
	function download(){
			var queryBeginDate = $("#queryBeginDate").val();
			var queryEndDate = $("#queryEndDate").val();
			if(queryBeginDate=="" || queryEndDate==""){
				alert("请选择日期！");
				return;
			}
			var url="${ctx}/statistics/download?queryBeginDate="+queryBeginDate+"&queryEndDate="+queryEndDate+"&flag=1";
		    window.open(url);
	}
	
	function download2(){
		var queryBeginDate = $("#queryBeginDate2").val();
		var queryEndDate = $("#queryEndDate2").val();
		if(queryBeginDate=="" || queryEndDate==""){
			alert("请选择日期！");
			return;
		}
		var url="${ctx}/statistics/download?queryBeginDate="+queryBeginDate+"&queryEndDate="+queryEndDate+"&flag=2"+"&stautes=all";
	    window.open(url);
	}
	
	function download3(){
		var queryBeginDate = $("#queryBeginDate3").val();
		var queryEndDate = $("#queryEndDate3").val();
		if(queryBeginDate=="" || queryEndDate==""){
			alert("请选择日期！");
			return;
		}
		var url="${ctx}/statistics/download?queryBeginDate="+queryBeginDate+"&queryEndDate="+queryEndDate+"&flag=2"+"&stautes=1";
	    window.open(url);
	}
	
	function download4(){
		var queryBeginDate = $("#queryBeginDate4").val();
		var queryEndDate = $("#queryEndDate4").val();
		if(queryBeginDate=="" || queryEndDate==""){
			alert("请选择日期！");
			return;
		}
		var url="${ctx}/statistics/download?queryBeginDate="+queryBeginDate+"&queryEndDate="+queryEndDate+"&flag=3";
	    window.open(url);
	}
	
	
</script>
</html>