<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>提现列表</title>
<style>
#divSCA
      {
          position: absolute;
          top:200px !important;
          width: 500px;
          height: 300px;
          font-size: 12px;
          background: #fff;
          border: 0px solid #000;
          z-index: 10001;
          display: none;
      }
      
#divReason
      {
          position: absolute;
          top:200px !important;
          width: 400px;
          height: 160px;
          font-size: 12px;
          background: #fff;
          border: 0px solid #000;
          z-index: 10001;
          display: none;
      }      
</style>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">提现列表</a></li>
	</ul>
	
	<div>
	<form name="form" role="form" action="${ctx}/payment/withdrawalsList" method="GET">
	开始时间： <input value="${params.startDate }" class="Wdate" type="text" name="startDate" id="startDate" tyle="width:120px;" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\',{d:-90})}',maxDate:'#F{$dp.$D(\'endDate\')||\'%y-%M-%d\'}',onpicked:function(){endDate.focus();}})" />
	结束时间：<input  value="${params.endDate }" class="Wdate" type="text" name="endDate" id="endDate"  tyle="width:120px;" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'startDate\',{d:+90})}',minDate:'#F{$dp.$D(\'startDate\')}'})" />
	&nbsp;&nbsp;&nbsp;
	状态：<select class="mSelect" id="status" name="status">
		<option value="">请选择</option>
		<option value="0">未汇款</option>
		<option value="1">已汇款</option>
		<option value="2">已取消</option>
	</select>
	<button type="button" class="btn" style="float: right;" onclick="download()">导出列表</button>
	<br/>姓名：<input type="text"  id="operatorName" name="operatorName"  value="<c:out value='${params.operatorName}'/>"/>&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp; <button type="button" class="btn" onclick="subBut();">查询</button>
	</form>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 提现列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">提现时间</th>
				<th class="text-center">姓名</th>
				<th class="text-center">银行卡号</th>
				<th class="text-center">手机号</th>
				<th class="text-center">提现金额</th>
				<th class="text-center">状态</th>
				<th class="text-center">汇款时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="withdrawals" varStatus="status">
			<tr>
			    <td  class="text-center"><fmt:formatDate value="${withdrawals.createTime}" pattern="yyyy.MM.dd"/></td>
				<td  class="text-center">${withdrawals.name}</td>
				<td  class="text-center">${withdrawals.bankCardNum}</td>
				<td  class="text-center">${withdrawals.phone}</td>
				<td  class="text-center">${withdrawals.amount}</td>
				<td  class="text-center">
				<c:if test="${withdrawals.status==0}">未汇款</c:if>
				<c:if test="${withdrawals.status==1}">已汇款</c:if>
				<c:if test="${withdrawals.status==2}">已取消</c:if>
				</td>
				<td  class="text-center">
				<c:if test="${withdrawals.status==1}">
					<fmt:formatDate value="${withdrawals.operationTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
				</c:if>
				<td  class="text-center">
				<c:if test="${withdrawals.status==0}">
					<a href="#" onclick="alreadyWd('${withdrawals.id}')">已汇款</a>
					&nbsp;<a href="#" onclick="cancelWd('${withdrawals.id}')">取消</a>
				</c:if>
				<c:if test="${withdrawals.status==1}">
					<a href="#" onclick="cancelWd('${withdrawals.id}')">取消</a>
				</c:if>
				<c:if test="${withdrawals.status==2}">
				<a href="#" onclick="viewReason('${withdrawals.remark}')">查看取消原因</a>
				</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
    <page:page pager="${page}" linkUrl="${ctx}/payment/withdrawalsList?startDate=${params.startDate}&endDate=${params.endDate}&operatorName=${params.operatorName}&status=${params.status}"/>
    
    <div id="divSCA">
    <input id="withdrawalsId" name="withdrawalsId" type="hidden" value=""/>
    <span style="font-size:20px;font-weight:bold;">请输入取消原因：</span>
    <div style="margin-left:150px;margin-top:10px">
    <span style="font-size:20px;"><input type="radio" id ="reasonType" name="reasonType" value="1" checked/>&nbsp;银行卡错误</span><br/><br/>
	<span style="font-size:20px;"><input type="radio" id ="reasonType" name="reasonType" value="2"/>&nbsp;其他原因</span><br/>
	<input type="text"  id="reason" name="reason"  value="" style="width:150px;"/><br/>
	<span id="warnning" style="font-size:15px;color:#AAAAAA;">建议输入10个字以内：</span>
	</div>
	<div style="margin-left:180px">
	<br/><button type="button" id="download" onclick="subReason();" class="btn btn-primary">确定</button>&nbsp;&nbsp;&nbsp;
	<button type="button" onclick="closeDiv();" class="btn btn-primary">取消</button></div>
	<br/><br/><br/><br/>
    </div>
    
    
    <div id="divReason">
    <input id="withdrawalsId" name="withdrawalsId" type="hidden" value=""/>
    <span style="font-size:20px;font-weight:bold;">取消原因：</span>
    <div style="margin-left:100px;margin-top:10px">
    <span style="font-size:25px;" id="showReasonSpan"></span>
    <br/><br/>
    </div>
	<div style="margin-left:180px">
	<button type="button" onclick="closeDiv1();" class="btn btn-primary">关闭</button></div>
    </div>
    	
