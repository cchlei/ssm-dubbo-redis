<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>标签列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">手工执行定时任务</a></li>
	</ul>
	<br/>
	<div>
	          渠道类型：<select class="mSelect"  class="mSelect"  id="interfaceType" name="interfaceType" onchange="searchHospital(this.value);">
			    <option value="">请选择</option>
				<option value="0">第三方医院调用pavo接口</option>
				<option value="1">pavo调用第三方接口</option>
				<option value="2">前置机</option>
			</select>
  		    前置机：<select class="mSelect"  class="lSelect"  id="hospital" name="hospital">
		         <%-- <c:forEach items="${areaList}" var="area" varStatus="status">
			       <c:if test="${area.parentId==0}">
				    	<c:choose>
					       <c:when test="${areaIdParent!=null && areaIdParent==area.areaId}">
					       		<option value="${area.areaId}" selected="selected">${area.areaName}</option>
					       </c:when>
					       <c:otherwise>
						    	<option value="${area.areaId}">${area.areaName}</option>
						   </c:otherwise>
					   </c:choose> 	
				   </c:if>
			    </c:forEach> --%>
   		    </select> 
    </div>
    	<br/>
    	 <div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">前置机初始化</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="initialize" name="initialize" placeholder="手工执行定时任务，点击执行" 
					 value="${errMsg}">
			</div>
			<button type="button" class="btn" onclick="initialize()">初始化</button>
		</div>
	    
	   	
		 <div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">同步预约就诊数据：</label>
			
				同步时间：<input class="Wdate" type="text" name="hospitalTime" id="hospitalTime"  value="<fmt:formatDate value="${hospitalTime}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;
				
				<input type="text"  style="width:200px;"  id="hospId2" name="hospId2" placeholder="手工执行定时任务，点击执行" 
					 value="${errMsg}">
			
			<button type="button" class="btn" onclick="doexecute()">执行</button>

		</div>
		
		<div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">同步科室数据：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="departmentId" name="departmentId" placeholder="手工执行定时任务，点击执行" 
					 value="${errMsg}">
			</div>
			<button type="button" class="btn" onclick="doexecute2()">执行</button>
		</div>
		<div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">同步医生数据：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="doctorId" name="doctorId" placeholder="手工执行定时任务，点击执行" 
					 value="${errMsg}">
			</div>
			<button type="button" class="btn" onclick="doexecute3()">执行</button>
		</div>
		<div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">号源定时下载：</label>
			
				号源时间：<input class="Wdate" type="text" name="hospitalDownTime" id="hospitalDownTime"  value="<fmt:formatDate value="${hospitalDownTime}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;
				
				<input type="text" id="resourceIdDownload" style="width:200px;" name="resourceIdDownload" placeholder="手工执行定时任务，点击执行" 
					 value="${errMsg}">
				
			
			<button type="button" class="btn" onclick="doexecute4()">执行</button>
		</div>
		<div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">号源定时更新：</label>
			
				号源时间：<input class="Wdate" type="text" name="hospitalUplaodTime" id="hospitalUplaodTime"  value="<fmt:formatDate value="${hospitalUplaodTime}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;
				<input type="text"  id="resourceIdUpdate" style="width:200px;"  name="resourceIdUpdate" placeholder="手工执行定时任务，点击执行" 
					 value="${errMsg}"> 
				
			
			<button type="button" class="btn" onclick="doexecute5()">执行</button>
		</div>
	
