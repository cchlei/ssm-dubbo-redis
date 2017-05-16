<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>订单详情</title>
<style>
#mainFrame{
	height: 840px !important;
}
#divSCA
      {
          position: absolute;
          top:200px !important;
          width: 500px;
          height: 600px;
          font-size: 12px;
          background: #fff;
          border: 0px solid #000;
          z-index: 10001;
          display: none;
      }
#close
      {
      position:absolute;
		right:0;/*   定位到右上   */
		top:0;
      }
</style>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">订单详情</a></li>
	</ul>
	
	<div>
	<form name="form" role="form" action="${ctx}/payment/paymentOrderList" method="GET">
	开始时间： <input value="${params.startDate }" class="Wdate" type="text" name="startDate" id="startDate" style="width:120px;" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\',{d:-90})}',maxDate:'#F{$dp.$D(\'endDate\')||\'%y-%M-%d\'}',onpicked:function(){endDate.focus();}})" />
	结束时间：<input  value="${params.endDate }" class="Wdate" type="text" name="endDate" id="endDate"  style="width:120px;" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'startDate\',{d:+90})}',minDate:'#F{$dp.$D(\'startDate\')}'})" />
	订单状态：<select id="selOrderStatus" name="orderStatus">
				<option value="" ${params.orderStatus == null ? 'selected' : '' }>请选择</option>
				<option value="0" ${params.orderStatus == '0' ? 'selected' : '' }>未咨询</option>
				<option value="1" ${params.orderStatus == '1' ? 'selected' : '' }>已咨询</option>
				<option value="2" ${params.orderStatus == '2' ? 'selected' : '' }>已取消</option>
				<option value="3" ${params.orderStatus == '3' ? 'selected' : '' }>咨询中</option>
			</select>
	阅读状态：
			<select id="selReadStatus" name="readStatus">
				<option value="" ${params.readStatus == null ? 'selected' : '' }>请选择</option>
				<option value="0" ${params.readStatus == '0' ? 'selected' : '' }>未阅读</option>
				<option value="1" ${params.readStatus == '1' ? 'selected' : '' }>已阅读</option>
			</select>
	<button type="button" class="btn" style="float: right;" onclick="download()">导出列表</button>
	<br/>订单编号:<input type="text"  id="orderId" name="orderId"  value="<c:out value='${params.orderId}'/>"/>&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp; <button type="button" class="btn"  onclick="subBut();">查询</button>
	 <div style="float:right;margin-top: 5px;"><input type="checkbox" checked="checked"  name="checked" id="refresh" style="margin-top: 6px;"/><label style="font-weight: normal;margin-right: 50px;" >自动刷新 </label>  间隔时间：<input id="second" name="second" style="width: 30px;" value="${params.second == null ? '60' : params.second}"/> &nbsp;秒</div>
	</form>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 订单详情
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter" id="info">
			<thead>
			<tr>
			    <th class="text-center" width="20px">订单编号</th>
				<th class="text-center">购买服务时间</th>
				<th class="text-center" width="80px">用户名</th>
				<th class="text-center">用户电话</th>
				<th class="text-center">订单类型</th>
				<th class="text-center">医生姓名</th>
				<th class="text-center">医生电话</th>
				<th class="text-center">订单状态</th>
				<th class="text-center">订单开始时间</th>
				<th class="text-center">订单结束时间</th>
				<th class="text-center">是否阅读</th>
				<th class="text-center" width="100px">操作</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="paymentOrder" varStatus="status">
			<tr class=detail>
				<td order-id="${paymentOrder.orderId}" class="text-center">${paymentOrder.orderId}</td>
			    <td  class="text-center"><fmt:formatDate value="${paymentOrder.createTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
			    <td  class="text-center">${paymentOrder.userName}</td>
			    <td  class="text-center">${paymentOrder.userTel}</td>
				<td  class="text-center">
				<c:if test="${paymentOrder.orderType==1}">图文</c:if>
				<c:if test="${paymentOrder.orderType==2}">电话</c:if>
				<c:if test="${paymentOrder.orderType==3}">视频</c:if>
				</td>
				<td  class="text-center">${paymentOrder.doctorName}</td>
				<td  class="text-center">${paymentOrder.doctorTel}</td>
				<td  class="text-center">
				<c:if test="${paymentOrder.orderStatus==0}">未咨询</c:if>
				<c:if test="${paymentOrder.orderStatus==1}">已咨询</c:if>
				<c:if test="${paymentOrder.orderStatus==2}">已取消</c:if>
				<c:if test="${paymentOrder.orderStatus==3}">咨询中</c:if>
				</td>
				<td  class="text-center">
					<c:if test="${paymentOrder.beginTime!=null}">
						<fmt:formatDate value="${paymentOrder.beginTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/>
					</c:if>
				</td>
				<td  class="text-center">
					<c:if test="${paymentOrder.endTime!=null}">
						<fmt:formatDate value="${paymentOrder.endTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/>
					</c:if>
				</td>
				<td  class="text-center">
				<c:if test="${paymentOrder.readStatus==0}">未阅读</c:if>
				<c:if test="${paymentOrder.readStatus==1}">已阅读</c:if>
				</td>
				<td  class="text-center">
				<a href="#" onclick="details('${paymentOrder.orderId}','${paymentOrder.orderType}','原因')">详情</a>
				&nbsp;
				<c:if test="${paymentOrder.orderStatus==0}">
					<a href="#" onclick="cancelPO('${paymentOrder.orderId}')">取消</a>
				</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
    <page:page pager="${page}" linkUrl="${ctx}/payment/paymentOrderList?startDate=${params.startDate}&endDate=${params.endDate}&operatorName=${params.operatorName}&orderId=${params.orderId}&orderStatus=${params.orderStatus}&readStatus=${params.readStatus}&second=${params.second }&checked=${params.checked }"/>	
    
    <div id="divSCA">
    <input type="button" id="close" value="关闭" onclick="closeDiv()">
   <div style="margin-left:100px;margin-top:10px">
		<span style="font-size:20px;font-weight:bold;">订单编号：</span><span name="divOrderId" id="divOrderId" style="font-size:15px"></span><br/>
		<!-- <span style="font-size:20px;font-weight:bold;">订单生成时间：</span><span name="createTime" id="createTime" style="font-size:15px"></span><br/> -->
		<span style="font-size:20px;font-weight:bold;">用户名：</span><span name="userName" id="userName" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">用户电话：</span><span name="userTel" id="userTel" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">订单类型：</span><span name="orderType" id="orderType" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">医生姓名：</span><span name="doctorName" id="doctorName" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">医生电话：</span><span name="doctorTel" id="doctorTel" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">病症描述：</span><span name="disease" id="disease" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">订单状态：</span><span id="orderStatus" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">付款时间：</span><span name="createTime" id="createTime" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">付款状态：</span><span name="tradeStatus" id="tradeStatus" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">服务开始时间：</span><span name="beginTime" id="beginTime" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">服务结束时间：</span><span name="endTime" id="endTime" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">服务评价：</span><span id="score" name="score"></span><br/>
		<span style="font-size:20px;font-weight:bold;">服务送花：</span><span name="flowerAmount" id="flowerAmount"></span><br/>
		<span style="font-size:20px;font-weight:bold;">服务文字评价：</span><span name="comment" id="comment" style="font-size:15px"></span><br/>
		<span style="font-size:20px;font-weight:bold;">客服备注：</span><input type="text"  id="comment1" name="comment1"  style="width:200px;"/></span><br/>
	
   </div>
	<div style="margin-left:180px">
	<br/><button type="button" onclick="subComment();" class="btn btn-primary">完成</button></div>
	<br/><br/><br/><br/>
    </div>
    
