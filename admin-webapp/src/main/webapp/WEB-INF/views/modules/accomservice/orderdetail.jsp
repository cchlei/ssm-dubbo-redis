<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>后台管理系统</title>
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
   <div style="width: 400px; margin: 20px; " id="layer_show_div">
   
   <form name="form" role="form" action="${ctx}/accom/editNote" method="POST" style="height:64px">
		<!-- <form id="schedule-form" method="POST" class="form-horizontal form-input"> -->
			<!-- <input type="hidden"  id="withdrawals_id" name="id"/>  -->
			<span style="font-size:20px;font-weight:bold;">订单编号：</span><span name="id" id="id" style="font-size:15px"><input type="hidden" name="id" value="${order.id}"/>${order.id}</span><br/>
			<span style="font-size:20px;font-weight:bold;">购买时间：</span><span name="createTime" id="createTime" style="font-size:15px">${order.createTime}</span><br/>
			<span style="font-size:20px;font-weight:bold;">用户名：</span><span name="patientName" id="patientName" style="font-size:15px">${order.patientName}</span><br/>
			<span style="font-size:20px;font-weight:bold;">手机号：</span><span name="patientPhone" id="patientPhone" style="font-size:15px">${order.patientPhone}</span><br/>
			<span style="font-size:20px;font-weight:bold;">医院：</span><span name="hospitalName" id="hospitalName" style="font-size:15px">${order.hospitalName}</span><br/>
			<span style="font-size:20px;font-weight:bold;">科室：</span><span name="deptName" id="deptName" style="font-size:15px">${order.deptName}</span><br/>
			<span style="font-size:20px;font-weight:bold;">服务时间：</span><span name="serverDate" id="serverDate" style="font-size:15px">${order.serverDate}</span><br/>
			<span style="font-size:20px;font-weight:bold;">陪整费用：</span><span name="accomCost" id="accomCost" style="font-size:15px">${order.accomCost}</span><br/>
			<span style="font-size:20px;font-weight:bold;">订单状态：</span><span name="status" id="status" style="font-size:15px">${order.status}</span><br/>
			<span style="font-size:20px;font-weight:bold;">陪整人员：</span><span name="accomName" id="accomName" style="font-size:15px">${order.accomName}</span><br/>
			<span style="font-size:20px;font-weight:bold;">备注：</span><span name="patientNote" id="patientNote" style="font-size:15px">${order.patientNote}</span><br/>
			<span style="font-size:20px;font-weight:bold;">客服备注：</span><input type="text"  id="customer_note_id" name="customerNote"  style="width:200px;"/>${order.customerNote}</span><br/>
		    <br/><br/>&nbsp;&nbsp;&nbsp;
		    <input type="submit" value="确定">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<!--  <input type="submit" value="退款"> -->
		    
		   
		</form>
    </div>
  </body>
  </html>      
  
		    
		    
   