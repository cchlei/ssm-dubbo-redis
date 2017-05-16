<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院大楼列表</title>
<style type="text/css">
	.floor-table{
		width:100%;
		border-bottom:1px dashed #ddd;
	}
	.floor-table td{
		padding-top:5px;
		padding-bottom:5PX;
		border-bottom:1px dashed #ddd;
	}
	.floor-table-fname{ 
		text-align: center;
		width:150px;
	}
	.floor-table-fsomething{
		text-align: left;
	}
	.floor-table-last{
		text-align: center;
		width:100px;
	}
	.floor-ul {
		padding-top:0px;
		margin: 0px;
		background-color: red;
	}
	.floor-ul li {
		background-color: blue;
		margin-top: 2px;
		margin-bottom: 2px;
		list-style: none
	}
	.head-div {
		background-color:#ddd;
		padding-left:20px;
		padding-top:10px;
		padding-bottom:10px;
		height: 40px;
		border-bottom: 1px solid #ddd;
	}
	.span-font {
		font-size:18px;
		font-weight: bold;
	}
</style>

</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医院大楼列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/hospbuilding/buildings" method="POST">
	<input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="hospId" name="hospitalKey" type="hidden" value="${hospitalKey}"/>
	所在地：  
	<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null)">
    <option value="0">请选择</option>
    <c:forEach items="${areaList}" var="area" varStatus="status">
       <c:if test="${area.parentId == 0}">
	    	<c:choose>
		       <c:when test="${areaIdParent != null && areaIdParent == area.areaId}">
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
   	    <c:when test="${areaId != null && areaId != areaIdParent}">
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
    <c:if test="${hospitalKey == null}">
    	<option value="0">请选择</option>
    </c:if>
    </select>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" id="searchBut" value="查询" />
	</form>
	<div class="panel panel-default">
		<div class="head-div">
			<span class="span-font">医院大楼列表 </span>
			[<a href="javascript:void(0)">新增大楼</a>]
		</div>
		<table class="table table-bordered table-hover tablesorter" id ="building-table">
			<thead style="display: none">
				<tr>
					<td>
						名称&nbsp;
						<input type="text" name="buildingName"/>
						排序&nbsp;
						<input type="text" name="sortIndex" value="0"/>
						启禁&nbsp;
						<select name="isEnabled">
							<option value="1">启用</option>
							<option value="2" selected="selected">禁用</option>
						</select>
					</td>
					<td><a href="javascript:void(0)" id="save-building">保存</a>&nbsp;&nbsp;&nbsp;<a id="hide-building" href="javascript:void(0)">取消</a></td>
				</tr>
			</thead>
			<c:forEach items="${buildings}" var="building" varStatus="status">
			<tr class="building${building.buildingKey}">
				<th>${building.buildingName}</th><!-- [${building.buildingKey}] -->
				<td width="200"><a href="javascript:void(0)" onclick="showtr('${building.buildingKey}')">新增楼层</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="editbuilding('${building.buildingKey}')">编辑</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" class="del-building" bid="${building.buildingKey}" onclick="deleteBuilding('${building.buildingKey}')">删除</a></td>
			</tr>
			<tr class="editinput${building.buildingKey}"><tr>
			<tr style="display: none" class="tab${building.buildingKey}">
				<td>
					楼层名称:
					<input type="text" name="floorName"/>
					<input type="hidden" name="buildingKey" id="${building.buildingKey}"/>
					楼层描述:
					<input type="text" name="floorSomething"/>
					排序:
					<input type="text" name="sortIndex" value="0" style="width: 80px;"/>
					启禁&nbsp;
					<select name="isEnabled">
						<option value="1">启用</option>
						<option value="2" selected="selected">禁用</option>
					</select>
				</td>
				<td><a href="javascript:void(0)" id="save-buildingFloor${building.buildingKey}" onclick="add('${building.buildingKey}')">保存</a>&nbsp;&nbsp;&nbsp;<a id="hide-buildingFloor${building.buildingKey}" href="javascript:void(0)">取消</a></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<c:choose>
						<c:when test="${building.floors != null && fn:length(building.floors) > 0}">
							<table class="floor-table" id="table-floor-${building.buildingKey}">
								<c:forEach items="${building.floors}" var="floor" varStatus="status2">
									<tr id="floor${floor.floorKey}">
										<td class="floor-table-fname${floor.floorKey}">${floor.floorName}</td>
										<td class="floor-table-fsomething${floor.floorKey}">${floor.floorSomething}</td>
										<input type="hidden" class="floor-table-fsortIndex${floor.floorKey}" value="${floor.sortIndex}"/>
										<input type="hidden" class="floor-table-fisEnabled${floor.floorKey}" value="${floor.isEnabled}"/>
										<td class="floor-table-last"><a href="javascript:void(0)" onclick="editFloor('${floor.floorKey}')">编辑</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteFloor('${floor.floorKey}')">删除</a></td>
									</tr>
									<tr id="editfloors${floor.floorKey}">
									</tr>
								</c:forEach>
							</table>
						</c:when>
						<c:otherwise>
							<span style="color: #ddd;">暂无楼层信息！！！</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//查询条件赋值
	var areaIdParent = "${areaIdParent}";
	var areaId = "${areaId}";
	var hospId = "${hospitalKey}";
	if(areaIdParent != "" && areaId == areaIdParent){
		searchArea(areaIdParent, null);
		if(hospId != ""){
			searchHosp(areaIdParent, hospId);
		}	
	}else if(areaIdParent != "" && areaId != areaIdParent){
		searchArea(areaIdParent, areaId);
		if(hospId != ""){
			searchHosp(areaId, hospId);
		}	
	}
	$(".head-div a").click(function(){
		$("#building-table thead").show();
	});
	$("#hide-building").click(function(){
		$("#building-table thead").hide();
	});
	$("#save-building").click(function(){
		var hospitalKey =  $("#hospital").val();
		if(hospitalKey==0||hospitalKey==null||hospitalKey==undefined||hospitalKey=="0"){
			alert("请选择一家医院!!!");
		}else{
			var n = $("#building-table thead input[name ='buildingName']").val();
			var s = $("#building-table thead input[name ='sortIndex']").val();
			var e = $("#building-table thead select[name ='isEnabled']").val();
			if(n && s && e){
				$.ajax({  
					type : "post",
					url : ctx +"/hospbuilding/addBuilding",  
					data : {'buildingName': n, 'sortIndex': s, 'isEnabled': e, 'hospitalKey': hospitalKey},  
					async : false,  
					asyncBoolean:false,
					success : function(data){  
						var msg = "";
						if (data.message) {
							msg = data.message;
						}
						$.alert(msg, function() {
							reload(); 
						});
					}  
			    });
			}else{
				alert("请正确填写相关信息");
			}
		}
	});
});