<script type="text/javascript">

var ctx = "${ctx}";
	$(document).ready(function() {
		
		//$(window.parent.document.getElementById("mainFrame")).css("height", "1500px");
		
		
		//定时刷新
		var second = $("#second").val();
		var ref = "";
		function refresh(){
			subBut();
		}
		function interval(second){
			if(second<60){
				clearInterval(ref);
				alert("自动刷新间隔必须大于等于60秒，请重新输入!");
				$("#second").focus();
				return false;
			}
			ref = setInterval(function(){
				refresh();
			},second*1000);
		}
		
		if($("#refresh").prop("checked")){
			interval(second);
		}
		$("#refresh").click(function(){
			if($("#refresh").prop("checked")){
				interval(second);
			}else{
				//阻止定时刷新
				clearInterval(ref);
			}
		});
		
		$("#second").change(function(){
			clearInterval(ref);
			second = $(this).val();
			interval(second);
		});
	});
	
	//详情
	function details(id,orderType,remark){
			var url = ctx+"/payment/orderDetails";
			$.post(url,{'orderId':id,"orderType":orderType},function (data){
				var order = data.results.orderRecord;
				$("#divOrderId").html(order.orderId);
				$("#userName").html(order.userName);
				$("#userTel").html(order.userTel);
				if(order.orderType==1){
					$("#orderType").html("图文");bhdh
				}else if(order.orderType==2){
					$("#orderType").html("电话");
				}else if(order.orderType==3){
					$("#orderType").html("视频");
				}
				$("#doctorName").html(order.doctorName);
				$("#doctorTel").html(order.doctorTel);
				if(null==order.disease){
					$("#disease").html("无");
				}else{
					$("#disease").html(order.disease);
				}
				if(order.orderStatus==0){
					$("#orderStatus").html("未咨询");
				}else if(order.orderStatus==1){
					$("#orderStatus").html("已咨询");
				}else if(order.orderStatus==2){
					$("#orderStatus").html("已取消");
				}else if(order.orderStatus==3){
					$("#orderStatus").html("咨询中");
				}
				//付款时间和付款状态
				if(data.results.createTime!=null){
					var d1=	new Date();
					d1.setTime(data.results.createTime);
					var s3=d1.format('yyyy-MM-dd HH:mm:ss');
					$("#createTime").html(s3);
				}else{
					$("#createTime").html("无");
				}
				
				if(data.results.tradeStatus==null||data.results.tradeStatus==""){
					$("#tradeStatus").html("无");
				}else{
					$("#tradeStatus").html(data.results.tradeStatus);
				}
				
				var d=	new Date();
				if(order.beginTime){
					d.setTime(order.beginTime);
					var s1=d.format('yyyy-MM-dd HH:mm:ss');
					$("#beginTime").html(s1);
				}else{
					$("#beginTime").html("无");
				}
				if(order.endTime){
					d.setTime(order.endTime);
					var s2=d.format('yyyy-MM-dd HH:mm:ss');
					$("#endTime").html(s2);
				}else{
					$("#endTime").html("无");
					
				}
				
				$("#comment").html(data.results.comment);
				var starStr = "";
				if(data.results.score==null||data.results.score==""){
					document.getElementById("score").innerHTML="无";
				}else{
					var size = parseInt(data.results.score);
					for (i=1;i<=size;i++) {
						starStr += "<i class='glyphicon glyphicon-star'>";
					}
					document.getElementById("score").innerHTML=starStr;
				}
				var flowerStr = "";
				if(data.results.flowerAmount<1){
					document.getElementById("flowerAmount").innerHTML="无";
				}else{
					for (i=1;i<=data.results.flowerAmount;i++) {
						flowerStr += "<i class='glyphicon glyphicon-asterisk'>";
					}
					document.getElementById("flowerAmount").innerHTML=flowerStr;
				}	
				
				$("#comment1").val(order.comment);
				openDiv();
			});
	   }
				
			
	function subComment(){
    	var comment = $("#comment1").val();
		var orderId = $("#divOrderId").text();
		var url = ctx+"/payment/subComment";
		if(comment==""){
			alert("客服备注为空！");
		}
		$.post(url,{'orderId':orderId,'comment':comment},function (data){
			if(data.success){
				alert(data.message);
				window.location.reload();
			}
		});
	 }
		
	
	//查询
	function subBut(){
		
		/* var startDate = $("#startDate").val();
		if(startDate==""){
			alert("请选择开始时间！");
			return;
		}
		
		var endDate = $("#endDate").val();
		if(endDate==""){
			alert("请选择结束时间！");
			return;
		} */
		
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
	
	var url="${ctx}/payment/downloadpo?startDate="+startDate+"&endDate="+endDate;
    window.open(url);
}
	//取消
	function cancelPO(id){
		$.confirm("是否取消订单！", function() {
			var url = ctx+"/payment/cancelPO";
			$.post(url,{'id':id},function (data){
				if(data.success){
					alert(data.message);
					window.location.reload();
				}
			});
			
		});
    } 
	

	
	function openDiv() {
		/* $("#divSCA").css({"margin": "auto","display": "none","position": "fixed"});
		$("#divSCA").find("img").css("margin","auto");  */
		$("#divSCA").OpenDiv();
		$(window.parent.document.getElementById("mainFrame")).css("min-height", "840px");
	}

	function closeDiv() {
		$("#divSCA").CloseDiv();	
	}
   
	
	Date.prototype.format=function(fmt) {        
	    var o = {        
	    "M+" : this.getMonth()+1, //月份        
	    "d+" : this.getDate(), //日        
	    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时        
	    "H+" : this.getHours(), //小时        
	    "m+" : this.getMinutes(), //分        
	    "s+" : this.getSeconds(), //秒        
	    "q+" : Math.floor((this.getMonth()+3)/3), //季度        
	    "S" : this.getMilliseconds() //毫秒        
	    };        
	    var week = {        
	    "0" : "\u65e5",        
	    "1" : "\u4e00",        
	    "2" : "\u4e8c",        
	    "3" : "\u4e09",        
	    "4" : "\u56db",        
	    "5" : "\u4e94",        
	    "6" : "\u516d"       
	    };        
	    if(/(y+)/.test(fmt)){        
	        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));        
	    }        
	    if(/(E+)/.test(fmt)){        
	        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "\u661f\u671f" : "\u5468") : "")+week[this.getDay()+""]);        
	    }        
	    for(var k in o){        
	        if(new RegExp("("+ k +")").test(fmt)){        
	            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));        
	        }        
	    }        
	    return fmt;        
	} 
			
</script>
</body>
</html>
		
	
	
	

	
	
	




	