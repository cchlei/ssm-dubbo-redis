<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>申诉列表</title>
<style>
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
      
#divHAN
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
       
</style>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">申诉列表</a></li>
	</ul>
	
	<div>
	<form name="form" role="form" action="${ctx}/payment/appealList" method="GET">
	开始时间： <input value="${params.startDate }" class="Wdate" type="text" name="startDate" id="startDate" tyle="width:120px;" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\',{d:-90})}',maxDate:'#F{$dp.$D(\'endDate\')||\'%y-%M-%d\'}',onpicked:function(){endDate.focus();}})" />
	结束时间：<input  value="${params.endDate }" class="Wdate" type="text" name="endDate" id="endDate"  tyle="width:120px;" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'startDate\',{d:+9a0})}',minDate:'#F{$dp.$D(\'startDate\')}'})" />
	<br/>订单编号：<input type="text"  id="operatorName" name="operatorName"  value="<c:out value='${params.operatorName}'/>"/>&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp; <button type="button" class="btn" onclick="subBut();">查询</button>
	</form>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 申诉列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">订单编号</th>
				<th class="text-center">申诉时间</th>
				<th class="text-center">申诉用户</th>
				<th class="text-center">申诉用户电话</th>
				<th class="text-center">订单类型</th>
				<th class="text-center">医生姓名</th>
				<th class="text-center">医生电话</th>
				<th class="text-center">申诉状态</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<%-- <c:forEach items="${list}" var="appeal" varStatus="status">
			<tr>
			    <td  class="text-center"><fmt:formatDate value="${appeal.orderId}" pattern="yyyy.MM.dd"/></td>
				<td  class="text-center">${appeal.createTime}</td>
				<td  class="text-center">${appeal.username}</td>
				<td  class="text-center">${appeal.phone}</td>
				<td  class="text-center">
				<c:if test="${appeal.type==0}">图文咨询</c:if>
				</td>
				<td  class="text-center">${appeal.doctorName}</td>
				<td  class="text-center">${appeal.doctorPhone}</td>
				<td  class="text-center">
				<c:if test="${appeal.appealStatus==0}">处理中</c:if>
				<c:if test="${appeal.appealStatus==1}">退款</c:if>
				<c:if test="${appeal.appealStatus==2}">拒绝</c:if>
				</td>
				<td  class="text-center">
				<a href="#" onclick="details('${appeal.id}')">详情</a>
				&nbsp;<a href="#" onclick="handle'${appeal.id}')">处理</a>
				</td>
			</tr>
			</c:forEach> --%>
			<!-- <tr><td><a href="#" onclick="details(1);">详情</a>
				&nbsp;<a href="#" onclick="handle(10254863245)">处理</a></td></tr> -->
		</table>
	</div>
    <page:page pager="${page}" linkUrl="${ctx}/payment/appealList?startDate=${params.startDate}&endDate=${params.endDate}&operatorName=${params.operatorName}"/>	
    
    <div id="divSCA">
    <input type="button" id="close" value="关闭" onclick="closeDiv()">
    <span style="font-size:20px;font-weight:bold;">申诉订单详情</span>
   <div style="margin-left:150px;margin-top:10px">
	<span style="font-size:20px;">订单号：<span name="orderId" id="orderId"></span></span><br/>
	<span style="font-size:20px;">申诉时间：<span name="orderId" id="orderId"></span></span><br/>
	申诉用户：<span name="orderId" id="orderId"></span><br/>
	用户电话：<span name="orderId" id="orderId"></span><br/>
	订单类型：<span name="orderId" id="orderId"></span><br/>
	医生姓名：<span name="orderId" id="orderId"></span><br/>
	医生电话：<span name="orderId" id="orderId"></span><br/>
	订单开始时间：<span name="orderId" id="orderId"></span><br/>
	订单结束时间：<span name="orderId" id="orderId"></span><br/>
	申诉原因：<span name="orderId" id="orderId"></span><br/>
	下载咨询文件到本地
	</div>
	<div style="margin-left:180px">
	<br/><button type="button" id="download" onclick="go();" class="btn btn-primary">下载</button></div>
	<br/><br/><br/><br/>
    </div>
    
    <div id="divHAN">
    <input id="detaiId" name="detaiId" type="hidden" value=""/>
    <div style="margin-left:150px;margin-top:10px">
    <span style="font-size:20px;"><input type="radio" id ="handle" name="handle" value="1" checked/>&nbsp;付款给医生</span><br/><br/>
	<span style="font-size:20px;"><input type="radio" id ="handle" name="handle" value="2"/>&nbsp;退款给患者</span>
	</div>
	<div style="margin-left:180px">
	<br/><button type="button" id="download" onclick="toHandle();" class="btn btn-primary">确定</button>&nbsp;&nbsp;&nbsp;
	<button type="button" onclick="closeDiv1();" class="btn btn-primary">取消</button></div>
	<br/><br/><br/><br/>
    </div>
    </div>
<script type="text/javascript">
var ctx = "${ctx}";
	
	/* $(document).ready(function() {
		
	}); */
	
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

   

    //详情
	function details(id){
			var url = ctx+"/payment/details";
			$.post(url,{'id':id},function (data){
				var user = data.results;
				//console.log(user.username);
				$("#orderId").html(user.username);
				openDiv();
			});
			
		
	}
    
    //跳转后台处理
	function toHandle(){
		var result = $('input[name="handle"]:checked').val();
		var id = $("#detaiId").val();
		var url = ctx+"/payment/handle";
		$.post(url,{'id':id,'result':result},function (data){
			if(data.success){
				alert(data.message);
			}
		});
		window.location.reload();
	}

	
	//处理
	function handle(id){
		$("#detaiId").val(id);
		openDiv1();
		
	} 
	
	function openDiv() {
		$("#divSCA").OpenDiv();
	}

	function closeDiv() {
		$("#divSCA").CloseDiv();	
	}
	
	function openDiv1() {
		$("#divHAN").OpenDiv();
	}

	function closeDiv1() {
		$("#divHAN").CloseDiv();	
	}

</script>
</body>
</html>