<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>陪整费用管理</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">陪整费用管理</a></li>
	</ul>
	
	<div>
	<form name="form" role="form" action="${ctx}/accom/list" method="GET">
	<input id="areaId" name="areaId" type="hidden" value="${params.areaId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${params.hospId}"/>
	  状态:<select class="mSelect" id="status" name="status">
					<option value="	">请选择</option>
					<option value="0">停用	</option>
					<option value="1">启用	</option>
	           </select>
 	所在地：  
	<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null)">
    <option value="0">请选择</option>
    <c:forEach items="${areaList}" var="area" varStatus="status">
       <c:if test="${area.parentId==0}">
	    	<c:choose>
		       <c:when test="${params.areaIdParent!=null && params.areaIdParent==area.areaId}">
		       		<option value="${area.areaId}" selected="selected">${area.areaName}</option>
		       </c:when>
		       <c:otherwise>
			    	<option value="${area.areaId}">${area.areaName}</option>
			   </c:otherwise>
		   </c:choose> 	
	   </c:if>
    </c:forEach>
    </select>&nbsp;&nbsp;&nbsp;
    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
    <c:choose>
   	    <c:when test="${params.areaId!=null && params.areaId!=params.areaIdParent}">
    	<option>${areaMap[params.areaId]}</option>
	    </c:when>
	    <c:otherwise>
	   	    <option value="0">请选择</option>
	    </c:otherwise>
	</c:choose>
    </select><br/>
    医院：<select class="lSelect"  class="lSelect"  id="hospital" name="hospital" onchange="selectHosp(this.value)">
    <c:if test="${params.hospId==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select>&nbsp;&nbsp;&nbsp;	  
    <button type="button"  onclick="subBut();">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="${ctx}/accom/supplierCosts">添加陪整医院</a>
    <div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 陪整费用管理
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">所属省市</th>
				<th class="text-center">医院</th>
				<th class="text-center">陪整费用</th>
				<th class="text-center">状态</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
           <c:forEach items="${list}" var="weiXinRecord" varStatus="status">
			<tr>
			   
				<td  class="text-center">${weiXinRecord.areaName}</td>
				<td  class="text-center">${weiXinRecord.hospName}</td>
				<td  class="text-center">${weiXinRecord.accomCost}</td>
				
				<!-- 状态   切换？启用：停用-->
                <td>
					 <c:if test="${weiXinRecord.status==0}"><span style="color:red;">停用</span></c:if>
					 <c:if test="${weiXinRecord.status==1}">启用</c:if>
					 &nbsp;&nbsp;
					 <button type="button" class="btn btn-primary" onclick="changeStat('${weiXinRecord.id}','${weiXinRecord.status}')">切换</button>
				 </td>
				
				<td class="text-center">
					 <a href="javascript:showDetail('${weiXinRecord.id}');">编辑</a>
			    </td> 
			</tr>
			</c:forEach>
		</table>
	</div>			
        <page:page pager="${page}" linkUrl="${ctx}/accom/list?areaId=${params.areaId}&areaIdParent=${params.areaIdParent}&hospId=${params.hospId}&status=${params.status}"/>
    
   <script type="text/javascript">
var ctx = "${ctx}";
function subBut(){
	/* var pCheckBox = $("[name = isCount]:checkbox").prop('checked');
	if(pCheckBox){
		$("[name = isCount]:checkbox").val(1);
		}else{
			$("[name = isCount]:checkbox").val(0);
		} */
	this.form.submit();  
	};


$(document).ready(function(){
	//操作方式赋值
// 	document.getElementById("operatorType").value = "${params.operatorType}";
	//查询条件赋值
	var areaIdParent = "${params.areaIdParent}";
	var areaId = "${params.areaId}";
	var hospId = "${params.hospId}";
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,null);
		if(hospId!=""){
			searchHosp(areaIdParent,hospId);
		}else{
			searchHosp(areaIdParent,null);
		}
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		searchArea(areaIdParent,areaId);
		if(hospId!=""){
			searchHosp(areaId,hospId);
		}else{
			searchHosp(areaId,null);
		}
	}
	/*  $("[name = isCount]:checkbox").bind("click", function () {
		var pCheckBox = $("[name = isCount]:checkbox").prop('checked');
		if(pCheckBox){
			$("[name = isCount]:checkbox").val(1);
		}else{
			$("[name = isCount]:checkbox").val(0);
		}
	 });  */
});

//地区下拉联动
function searchArea(areaId,areaIdChild){
	if(areaId==0){
		return;
	}
	var url = ctx+"/doctor/searchArea";
	$.post(url,{'areaId':areaId},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#areaIdChild").empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择");
	      $("#areaIdChild").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(areaIdChild!=null && areaIdChild == json[i].areaId){
				option = $("<option>").val(json[i].areaId).text(json[i].areaName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].areaId).text(json[i].areaName);
			}
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#areaIdChild").append(option); 
		} 
	});
	 searchHosp(areaId,null);//根据父级地区查询医院
	 if(areaId!=0){
	   $("#areaId").val(areaId);
	 } 
	
}

 //医院下拉联动
 function searchHosp(areaId,hospId){
	//alert(hospId);
	if(areaId==0){
		return;
	}
	var flag = "${params.flag}";
	var url = ctx+"/doctor/searchHosp";
	$.ajax({  
		type : "post",  
		url : url,  
		data : {'areaId':areaId,'flag':1},  
		async : false,  
		asyncBoolean:false,
		success : function(data){  
			json = eval(data);
			  // 先清空第二个 
		      $("#hospital").empty(); 
		      var option = "";
		      option = $("<option>").val(0).text("请选择");
		      $("#hospital").append(option); 
			for(var i=0; i<json.length; i++) 
			{ 
				if(hospId!=null && hospId == json[i].hospId){
					option = $("<option>").val(json[i].hospId).text(json[i].hospName).prop("selected",true);
				}else{
					option = $("<option>").val(json[i].hospId).text(json[i].hospName);
				}
			    //alert(json[i].areaId+" " + json[i].areaName) 
			    $("#hospital").append(option); 
			} 
		}  
    });
	
	 if(areaId!=0){
		   $("#areaId").val(areaId);
		 } 
	
}
function selectHosp(hospId){
	if(hospId!=0){
		   $("#hospId").val(hospId);
		}
}



</script>
</body>
</html> 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
             
	           