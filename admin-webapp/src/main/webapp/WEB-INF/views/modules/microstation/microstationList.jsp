<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院微站列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医院微站列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/microstation/list" method="GET">
	<input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	所在地：  
	<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null)">
    <option value="0">请选择</option>
    <c:forEach items="${areaList}" var="area" varStatus="status">
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
    </c:forEach>
    </select>&nbsp;&nbsp;&nbsp;
    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
    <c:choose>
   	    <c:when test="${areaId!=null && areaId!=areaIdParent}">
    	<option>${areaMap[areaId]}</option>
	    </c:when>
	    <c:otherwise>
	   	    <option value="0">请选择</option>
	    </c:otherwise>
	</c:choose>
    </select>&nbsp;&nbsp;&nbsp;
    医院：<select class="lSelect"  class="lSelect"  id="hospital" name="hospital" onchange="selectHosp(this.value)">
   <%-- <c:if test="${hospId!=null}">
    	<option>${hospName}</option>
    </c:if> --%>
    <c:if test="${hospId==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select>
	<!-- <input type="submit" id="searchBut" value="查询" /> -->
	</form>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医 院 微 站 列 表
			</h4>
		</div>
	<c:if test="${micStation!=null}">
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">模块</th>
				<th class="text-center">状态</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<tr>
				<td>预约挂号</td>
				<td>
				 <c:if test="${micStation.register==0}">
				 <input type="radio" name="aa1" value="register,0" checked="checked">关闭
				 <input type="radio" name="aa1" value="register,1">开启
				 </c:if>
				 <c:if test="${micStation.register==1}">
				 <input type="radio" name="aa1" value="register,0">关闭
				 <input type="radio" name="aa1" value="register,1" checked="checked">开启
				 </c:if>
				 </td>
				<td></td>
			</tr>
		    <tr>
		    <td>智能导诊</td>
		    <td>
			    <c:if test="${micStation.guidance==0}">
				    <input type="radio" name="aa2" value="guidance,0" checked="checked">关闭
				    <input type="radio" name="aa2" value="guidance,1">开启
			    </c:if>
			    <c:if test="${micStation.guidance==1}">
				    <input type="radio" name="aa2" value="guidance,0">关闭
				    <input type="radio" name="aa2" value="guidance,1" checked="checked">开启
			    </c:if>
			</td>
			<td></td>
		    </tr>
		    <tr>
		    <td>交通路线</td>
		    <td>
			    <c:if test="${micStation.trafficRoute ==0}">
				    <input type="radio" name="aa3" value="traffic_route,0" checked="checked">关闭
				    <input type="radio" name="aa3" value="traffic_route,1">开启
			    </c:if>
			    <c:if test="${micStation.trafficRoute ==1}">
				    <input type="radio" name="aa3" value="traffic_route,0">关闭
				    <input type="radio" name="aa3" value="traffic_route,1" checked="checked">开启
			    </c:if>
			</td>
			<td></td>
		    </tr>
		    <tr>
		    <td>专家排班表</td>
		    <td>
			  <c:if test="${micStation.scheduling==0}">
				    <input type="radio" name="aa4" value="scheduling,0" checked="checked">关闭
				    <input type="radio" name="aa4" value="scheduling,1">开启
			   </c:if>
			   <c:if test="${micStation.scheduling==1}">
				    <input type="radio" name="aa4" value="scheduling,0">关闭
				    <input type="radio" name="aa4" value="scheduling,1" checked="checked">开启
			   </c:if>
			   <%--<input type="radio" name="aa4" value="scheduling,0"  checked="checked">关闭 --%>
			</td>
			<td></td>
		    </tr>
		    <tr>
		    <td>医院动态</td>
		   <td>
			    <%-- <c:if test="${micStation.hospDynamic==0}">
				    <input type="radio" name="aa5" value="hosp_dynamic,0" checked="checked">关闭
				    <input type="radio" name="aa5" value="hosp_dynamic,1">开启
			    </c:if>
			    <c:if test="${micStation.hospDynamic==1}">
				    <input type="radio" name="aa5" value="hosp_dynamic,0">关闭
				    <input type="radio" name="aa5" value="hosp_dynamic,1" checked="checked">开启
			    </c:if> --%>
			    <input type="radio" name="aa5" value="hosp_dynamic,0" checked="checked">关闭
			</td>
			<td></td>
		    </tr>
		    <tr>
		    <td>楼层分布</td>
		   <td>
			    <c:if test="${micStation.floorDistribution==0}">
				    <input type="radio" name="aa6" value="floor_distribution,0" checked="checked">关闭
				    <input type="radio" name="aa6" value="floor_distribution,1">开启
			    </c:if>
			    <c:if test="${micStation.floorDistribution==1}">
				    <input type="radio" name="aa6" value="floor_distribution,0">关闭
				    <input type="radio" name="aa6" value="floor_distribution,1" checked="checked">开启
			    </c:if>
			    <!-- <input type="radio" name="aa6" value="floor_distribution,0" checked="checked">关闭 -->
			</td>
			<td><!-- <a href="javascript:void(0)" >编辑</a> --></td>
		    </tr>
		    <tr>
		    <td>预约检查</td>
		   <td>
			    <%-- <c:if test="${micStation.orderCheck==0}">
				    <input type="radio" name="aa7" value="order_check,0" checked="checked">关闭
				    <input type="radio" name="aa7" value="order_check,1">开启
			    </c:if>
			    <c:if test="${micStation.orderCheck==1}">
				    <input type="radio" name="aa7" value="order_check,0">关闭
				    <input type="radio" name="aa7" value="order_check,1" checked="checked">开启
			    </c:if> --%>
			    <input type="radio" name="aa7" value="order_check,0" checked="checked">关闭
			</td>
			<td></td>
		    </tr>
		    <tr>
		    <td>报告查询</td>
		   <td>
			    <c:if test="${micStation.reportQuery==0}">
				    <input type="radio" name="aa8" value="report_query,0" checked="checked">关闭
				    <input type="radio" name="aa8" value="report_query,1">开启
			    </c:if>
			    <c:if test="${micStation.reportQuery==1}">
				    <input type="radio" name="aa8" value="report_query,0">关闭
				    <input type="radio" name="aa8" value="report_query,1" checked="checked">开启
			    </c:if>
			    <!-- <input type="radio" name="aa8" value="report_query,0" checked="checked">关闭 -->
			</td>
			<td></td>
		    </tr>
		    <tr>
		    <td>在线支付</td>
		   <td>
			    <%-- <c:if test="${micStation.onlinePayment==0}">
				    <input type="radio" name="aa9" value="online_payment,0" checked="checked">关闭
				    <input type="radio" name="aa9" value="online_payment,1">开启
			    </c:if>
			    <c:if test="${micStation.onlinePayment==1}">
				    <input type="radio" name="aa9" value="online_payment,0">关闭
				    <input type="radio" name="aa9" value="online_payment,1" checked="checked">开启
			    </c:if> --%>
			    <input type="radio" name="aa9" value="online_payment,0" checked="checked">关闭
			</td>
			<td></td>
		    </tr>
		    
		    <tr>
		    <td>抢号开关</td>
		    <td>
			    <c:if test="${micStation.competeResource==0}">
				    <input type="radio" name="aa10" value="compete_resource,0" checked="checked">关闭
				    <input type="radio" name="aa10" value="compete_resource,1">开启
			    </c:if>
			    <c:if test="${micStation.competeResource==1}">
				    <input type="radio" name="aa10" value="compete_resource,0">关闭
				    <input type="radio" name="aa10" value="compete_resource,1" checked="checked">开启
			    </c:if>
			</td>
			<td></td>
		    </tr>
		    
		     <tr>
		    <td>检验检查报告显示方式</td>
		    <td>
			    <c:if test="${micStation.displayType==0}">
				    <input type="radio" name="aa11" value="display_type,0" checked="checked">混合显示
				    <input type="radio" name="aa11" value="display_type,1">分开显示
			    </c:if>
			    <c:if test="${micStation.displayType==1}">
				    <input type="radio" name="aa11" value="display_type,0">混合显示
				    <input type="radio" name="aa11" value="display_type,1" checked="checked">分开显示
			    </c:if>
			</td>
			<td></td>
		    </tr>
		    
		     <tr>
		    <td>检验检查报告分开显示</td>
		    <td>
			    <c:if test="${micStation.reportType==0}">
				    <input type="radio" name="aa12" value="report_type,0" checked="checked">检查报告
				    <input type="radio" name="aa12" value="report_type,1">检验报告
			    </c:if>
			    <c:if test="${micStation.reportType==1}">
				    <input type="radio" name="aa12" value="report_type,0">检查报告
				    <input type="radio" name="aa12" value="report_type,1" checked="checked">检验报告
			    </c:if>
			</td>
			<td></td>
		    </tr>
		    
		    <tr>
		    <td>查询参数</td>
		    <td><input id="queryParameter" name="queryParameter" style="width:300px;float:left" value="${fn:escapeXml(micStation.queryParameter)}"/>
		    <span id="wmessage" style="color:red;display:none;float:left;"></span></td>
		    </tr>
		</table>
	
	
	</div>
	<div style="text-align:center"><button type="button" id="savBut" class="btn btn-primary"  onclick="submitRed();">保 存</button></div>
	</c:if>	
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	var hospId = $("#hospId").val();
	var hospName = $("#hospName").val();
	/* if(hospId=="" && hospName==""){
		$('#searchBut').attr('disabled', true);
	}else{
		 $("#searchBut").removeAttr("disabled");
	} */
	
	//查询条件赋值
	var areaIdParent = "${areaIdParent}";
	var areaId = "${areaId}";
	var hospId = "${hospId}";
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,null);
		if(hospId!=""){
			searchHosp(areaIdParent,hospId);
		}	
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		searchArea(areaIdParent,areaId);
		if(hospId!=""){
			searchHosp(areaId,hospId);
		}	
	}
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
	var flag = "${flag}";
	if(flag!="sources"){
		flag="1";
	}else{
		flag="";
	}
	var url = ctx+"/doctor/searchHosp";
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
		      //alert(hospId);
			for(var i=0; i<json.length; i++) 
			{   
				/* if(i==0 && (hospId =="" || hospId == null)){
					$("#hospId").val(json[i].hospId);
				} */
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
	$('#savBut').attr('disabled', true);
	this.form.submit();
}


