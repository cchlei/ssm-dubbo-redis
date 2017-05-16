<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>预约管理</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">预约管理</a></li>
	</ul>
	<br/>
		<c:if test="${params.flag=='sources'}">
		<input id="flag" name="flag" type="hidden" value="sources"/>
		</c:if>
		<input id="areaId" name="areaId" type="hidden" value="${params.areaId}"/>
		<input id="hospId" name="hospId" type="hidden" value="${params.hospId}"/>
		 <div class="form-group">
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
		    </select>
		    <br/><br/>
		    医院：<select class="lSelect"  class="lSelect"  id="hospital" name="hospital">
		    <c:if test="${params.hospId==null}">
		    	<option value="0">请选择</option>
		    </c:if>
		    </select><br/><br/>
		    日期：<input class="Wdate" type="text" name="queryDate" id="queryDate"  style="width:120px;" value="" onClick="WdatePicker()">
			    <button type="button" class="btn" onclick="download()">导 出</button>
		</div>
		
		
<script type="text/javascript">

	var ctx = "${ctx}";
	
	//地区下拉联动
	 function searchArea(areaId,areaIdChild){
	 	if(areaId==0){
	 		return;
	 	}
	 	var url = ctx+"/appointment/searchArea";
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
	 	if(flag!="sources"){
	 		flag="1";
	 	}else{
	 		flag="1";
	 	}
	 	var url = ctx+"/appointment/searchHosp";
	 	$.ajax({  
	 		type : "post",  
	 		url : url,  
	 		data : {'areaId':areaId,'flag':flag},  
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
	
	
	function download(){
		
			var hospId = $("#hospital").val();
			if(hospId=="" || hospId==0){
				alert("请选择医院！");
				return;
			}
			var queryDate = $("#queryDate").val();
			if(queryDate==""){
				alert("请选择日期！");
				return;
			}
			
			var url="${ctx}/appointment/download?queryDate="+queryDate+"&hospId="+hospId;
		    window.open(url);
	}
	
	
	
	
</script>
</html>