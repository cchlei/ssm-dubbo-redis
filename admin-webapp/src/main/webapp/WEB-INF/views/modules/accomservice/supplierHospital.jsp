<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<html>
<head>
<title>陪诊订单列表</title>
<style type="text/css">
	/**表格css**/
	#box {display:table;width: 500px;}
	.css_tr {display: table-row;}
	.css_td {display: table-cell;border-bottom: 1px solid #c0c3c5;width: 261px;    padding: 12px;color:#039cf9;}
	#css_title{background-color: #9ea1a7;font-size: 22px;}
	#css_title .css_td{
		color:#000;
	}
	.datainp{width: 174px;height:27px;border:1px #ccc solid;}
	.button{width: 159px;}
	#BgDiv{background-color:#e3e3e3; position:absolute; z-index:99; left:0; top:0; display:none; width:100%; height:1000px;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}
	#DialogDiv{position:absolute;width:400px; left:45%; top:50%; margin-left:-200px;height: 510px;overflow: auto;z-index:100;background-color:#fff; border:1px #8FA4F5 solid; padding:1px;}
	/*#DialogDiv{position:absolute;width:400px; left:48%; top:50%; margin-left:-200px; height:auto; z-index:100;background-color:#fff; border:1px #8FA4F5 solid; padding:1px;}   */
	#DialogDiv h2{ height:25px; font-size:14px; background-color:#8FA4F5; position:relative; padding-left:10px; line-height:25px;}  
	#DialogDiv h2 a{position:absolute; right:5px; font-size:12px; color:#000000}  
	#DialogDiv .form{padding:10px;}
	#suppName{margin: 2px 51px;}
	#scale{margin: 2px 0px 2px 64px;}
	#accountKey{margin: 2px 59px;}
	#td-status{margin: 2px 59px;}
	#enable{margin-left: 55px;}
</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">后台管理系统</a></li>
	</ul>
	<div id="BgDiv"></div>
	<!--遮罩层显示的DIV-->  
	<div id="DialogDiv" style="display:none">  
		<h2>选择医院项目名称<a href="javascript:;" id="btnClose" onclick="closeDiv('DialogDiv')">关闭</a></h2>
		<div class="select">
			<input  type="text" id="search"/>
			<input type="button" id="select" onclick="ShowDIV('search')" class="button" value="搜索"/>
		</div>  
		<div class="form"></div>
	</div>  
	<div id="dialog">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>添加陪诊医院
			</h4>
	   </div>
		<form id="add" method="post" action="">
		<div>
			<span>所属省市:</span>
			<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null,null)">
		    	<option value="-1">请选择	</option>
		    	<c:forEach items="${areaList}" var="area" varStatus="status">
			       <c:if test="${area.parentId==0}">
						<option value="${area.areaId}">${area.areaName}</option>
				   </c:if>
		    	</c:forEach>
		    </select>
		    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
		   	    <c:choose>
			   	    <c:when test="${areaId!=null && areaId!=areaIdParent}">
			    		<option>${areaMap[areaId]}</option>
				    </c:when>
				    <c:otherwise>
				   	    <option value="0">请选择</option>
				    </c:otherwise>
				</c:choose>
		    </select>
		    <span id="tips"></span>
		</div>
		<div>
			<span>医院:</span>
			<select class="lSelect"  class="lSelect"  id="hospital" name="hospId" data-edit-select="1" onchange="setHosp(this)">
			    <c:if test="${hospId==null}">
			    	<option value="0">请选择</option>
			    </c:if>
    		</select>
		</div>
		<span>陪诊费用:</span>
		<input type="text" name="accomCost"/><br>
		<span>状态</span>
		<input type="radio" name="status" value="1" checked>启用
		<input type="radio" name="status" value="0">停用<br>
		<input type="button" class="button" id="btn" value="保存">
		<span><a href="${ctx}/accom/costsList" class="button">返回</a></span>
	  	</form>
	</div>
	<script type="text/javascript">
	$('#btn').click(function(){
		var data=$('#add').serialize()
		+"&areaParentName="+$("#areaIdParent").find("option:selected").text()
		+"&areaChildName="+$("#areaIdChild").find("option:selected").text()
		+"&hostName="+$("#hospital").find("option:selected").text();
		$.ajax({
	        cache: true,
	        type: "POST",
	        url:"addhosptial",
	        data:data,// 你的formid
	        async: true,
	        error: function(request) {
	            alert("Connection error");
	        },
	        success: function(data) {
	        	if(data.success==false){
	            	$("#tips").html("<span style='color:red;'></span>");
	        	}else{
	        		alert("添加成功!");
	        	}
	        }
	    })
	});
	//地区下拉联动
	function searchArea(areaId,areaIdChild,flag){
		alert($("#areaIdParent").find("option:selected").text());
		if(areaId==0){
			return;
		}
		var url ="searchArea";
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
		if(areaIdChild==null){
			if(flag==0||flag==null){
				searchHosp(areaId);//根据父级地区查询医院
			}
		}
		 if(areaId!=0){
		   $("#areaId").val(areaId);
		 } 
		
	}
	//医院下拉联动
	function searchHosp(areaId,hospId){
		alert( $("#areaIdChild").find("option:selected").text());
		if(areaId==0){
			var areaIdParent=$("#areaIdParent").val();
			searchArea(areaIdParent,null);
			return;
		}
		var url = "searchHosp";
		$.post(url,{'areaId':areaId},function (data){
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
		});
		if(areaId!=0){
			$("#areaId").val(areaId);
		} 
	}
	function setHosp(obj){
		var hospId = obj.options[obj.selectedIndex].value;
		var hospName = obj.options[obj.selectedIndex].text;
		$("#hospId").val(hospId);
		$("#hospName").val(hospName);
	}
	</script>
</body>
</html>