<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医院列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/holidaysHosp/list" method="GET">
	<input id="areaId" name="areaId" type="hidden" value="${hosp.areaId}"/>
	
	
	<c:if test="${flag=='sources'}">
	<input id="flag" name="flag" type="hidden" value="sources"/>
	</c:if>
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
			    </select>
			    &nbsp;&nbsp;&nbsp;
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
			    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	医院名称：<input type="text"  id="hospName" name="hospName"  value="${hosp.hospName}"/>&nbsp;&nbsp;&nbsp;
	医院简称：<input type="text"  id="hospSimpleName" name="hospSimpleName"   value="${hosp.hospSimpleName}"/>
	<c:if test="${flag!='sources'}">
	<br/>
	</c:if>
	<input type="submit" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 医 院 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">医院编号</th>
				<th class="text-center">医院名称</th>
				<c:if test="${flag!='sources'}">
				<th class="text-center">所在地区</th>
                <th class="text-center">不产生号源日期</th>
                <th class="text-center">操作</th>
				</c:if>

			</tr>
			</thead>
			<c:forEach items="${hospList}" var="hospInfo" varStatus="status">
			<tr>
				<%-- <td class="text-center">${status.count}</td> --%>
				<td>${hospInfo.hospCode}</td>
				<td>${hospInfo.hospName}</td>
				<c:if test="${flag!='sources'}">
				<td>${fn:substringAfter(hospInfo.areaNamePath, "-")}</td>
				</c:if>
	            <td>${hospInfo.searchWord}</td>
				<c:if test="${flag!='sources'}">
					<td><a href="${ctx}/holidays/getDateFilterByHospId?hospId=${hospInfo.hospId}&areaId=${hosp.areaId}&areaIdParent=${params.areaIdParent}&hospName=${hosp.hospName}&hospSimpleName=${hosp.hospSimpleName}&hospGraded=${hosp.hospGraded}&pageNum=${page.pageNum}&pageSize=${page.pageSize}">编辑</a>&nbsp;
					</td>
				</c:if>

			</tr>
			</c:forEach>
		</table>
		
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/holidaysHosp/list?areaId=${hosp.areaId}&areaIdParent=${params.areaIdParent}&hospName=${hosp.hospName}&hospSimpleName=${hosp.hospSimpleName}&hospGraded=${hosp.hospGraded}"/>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//让医院等级被选中
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
	var url = ctx+"/holidaysHosp/searchArea";
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
	var url="${ctx}/holidaysHosp/changeStatus";
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