function changeStat(hospId,isEnabled){
	//转换启用禁用状态
	if(isEnabled==2){
		isEnabled=1;
	}else if(isEnabled==1){
		isEnabled=2;
	} 
	var change = hospId+","+isEnabled;
	var url="${ctx}/hospital/changeStatus";
	//alert(url);
	//window.location.href=url;
	$.post(url,{'change':change},function (data){
		alert(data.message);
		window.location.href=window.location.href;
	});
	
}

function submitRed(){
	var checkedRadio = $("input[type='radio']:checked");
	var length = checkedRadio.length;
	var queryParameter = $("#queryParameter").val();//查询参数
	if(queryParameter=="" || queryParameter==" " || queryParameter==null){
		$('#wmessage').text("请填写查询参数！");
		document.getElementById("wmessage").style.display="block";
		return;
	}else{
		document.getElementById("wmessage").style.display="none";
	}
	
	var url = ctx+"/microstation/changeStatus";
	$.confirm("确定修改相关信息吗？", function() {
		var hospId=$("#hospId").val();
		
		var sql = "";
		
		
		//var jsonDate = ("{\"hospId\":"+hospId+",");
	
		for (var i = 0;i<length;i++){
			var oneRadio = checkedRadio.eq(i).val().split(",");
			//alert(oneRadio[0]+""+oneRadio[1]);
			sql += oneRadio[0]+"="+oneRadio[1] + ",";
		}
		
		//sql=sql.substring(0,sql.length-1);
		queryParameter="\""+queryParameter.replaceAll("\"","\\\"")+"\"";
		sql += "query_parameter="+queryParameter;
		sql += "hosp_id" + hospId;
		/* alert(sql);
		return; */
		//var result1 = eval('(' + jsonDate + ')');
		  $.ajax({
	         type: "POST",
	         url:url,
	         dataType: "text",
	         contentType:"application/html",
	         data:sql, 
	         success: function(data){
	        	 var result = eval('(' + data + ')');
	        	 alert(result.message);
	        	 window.location.reload();
	         }
	        });  
	});
}
	
String.prototype.replaceAll = function(s1,s2) { 
    return this.replace(new RegExp(s1,"gm"),s2); 
}
</script>
</body>
</html>