/**
 * @auhtor chlei
 * 编辑大楼信息弹出编辑框
 */
function editbuilding(id){
	var html="";
	$.ajax({  
		type : "post",
		url : ctx +"/hospbuilding/editdiv/"+id,  
		async : false,  
		asyncBoolean:false,
		success : function(data){
			html="<tr class='editbuilding"+data.results.buildingKey+"'>"+
						"<td>"+
							"名称:"+
							"<input type='text' name='buildingName' class='editBuildingName' value='"+data.results.buildingName+"'/>"+//data.results.buildingName+"</input>"+
							"排序:"+
							"<input type='text' name='sortIndex' class='editSortIndex' value='"+data.results.sortIndex+"'>"+//data.results.sortIndex+"</input>"+
							"启禁:";
			if(data.results.isEnabled=="1"){
				html+="<select name='isEnabled' class='isEnabled'>"+
							"<option value='1'selected='selected'>启用</option>"+
							"<option value='2' >禁用</option>"+
					   "</select>";
			}else{
				html+="<select name='isEnabled' class='isEnabled'>"+
							"<option value='1'>启用</option>"+
							"<option value='2' selected='selected'>禁用</option>"+
					   "</select>";
			};
				html+="</td>"+
						"<td><a href='javascript:void(0)' onclick='edit("+data.results.buildingKey+")'>保存</a>&nbsp;&nbsp;&nbsp;<a id='hide-edit-building' href='javascript:void(0)'>取消</a></td>"+
					"</tr>";
		
		$(".building"+data.results.buildingKey).hide();
		$(".editinput"+data.results.buildingKey).html(html);
		$("#hide-edit-building").click(function(){
			$(".editinput"+data.results.buildingKey).html("");
			$(".building"+data.results.buildingKey).show();
		});
		}  
    });
}

