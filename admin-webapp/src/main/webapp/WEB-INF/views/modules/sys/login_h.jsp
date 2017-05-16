<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html><!DOCTYPE html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<title>${sysname}后台管理系统-登录</title>
<link href="../static/css/common.css" rel="stylesheet" type="text/css">
<link href="../static/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>

<img src="../static/images/login-bg.jpg" class="bg">
<div class="loginContainer">
	<h1>${sysname}预约挂号门诊管理系统</h1>
	<form id="from" name="form" role="form" action="${ctx}/account/login" method="POST">
		<input id="loginType" name="loginType" type="hidden" value="1"/>
		<input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
		<input id="areaName" name="areaName" type="hidden" value="${areaName}"/>
		<input id="careaId" name="careaId" type="hidden" value="${careaId}"/>
		<input id="careaName" name="careaName" type="hidden" value="${careaName}"/>
		<input id="belongHospId" name="belongHospId" type="hidden" value="${belongHospId}"/>
		<input id="hospName" name="hospName" type="hidden" value="${hospName}"/>		
		<input id="userId" name="userId" type="hidden" value="${userId}"/>
		<input id="userName" name="userName" type="hidden" value="${userName}"/>
	<div class="loginBox">
		<div style="font-size:20px">登陆您的账户</div>
			<select class="mSelect"    id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value)">
				    <option value="0" selected="selected">请选择省市</option>
				    <c:forEach items="${areaList}" var="area" varStatus="status">
				    	<c:choose>
				    	 	<c:when test="${areaId==area.areaId}">
						        <option value="${area.areaId}" selected="selected">${area.areaName}</option>
					       </c:when>
					       <c:otherwise>
					            <option value="${area.areaId}">${area.areaName}</option>
					       </c:otherwise>
						</c:choose>
				    </c:forEach>
				    </select>
		
		<select class="mSelect"   id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
				   	    <c:if test="${careaId!=null}">
				   	    	<option value="0">请选择所在地</option>
					    	<c:forEach items="${careaList}" var="area" varStatus="status">
					    	<c:choose>
					    	 	<c:when test="${careaId==area.areaId}">
							        <option value="${area.areaId}" selected="selected">${area.areaName}</option>
						       </c:when>
						       <c:otherwise>
						            <option value="${area.areaId}">${area.areaName}</option>
						       </c:otherwise>
							</c:choose>
					   		</c:forEach>
					    </c:if>
					    <c:if test="${careaId==null}">
					    	<option value="0">请选择所在地</option>
					    </c:if>
				    </select>
		
		<select class="mSelect"   id="hospital" name="hospital" onchange="searchAdmin(this.value);" >
					    <c:if test="${belongHospId!=null}">
					    	<option value="0">选择医院</option>
					    	<c:forEach items="${hList}" var="hosp" varStatus="status">
					    	<c:choose>
					    	 	<c:when test="${belongHospId==hosp.hospId}">
							        <option value="${hosp.hospId}" selected="selected">${hosp.hospName}</option>
						       </c:when>
						       <c:otherwise>
						            <option value="${hosp.hospId}">${hosp.hospName}</option>
						       </c:otherwise>
							</c:choose>
					   		</c:forEach>
					    </c:if>
					    <c:if test="${belongHospId==null}">
					    	<option value="0">请选择医院</option>
					    </c:if>
					</select>
		<select class="mSelect" id="admin" name="admin" onchange="selectAdmin(this.value);">
					    <c:if test="${userId!=null}">
					    	<option value="0">用户名</option>
					    	<c:forEach items="${ulist}" var="user" varStatus="status">
					    	<c:choose>
					    	 	<c:when test="${userId==user.uid}">
							        <option value="${user.uid}" selected="selected">${user.username}</option>
						       </c:when>
						       <c:otherwise>
						            <option value="${user.uid}">${user.username}</option>
						       </c:otherwise>
							</c:choose>
					   		</c:forEach>
					    </c:if>
					    <c:if test="${userId==null}">
					    	<option value="0">用户名</option>
					    </c:if>
					    </select>
		
		<input type="password" id="password" name="password" value="" autocomplete="off" onfocus="this.type='password'">
		<div class="login">
			<input type="submit" id="sub" value="登录">
		</div>
		<div class="logo">
			<img src="../static/images/logo.jpg">
		</div>
		</form>
	</div>
	<p>${sysbottom}</p>