<script type="text/javascript">
	 var ctx = "${ctx}";
	 $(document).ready(function() {
		 
	 
	 	var interfaceType = "${interfaceType}";
	 	if(interfaceType!=""){
	 		searchHospital(interfaceType);
	 	}else {
	 		searchHospital(0);
	 	}
	 });
	 
	//前置机下拉联动
	 function searchHospital(interfaceType){
	 	if(interfaceType==null){
	 		return;
	 	}
	 	var url = ctx+"/processorHand/searchHospital";
	 	$.post(url,{'interfaceType':interfaceType},function (data){
	 		json = eval(data);
	 		  // 先清空第二个 
	 	      $("#hospital").empty(); 
	 	      var option = "";
	 	      option = $("<option>").val(0).text("请选择");
	 	      $("#hospital").append(option); 
	 		for(var i=0; i<json.length; i++) 
	 		{ 
	 			/* if(hospital!=null && hospital == json[i].hospitalId){
	 				option = $("<option>").val(json[i].hospitalId).text(json[i].areaName).prop("selected",true);
	 			}else{
	 				option = $("<option>").val(json[i].areaId).text(json[i].areaName);
	 			} */
	 			option = $("<option>").val(json[i].hospitalId).text(json[i].hospitalId);
	 		    //alert(json[i].areaId+" " + json[i].areaName) 
	 		    $("#hospital").append(option); 
	 		} 
	 	});
	 	var hospital = $("#hospital");
	 	 if(hospital!=0){
	 	   $("#hospital").val(hospital);
	 	 }  
	 	
	 }

	 function initialize(){
		    var hospital = $("#hospital").val();
			if(hospital == null || hospital == 0){
				alert("请选择前置机，然后执行");
				return;
			}
			var url = ctx+"/processorHand/initialize";
			$.post(url,{
				'hospital' : hospital,
				},function (data){
		 		json = eval(data);
		 		 $("#initialize").val(json.message);
		 		 alert(json.message);
		 	});
		}
 
	function doexecute(){
	    var hospital = $("#hospital").val();
	    var hospitalTime = $("#hospitalTime").val();
		if(hospital == null || hospital == 0){
			alert("请选择前置机，然后执行");
			return;
		}
		var url = ctx+"/processorHand/toTiminghospId2";
		$.post(url,{
			'hospital' : hospital,
			'hospitalTime' : hospitalTime,
			},function (data){
	 		json = eval(data);
	 		 $("#hospId2").val(json.message);
	 		 alert(json.message);
	 	});
	}
	
	function doexecute2(){
	    var hospital = $("#hospital").val();
		if(hospital == null || hospital == 0){
			alert("请选择前置机，然后执行");
			return;
		}
		var url = ctx+"/processorHand/toTimingDepartmentId";
		$.post(url,{
			'hospital' : hospital,
			},function (data){
	 		json = eval(data);
	 		 $("#departmentId").val(json.message);
	 		 alert(json.message);
	 	});
	}
	
	function doexecute3(){
	    var hospital = $("#hospital").val();
		if(hospital == null || hospital == 0){
			alert("请选择前置机，然后执行");
			return;
		}
		var url = ctx+"/processorHand/toTimingDoctorId";
		$.post(url,{
			'hospital' : hospital,
			},function (data){
	 		json = eval(data);
	 		 $("#doctorId").val(json.message);
	 		 alert(json.message);
	 	});
	}
	
	
	function doexecute4(){
	    var hospital = $("#hospital").val();
	    var hospitalDownTime = $("#hospitalDownTime").val();
		if(hospital == null || hospital == 0){
			alert("请选择前置机，然后执行");
			return;
		}
		var url = ctx+"/processorHand/toTimingResourceIdDownload";
		$.post(url,{
			'hospital' : hospital,
			'hospitalDownTime' : hospitalDownTime,
			},function (data){
	 		json = eval(data);
	 		 $("#resourceIdDownload").val(json.message);
	 		 alert(json.message);
	 	});
	}
	
	function doexecute5(){
	    var hospital = $("#hospital").val();
	    var hospitalUplaodTime = $("#hospitalUplaodTime").val();
		if(hospital == null || hospital == 0){
			alert("请选择前置机，然后执行");
			return;
		}
		var url = ctx+"/processorHand/toTimingResourceIdUpdate";
		$.post(url,{
			'hospital' : hospital,
			'hospitalUplaodTime' : hospitalUplaodTime,
			},function (data){
	 		json = eval(data);
	 		 $("#resourceIdUpdate").val(json.message);
	 		 alert(json.message);
	 	});
	}
	
	
	
</script>

</body>
</html>