/**
*@author chlei
*@description 编辑大楼
*@time:2016/10/14 15:13
*
**/
function edit(id){
	var buildingName = $(".editBuildingName").val();
	var sortIndex = $(".editSortIndex").val();
	var isEnabled = $(".isEnabled").val();
	if(buildingName && sortIndex && isEnabled&& id){
		$.ajax({  
			type : "post",
			url : ctx +"/hospbuilding/editHospitalBuilding",  
			data : {'buildingName': buildingName, 'sortIndex': sortIndex, 'isEnabled': isEnabled, 'buildingKey': id},  
			async : false,  
			asyncBoolean:false,
			success : function(data){  
				var msg = "";
				if (data.message) {
					msg = data.message;
				}
				$.alert(msg, function() {
					reload(); 
				});
			}  
	   });
	}else{
		alert("请正确填写相关信息");
	}
};


/**
*@author chlei
*@description 显示添加楼层表格
*@
*
**/
function showtr(buildingKey){
	$(".tab"+buildingKey).show();
	$("#hide-buildingFloor"+buildingKey).click(function(){
		$(".tab"+buildingKey).hide();
	});
}


/**
 * @author chlei
 * @description 删除大楼
 */
function deleteBuilding(Id){
	$.confirm("确定要删除该大楼么?", function() {
		$.ajax({  
			type : "post",  
			url : ctx+"/hospbuilding/deleteBuilding",  
			data : {'buildingKey':Id},  
			async : false,  
			asyncBoolean:false,
			success : function(data){  
				reload(); 
			}  
	    });
	});
};

/**
*@author chlei
*@description 新增楼层
*@
*
**/
function add(buildingKey){
		var floorName = $(".tab"+buildingKey+" input[name ='floorName']").val();
		var buildingKey = buildingKey;
		var floorSomething = $(".tab"+buildingKey+" input[name ='floorSomething']").val();
		var sortIndex = $(".tab"+buildingKey+" input[name ='sortIndex']").val();
		var isEnabled = $(".tab"+buildingKey+" select[name ='isEnabled']").val();
		if(floorName && floorSomething && sortIndex && isEnabled  && buildingKey){
			$.ajax({  
				type : "post",
				url : ctx +"/hospbuilding/addBuildingFloor",  
				data : {'floorName': floorName, 'floorSomething': floorSomething, 'sortIndex': sortIndex, 'isEnabled': isEnabled, 'buildingKey': buildingKey},  
				async : false,  
				asyncBoolean:false,
				success : function(data){  
					var msg = "";
					if (data.message) {
						msg = data.message;
					}
					$.alert(msg, function() {
						reload(); 
					});
				}  
		    });
		}else{
			alert("请正确填写相关信息");
		}
};

/**
 * @auhtor chlei
 * 编辑楼层信息弹出编辑框
 */