<script type="text/javascript">
var ctx = "${ctx}";
	$(document).ready(function() {
		//查询条件状态值被选中
		var status = "${params.status}";
		$("#status").val(status)
	});
	
	//查询
	function subBut(){
		
		var startDate = $("#startDate").val();
		if(startDate==""){
			alert("请选择开始时间！");
			return;
		}
		
		var endDate = $("#endDate").val();
		if(endDate==""){
			alert("请选择结束时间！");
			return;
		}
		
		this.form.submit();  
	}

   //导出
   function download(){
	
	var startDate = $("#startDate").val();
	if(startDate==""){
		alert("请选择开始时间！");
		return;
	}
	
	var endDate = $("#endDate").val();
	if(endDate==""){
		alert("请选择结束时间！");
		return;
	}
	
	var url="${ctx}/payment/downloadwd?startDate="+startDate+"&endDate="+endDate;
    window.open(url);
}

    //已汇款
	function alreadyWd(id){
		$.confirm("是否确定已汇款！", function() {
			var url = ctx+"/payment/alreadyWd";
			
			$.post(url,{'id':id},function (data){
				if(data.success){
					alert(data.message);
					window.location.reload();
				}
			});
			
		});
			
		
	}
    
    function subReason(){
    	var reasonType = $('input[name="reasonType"]:checked').val();
		var id = $("#withdrawalsId").val();
		var reason = $("#reason").val();
		if(reasonType=="2"){//如果是“其他”选项需要输入原因
			if(reason==""){
				$('#warnning').css('color','red')
				$("#warnning").html("请输入取消原因！");
				return;
			}else if(reason.length>10){
				$('#warnning').css('color','#AAAAAA')
				$("#warnning").html("输入原因请小于10个字！：");
			}else{
				$('#warnning').css('color','#AAAAAA')
				$("#warnning").html("建议输入6个字以内：");
			}
		}	
		var url = ctx+"/payment/subReason";
		if(reasonType==1){
			reason="银行卡号错误";
		}
		$.post(url,{'id':id,'reason':reason},function (data){
			if(data.success){
				alert(data.message);
				window.location.reload();
			}
		});
		
    }
	
	//取消
	function cancelWd(id){
		$("#withdrawalsId").val(id);
		openDiv();
		
	}
	
	function openDiv() {
		$("#divSCA").OpenDiv();
	}

	function closeDiv() {
		$("#divSCA").CloseDiv();	
	}
	
	//查看取消原因
	function viewReason(reason){
		$("#showReasonSpan").html(reason);
		openDiv1();
	}
	
	function openDiv1() {
		$("#divReason").OpenDiv();
	}

	function closeDiv1() {
		$("#divReason").CloseDiv();	
	}

</script>
</body>
</html>