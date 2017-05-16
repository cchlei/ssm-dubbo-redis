<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>后台管理系统</title>
<style>
	#divSCA{position: absolute;top:200px !important;width: 500px;height: 300px;font-size: 12px;background: #fff;border: 0px solid #000;z-index: 10001;display: none;}
	#divReason{position: absolute;top:200px !important;width: 400px;height: 160px;font-size: 12px;background: #fff;border: 0px solid #000;z-index: 10001;display: none;}      
</style>
</head>
 

<body>
   <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">陪整人员管理</a></li>
	</ul>
  <div>
	<form name="form" role="form" action="${ctx}/accom/selectPerson" method="GET">
		<span>姓名:</span><input type="text" id="accomName" name="accomName" value="<c:out value='${params.accomName}'/>"/>
        <span>手机号:</span><input type="text" id="phone" name="phone" value="<c:out value='${params.phone}'/>"/>            
        <span>订单状态:</span>
	      <select class="mSelect" id="status" name="status">
			<option value="" >请选择</option>
			<option value="0">停用</option>
			<option value="1">启用</option>
	      </select>
      	<button type="button" class="btn" onclick="subBut();">查询</button>
      	<a href="${ctx}/accomperson/toAddorEditPerson">添加陪整人员</a>  
    </form>
    <div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list">陪整人员管理</i>
			</h4>
	   </div>
	</div>  
    <table class="table table-bordered table-hover tablesorter">
		<thead>
			<tr>
			    <th class="text-center">人员编号</th>
				<th class="text-center">姓名</th>
				<th class="text-center">性别</th>
				<th class="text-center">手机号</th>
				<th class="text-center">状态</th>
				<th class="text-center">操作</th>
			</tr>
		</thead>   
			<!-- 遍历出数据 -->
			<c:forEach items="${personList.result}" var="perso" varStatus="status">
			    <tr>
					<td  class="text-center">${perso.id}</td>
					<td  class="text-center">${perso.accomName}</td>
					<td  class="text-center">${perso.gender}</td>
					<td  class="text-center">${perso.phone}</td>
				    <!-- 状态   切换？启用：停用-->
	                <td>
						 <c:if test="${perso.status==0}"><span style="color:red;">停用</span></c:if>
						 <c:if test="${perso.status==1}">启用</c:if>
						 <button type="button" class="btn btn-primary" onclick="changeStat('${perso.id}','${perso.status}')">切换</button>
					 </td>
					<td class="text-center">
						<a href="javascript:showDetail('${perso.id}');">编辑</a>
				    </td> 
				 </tr>
			</c:forEach>	
        </table>
      <div/>
    <page:page pager="${page}" linkUrl="${ctx}/accom/selectPerson?accomName=${params.accomName}&phone=${params.phone}&status=${params.status}"/>
       <script type="text/javascript">
       var ctx = "${ctx}";
 	     $(document).ready(function(){
 			//查询条件状态值被选中
 			var status = "${params.status}";
 	    	$("#status").val(status)
    	});     
 	  //查询
 		function subBut(){
 			var accomName = $("#accomName").val();
 			if(accomName==""){
 				alert("请选择陪整人员姓名");
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
			//alert(url);
		  	window.location.href=url;
	       } 
	   
	    </script>  
	    </body>
	  </html>

