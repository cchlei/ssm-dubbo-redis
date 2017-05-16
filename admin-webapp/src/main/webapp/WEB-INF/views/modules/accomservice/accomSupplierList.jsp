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
   <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">后台管理系统</a></li>
	</ul>
  <div>
	<form name="form" role="form" action="${ctx}/accom/supplierList" method="POST">
                   供应商名称:<input type="text" id="suppName" name="suppName"/>
                   订单状态：	<select class="mSelect" id="status" name="status">
						<option value="" >请选择</option>
						<option value="0">停用</option>
						<option value="1">启用</option>
		           </select>
      <button type="button" class="btn" onclick="subBut();">查询</button>
      <a href="${ctx}/accom/toAddOrEdit">添加供应商</a>  
    </form>
    <div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list">供应商管理</i> 
			</h4>
	   	</div>  
    	<table class="table table-bordered table-hover tablesorter">
		<thead>
			<tr>
			    <th class="text-center">编号</th>
				<th class="text-center">供应商名称</th>
				<th class="text-center">陪整人员数</th>
				<th class="text-center">分账比例</th>
				<th class="text-center">合作日期</th>
				<th class="text-center">状态</th>
				<th class="text-center">操作</th>
			 </tr>
		 </thead>   
		<!-- 遍历出数据 -->
		<c:forEach items="${list}" var="suppli" varStatus="status">
	    <tr>
			<td  class="text-center">${suppli.id}</td>
			<td  class="text-center">${suppli.suppName}</td>
			<td  class="text-center">${suppli.accomPersons}</td>
			<td  class="text-center">${suppli.scale}</td>
			<td  class="text-center">
				<fmt:formatDate pattern="yyyy-MM-dd" value="${suppli.startDate}"/>至<fmt:formatDate pattern="yyyy-MM-dd" value="${suppli.endDate}"/></td>
            <td>
	            <!-- 状态   切换？启用：停用-->
				<c:if test="${suppli.status==0}"><span style="color:red;">停用</span></c:if>
				<c:if test="${suppli.status==1}">启用</c:if>
				<button type="button" class="btn btn-primary" onclick="changeStat('${suppli.id}','${suppli.status}')">切换</button>
			</td>
			<td class="text-center">
				 <a href="javascript:showDetail('${suppli.id}');">编辑</a>
		    </td> 
		 </tr>
		</c:forEach>	
       </table>
    </div>
    <page:page pager="${page}" linkUrl="${ctx}/accom/supplierList?suppName=${params.suppName}&status=${params.status}"/>
  </div>
  <script type="text/javascript">
     var ctx = "${ctx}";
     $(document).ready(function(){
		//查询条件状态值被选中
		var status = "${params.status}";
   		$("#status").val(status)
  	});     
     
  	//查询
	function subBut(){
		var suppName = $("#suppName").val();
		if(suppName==""){
			alert("请选择供应商名称！");
			return;
		}
		this.form.submit();  
	}     
 	function changeStat(id,status){
		//转换供应商启用禁用状态
		if(status==0){
			status=1;
		}else if(status==1){
			status=0;
		} 
		var change = id+","+status;
		url="${ctx}/accom/supplierList?change="+change;
	  	window.location.href=url;
	} 
   	</script>  
	</body>
</html>

			
				
 	
 
 
 
      
        
        
 
 
 
 
 
   
      
      
      
      
	
 	  
 	  
 	  
 			
 			
 			
 			
         
         
         
		
                  
	   	
   
  
    





























































<!-- 

<body>
	<form id="plist" action="" type="" method="post">
			<span>供应商名称</span> 
			<input type="text" id="suppName" name="suppName">
			<span>状态</span> 
			<select class="status" id="status" name="status">
				<option value="" >请选择</option>
				<option value="0">停用</option>
				<option value="1">启用</option>
			</select>
			<button type="button" id="sbutton" onclick="page('search')" class="button">查询</button>
	</form>
	<div class="box"></div>
	
	<script type="text/javascript">
                                 	     
	          
	 </script>
</body>
</html> -->
	           