function editFloor(id){
	var html=""
	var floorname = $(".floor-table-fname"+id).text();
	var floorsomething = $(".floor-table-fsomething"+id).text();
	var floorsortIndex = $(".floor-table-fsortIndex"+id).val();
	var floorisEnabled = $(".floor-table-fisEnabled"+id).val();
		
	html+="<td style='width: 678px;'>"+//<tr class='tab${building.buildingKey}'>"+
					"楼层名称:<input type='text' name='floorName' id='floorName"+id+"' value='"+floorname+"'>"+
// 					"<input type='hidden' name='buildingKey' id='"+id+"'  value='"+id+"'/>"+
					"楼层描述:<input type='text' name='floorSomething' id='floorSomething"+id+"'  value='"+floorsomething+"'/>"+
					"排序:<input type='text' name='sortIndex' id='sortIndex"+id+"' style='width: 80px;'  value='"+floorsortIndex+"'/>";
					
					if(floorisEnabled=="1"){
						html+="启禁&nbsp;<select name='editIsEnabled' class='isEnabled' id='isEnabled"+id+"'>"+
									"<option value='1'selected='selected'>启用</option>"+
									"<option value='2' >禁用</option>"+
							   "</select>";
					}else{
						html+="启禁&nbsp;<select name='editIsEnabled' class='isEnabled' id='isEnabled"+id+"'>"+
									"<option value='1'>启用</option>"+
									"<option value='2' selected='selected'>禁用</option>"+
							   "</select>";
					};
					html+=  "</td>"+
				  			"<td>"+
								"<a href='javascript:void(0)' id='save-buildingFloor${building.buildingKey}' onclick='editBuildingFloor("+id+")'>保存</a>&nbsp;&nbsp;&nbsp;"+
								"<a id='hide-building-Floor' href='javascript:void(0)'>取消</a>"+
							"</td>";
// 				"</tr>"
	
	$("#floor"+id).hide();
	$("#editfloors"+id).html(html);
	$("#hide-building-Floor").click(function(){
		$("#editfloors"+id).html("");
		$("#floor"+id).show();
	});
}  

/**
*@author chlei
*@description 编辑楼层
*@time:2016/10/17 15:13
*
**/
function editBuildingFloor(id){
	var floorname = $("#floorName"+id).val();
	var floorsomething = $("#floorSomething"+id).val();
	var floorsortIndex = $("#sortIndex"+id).val();
	var floorisEnabled = $("#isEnabled"+id).val();
	if(floorname && floorsomething && floorsortIndex && floorisEnabled && id){
		$.ajax({  
			type : "post",
			url : ctx +"/hospbuilding/editBuildingFloor",  
			data : {'floorName': floorname, 'floorSomething': floorsomething, 'sortIndex': floorsortIndex,'isEnabled': floorisEnabled,  'floorKey': id},  
			async : false,  
			asyncBoolean:false,
			success : function(data){  
				var msg = "";
				if (data.message) {
					msg = data.message;
				}
				$.alert(msg, function() {
					reload(); 
				});
			}  
	   });
	}else{
		alert("请正确填写相关信息");
	}
};

/**
 * @author chlei
 * @description 删除楼层
 */
function deleteFloor(floorId){
	$.confirm("确定要删除该楼层么?", function() {
		$.ajax({  
			type : "post",  
			url : ctx+"/hospbuilding/deleteFloor",  
			data : {'floorKey':floorId},  
			async : false,  
			asyncBoolean:false,
			success : function(data){  
				reload(); 
			}  
	    });
		alert(buildingKey);
	});
};

function reload(){
	var areaIdParent =  $("#areaIdParent").val();
	var areaId =  $("#areaIdChild").val();
	var hospitalKey =  $("#hospital").val();
	window.location.href = ctx +"/hospbuilding/buildings?areaIdParent="+areaIdParent+"&areaId="+ areaId+"&hospitalKey="+hospitalKey; 
}
//地区下拉联动
function searchArea(areaId,areaIdChild){
	if(areaId == 0){
		return;
	}
	var url = ctx+"/doctor/searchArea";
	$.post(url,{'areaId' : areaId},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#areaIdChild").empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择");
	      $("#areaIdChild").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(areaIdChild != null && areaIdChild == json[i].areaId){
				option = $("<option>").val(json[i].areaId).text(json[i].areaName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].areaId).text(json[i].areaName);
			}
		    $("#areaIdChild").append(option); 
		} 
	});
	 searchHosp(areaId , null);//根据父级地区查询医院
	 if(areaId != 0){
	   $("#areaId").val(areaId);
	 } 
	
}

//医院下拉联动
function searchHosp(areaId, hospId){
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
	if(areaId!=0){ $("#areaId").val(areaId); } 
}

function selectHosp(hospId){
	if(hospId != 0){
		$("#hospId").val(hospId);
	}
}
</script>
</body>
</html>