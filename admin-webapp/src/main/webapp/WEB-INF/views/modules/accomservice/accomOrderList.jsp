<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>后台管理系统</title>
<link href="../static/css/modules/accomservice/accomorderlist.css" rel="stylesheet" type="text/css">
</head>
<body>
   <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">后台管理系统</a></li>
	</ul>
  <div>
	<form name="form" role="form" action="${ctx}/accom/toOrderList" method="GET">
	用户名:<input type="text"  id="patientName" name="patientName"  value="<c:out value='${params.patientName}'/>"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	医院:<select class="lSelect"  class="lSelect"  id="hospitalId" name="hospitalId" onchange="selectHosp(this.value)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   <c:if test="${hospId!=null}">
	    	<option>${hospName}</option>
	    </c:if>
	    <c:if test="${hospitalId==null}">
	    	<option value="0">请选择</option>
	    </c:if>
    </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
	陪整人员:<input type="text" id="accomName" name="accomName"  value="<c:out value='${params.accomName}'/>"/>&nbsp;&nbsp;&nbsp;  
	服务时间:<input class="Wdate" type="text" name="startDate" id="queryDiagnosisDateBegin"  style="width:100px;" value="${params.startDate}" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'queryDiagnosisDateEnd\')}'})">&nbsp;&nbsp;-&nbsp;
			<input class="Wdate" type="text" name="endDate" id="queryDiagnosisDateEnd"  style="width:100px;"  value="${params.endDate}" onClick="WdatePicker({minDate:'#F{$dp.$D(\'queryDiagnosisDateBegin\')}'})">
       订单状态:<select class="mSelect"  class="mSelect"  id="status" name="status">
	   	    <option value="">请选择</option>
	    	<option value="0">未付款</option>
			<option value="1">待服务</option>
			<option value="2">待评价</option>
			<option value="3">完成</option>
	     </select>
    &nbsp;&nbsp; <button type="submit" class="btn">查询</button>
   </form>
    
    <div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>陪整服务
			</h4>
	   </div>                
        
     	<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				    <th class="text-center">订单编号</th>
					<th class="text-center">购买服务时间</th>
					<th class="text-center">用户名</th>
					<th class="text-center">手机号</th>
					<th class="text-center">医院</th>
					<th class="text-center">科室</th>
					<th class="text-center">服务时间</th>
					<th class="text-center">陪整费用</th>
					<th class="text-center">陪整人员</th>
					<th class="text-center">订单状态</th>
					<th class="text-center">备注</th>
					<th class="text-center">操作</th>
			  </tr>
			 </thead>   
        
          <c:forEach items="${list}" var="withdrawals" varStatus="status">
		    <tr>
				<td  class="text-center">${withdrawals.id}</td>
			    <td  class="text-center"><fmt:formatDate value="${withdrawals.createTime}" pattern="yyyy.MM.dd"/></td>
				<td  class="text-center">${withdrawals.patientName}</td>
				<td  class="text-center">${withdrawals.patientPhone}</td>
				<td  class="text-center">${withdrawals.hospitalName}</td>
				<td  class="text-center">${withdrawals.deptName}</td>
				<td  class="text-center">${withdrawals.serverDate}</td>
				<td  class="text-center">${withdrawals.accomCost}</td>
				<td  class="text-center">${withdrawals.accomName}</td>
				<%-- <td  class="text-center">${withdrawals.}</td> --%>
				
                <td class="text-center">
					<c:if test="${withdrawals.status==0}">未付款</c:if>
					<c:if test="${withdrawals.status==1}">待服务</c:if>
					<c:if test="${withdrawals.status==2}">待评价</c:if>
					<c:if test="${withdrawals.status==3}">完成</c:if>
				</td>
             	<td class="text-center">${withdrawals.patientNote}</td>  
                <td class="text-center">
					<a href="javascript:showDetail('${withdrawals.id}');">详情</a>
				</td>
			</tr>
			</c:forEach>
		</table>
        </div>
                     
   </div>
     <div style="width: 400px; margin-top: 20px; display: none;" id="layer_show_div">
		<form id="schedule-form" action="" method="POST" class="form-horizontal form-input">
			<input type="hidden"  id="withdrawals_id" name="id"/>
			<span style="font-size:20px;font-weight:bold;">订单编号：</span><span name="id" id="id" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">购买时间：</span><span name="createTime" id="createTime" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">用户名：</span><span 	name="patientName" id="patientName" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">手机号：</span><span name="patientPhone" id="patientPhone" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">医院：</span><span name="hospitalName" id="hospitalName" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">科室：</span><span name="deptName" id="deptName" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">服务时间：</span><span name="serverDate" id="serverDate" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">陪整费用：</span><span name="accomCost" id="accomCost" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">订单状态：</span><span name="status" id="status" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">陪整人员：</span><span name="accomName" id="accomName" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">备注：</span><span name="patientNote" id="patientNote" style="font-size:15px"></span><br/>
			<span style="font-size:20px;font-weight:bold;">客服备注：</span><input type="text"  id="customer_note_id" name="customerNote"  style="width:200px;"/></span><br/>
		</form>
    </div>
    <script type="text/javascript">
       var baseurl = "${baseurl}";
       function showDetail(id){
    	   var index = layer.open({
    		   type: 2, 
    		   title: "订单详情", 
    		   area: ['400px','600px'], 
    		   fixed: false, 
    		   maxmin: false,
    		   content: [baseurl+'/accom/order/'+id, 'no']
    	   });
       }
     </script> 
  </body>
  </html>      
   