</div>


<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	var result = "<%=session.getAttribute("error")%>";
	if(result!=''&&result!=null&&result!='null'){
	     alert(result);
	}
});

$("#sub").click(function() {
	var name =$("#userName").val();
	var userid = $("#admin").val(); 
	
	$("#password").val(hex_encrypt($("#password").val()));
	var password = $("#password").val();
	var belongHospId = $("#belongHospId").val();
	var hospname = $("#hospital").find("option:selected").text();
	
	var areaidp = $("#areaIdParent").val();
	var areanamep=$("#areaIdParent").find("option:selected").text();
	
	var areaidc = $("#areaIdChild").val();
	var areanamec=$("#areaIdChild").find("option:selected").text();
	
	var loginType = $("#loginType").val();
	if((name==""||password=="")&&password!="e3048b671b8e7448093b5393adba9ace8e8c030e"){
		alert("请输入用户名密码");
		return false;
	}else{
		var url = ctx+"/account/login";
		$("#hospName").val(hospname);
		$("#belongHospId").val(belongHospId);
		$("#areaId").val(areaidp);
		$("#areaName").val(areanamep);
		$("#careaId").val(areaidc);
		$("#careaName").val(areanamec);
		$.post(url,{'userName':name,'password':password,'userId':userid,'belongHospId':belongHospId,'loginType':loginType,'hospName':hospname,'areaId':areaidp,'areaName':areanamep,'careaId':areaidc,'careaName':areanamec},function (data){
			//alert(json);
		});
	}
});

//地区下拉联动
function searchArea(areaId){
	if(areaId==0){
		return;
	}
	var url = ctx+"/regrecord/searchArea";
	$.post(url,{'areaId':areaId},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#areaIdChild").empty(); 
	      $("#hospital").empty(); 
	      $("#admin").empty();
	      var option = "";
	      option = $("<option>").val(0).text("请选择所在地");
	      $("#areaIdChild").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			option = $("<option>").val(json[i].areaId).text(json[i].areaName);
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#areaIdChild").append(option); 
		}
	});
	 searchHosp(areaId);//根据父级地区查询医院
	 if(areaId!=0){
	   $("#areaId").val(areaId);
	 } 
	
}

//医院下拉联动
function searchHosp(areaId){
	if(areaId==0){
		return;
	}
	var url = ctx+"/regrecord/searchHosp";
	$.post(url,{'areaId':areaId},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#hospital").empty(); 
	      $("#admin").empty();
	      var option = "";
	      option = $("<option>").val(0).text("请选择医院");
	      $("#hospital").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			option = $("<option>").val(json[i].hospId).text(json[i].hospName);
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#hospital").append(option); 
		} 
	});
	searchAdmin(areaId);
	 if(areaId!=0){
		 $("#areaId").val(areaId);
	} 
}

function searchAdmin(belongHospId){
	if(belongHospId==0){
		return;
	}
	$("#belongHospId").val(belongHospId);
	var url = ctx+"/account/searchAdmin";
	$.post(url,{'hospId':belongHospId},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#admin").empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("用户名");
	      $("#admin").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			option = $("<option>").val(json[i].uid).text(json[i].username);
		    $("#admin").append(option); 
		} 
	});
}

function selectAdmin(userId){
	if(userId!=0){
	   var checkText=$("#admin").find("option:selected").text();
	   $("#userName").val(checkText);
	   $("#userId").val(userId);
	}

}
</script>
<script src="../static/js/jquery.js"></script>
<script src="../static/js/animate.js"></script>
</body>
</html>
