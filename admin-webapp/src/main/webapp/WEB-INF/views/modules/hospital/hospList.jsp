<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医院列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/hospital/list" method="GET">
	<input id="areaId" name="areaId" type="hidden" value="${hosp.areaId}"/>
	
	
	<c:if test="${flag=='sources'}">
	<input id="flag" name="flag" type="hidden" value="sources"/>
	</c:if>
	所在地：  
	<c:if test="${areaIdp!=null}">${areaMap[areaIdp]}</c:if>
	<c:if test="${areaIdp==null}">
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
			    </select>
	 </c:if>
			    &nbsp;&nbsp;&nbsp;
	 <c:if test="${areaIdc!=null}">${areaMap[areaIdc]}</c:if>
	 <c:if test="${areaIdc==null}">		    
			    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="selectArea(this.value);">
			   	   <c:choose>
			   	    <c:when test="${areaId!=null && areaId!=params.areaIdParent}">
			    	<option>${areaMap[areaId]}</option>
				    </c:when>
				    <c:otherwise>
				   	    <option value="0">请选择</option>
				    </c:otherwise>
				</c:choose>
			    </select>
	  </c:if>		    
			    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	医院名称：<input type="text"  id="hospName" name="hospName"  value="${hosp.hospName}"/>&nbsp;&nbsp;&nbsp;
	医院简称：<input type="text"  id="hospSimpleName" name="hospSimpleName"   value="${hosp.hospSimpleName}"/>
	<c:if test="${flag!='sources'}">
	<br/>
	医院等级：<%-- <input type="text"  id="hospGraded" name="hospGraded"   value="${hosp.hospGraded}"/> --%>
	<select class="mSelect"  class="mSelect"  id="hospGraded" name="hospGraded" value="${hosp.hospGraded}">
					<option value="">请选择</option>
					<option value="1000">三级特等</option>
					<option value="2000">三级甲等</option>
					<option value="3000">三级乙等</option>
					<option value="4000">三级丙等</option>
					<option value="5000">二级甲等</option>
					<option value="6000">二级乙等</option>
					<option value="7000">二级丙等</option>
					<option value="8000">一级甲等</option>
					<option value="9000">一级乙等</option>
					<option value="10000">一级丙等</option>
					<option value="11000">民营医院</option>
					<option value="12000">其他</option>
				</select>&nbsp;&nbsp;&nbsp;
	<%-- 状态：<select class="mSelect"  class="mSelect"  id="isOpenedRegistration" name="isOpenedRegistration">
				 <c:if test="${hosp.isEnabled==null || hosp.isEnabled==0}">
				 <option value="">请选择</option>
				 <option value="1">启用</option>
				 <option value="2">禁用</option>
				 </c:if>
				 <c:if test="${hosp.isEnabled==2}">
				 <option value="1">启用</option>
				 <option value="2" selected="selected">禁用</option>
				 </c:if>
				 <c:if test="${hosp.isEnabled==1}">
				 <option value="1" selected="selected">启用</option>
				 <option value="2">禁用</option>
				 </c:if>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --%>
	</c:if>
	<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<c:if test="${flag!='sources'}">
    <a href="${ctx}/hospital/toAddorEdit">添加医院</a>
    </c:if>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医 院 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<th class="text-center">排序</th>
			    <th class="text-center">医院编号</th>
				<th class="text-center">医院名称</th>
				<th class="text-center">医院简称</th>
				<c:if test="${flag!='sources'}">
				<th class="text-center">医院级别</th>
				<th class="text-center">所在地区</th>
				<th class="text-center">是否启用</th>
				<th class="text-center">创建人</th>
				<th class="text-center">最后修改时间</th>
				</c:if>
				<th class="text-center">操作</th>
				<th class="text-center">生成二维码</th>
			</tr>
			</thead>
			<c:forEach items="${hospList}" var="hosp" varStatus="status">
			<tr>
				<%-- <td class="text-center">${status.count}</td> --%>
				<td>${hosp.sort}</td>
				<td>${hosp.hospCode}</td>
				<td>${hosp.hospName}</td>
				<td>${hosp.hospSimpleName}</td>
				<c:if test="${flag!='sources'}">
				<td>${hosp.hospGradedText}</td>
				<td>${fn:substringAfter(hosp.areaNamePath, "-")}</td>
				<td>
				 <c:if test="${hosp.isEnabled==2}"><span style="color:red;">禁用</span></c:if>
				 <c:if test="${hosp.isEnabled==1}">启用</c:if>
				 &nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="changeStat('${hosp.hospId}','${hosp.isEnabled}')">切换</button>
				</td>
				<td>${hosp.creatorName}</td>
				<td><fmt:formatDate value="${hosp.creationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</c:if>
				<c:if test="${flag!='sources'}">
					<td><a href="${ctx}/hospital/toAddorEdit?hospId=${hosp.hospId}">编辑</a>&nbsp;<a href="#" del_id="${hosp.hospId}">删除</a>
					<%-- <a href="${ctx}/stopAndVisit/toAddorEdit?hospId=${hosp.hospId}">停复诊管理</a> --%>
					</td>
				</c:if>
				<c:if test="${flag=='sources'}">
				<td><a href="${ctx}/doctor/list?flag=sources&hospId=${hosp.hospId}">查看医生</a></td>
				</c:if>
				<td style="width:125px;">
					<button type="button" class="encode_download" id="${hosp.hospId}">下载</button>&nbsp;
					<button type="button" class="encode_weixin" id="${hosp.hospId}">微信</button>
				</td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/hospital/list?areaId=${hosp.areaId}&areaIdParent=${params.areaIdParent}&hospName=${hosp.hospName}&hospSimpleName=${hosp.hospSimpleName}&hospGraded=${hosp.hospGraded}"/>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//让医院等级被选中
	document.getElementById("hospGraded").value = "${hosp.hospGraded}";
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id');
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get("${ctx}/hospital/delete/"+id, function(json) {
					var msg = "";
					if (json.message) {
						msg = json.message;
					}
					$.alert(msg, function() {
						window.location.reload();
					});
				}, "json");
			});
		}
	});
	//查询条件赋值
	var areaIdParent = "${params.areaIdParent}";
	var areaId = "${hosp.areaId}";
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,null);
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		searchArea(areaIdParent,areaId);
	}
	
	
	/*-----------二维码 start---------*/
	/* $(window.parent.document).find("#myModal").remove();
	$(window.parent.document).find('body').append('<div id="myModal" class="modal"><img  src="" style="cursor: pointer;" /></div>');
	
	var $myModal = $(window.parent.document).find("#myModal");
	$myModal.css({"width": "300px","height": "300px","margin": "auto","display": "none","position": "fixed"});
	$myModal.find("img").css("margin","auto"); */
	
	$(".encode_download").click(function(){
		var $this = $(this);
		var hospId = $this.attr("id");
		/* $myModal.find("img").attr("src",'${ctx }'+"/code.jsp?type=1&hospId="+hospId);
		$myModal.show(); */
		window.open('${ctx }'+"/code.jsp?type=1&hospId="+hospId);
		
	});
	
	$(".encode_weixin").click(function(){
		var $this = $(this);
		var hospId = $this.attr("id");
		/* 
		$myModal.find("img").attr("src",'${ctx }'+"/code.jsp?type=2&hospId="+hospId);
		$myModal.show(); */
		window.open('${ctx }'+"/code.jsp?type=2&hospId="+hospId);
		
	});
	
	/*  $myModal.click(function(){
		$myModal.hide();
	}); */
	 
	/*-----------二维码 end---------*/
	
	
});

function searchArea(areaId,areaIdChild){
	var url = ctx+"/hospital/searchArea";
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
	if(areaId!=0){
	   $("#areaId").val(areaId);
	}
	
}

function selectArea(areaIdC){
	if(areaId!=0){
		   $("#areaId").val(areaIdC);
		}
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
</script>
</body>
</html>