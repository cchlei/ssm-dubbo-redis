<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html><!DOCTYPE html>
<head>
	<title>${sysname}后台管理系统-管理员登录</title>
	 <style> 
		body{margin:0;padding:0;background: url(../static/images/dyt-bg.jpg) no-repeat;background-size:cover;text-align: center;}
		.content{width:763px;height: 583px;background:url(../static/images/content.png) no-repeat;margin: 0 auto;margin-top: 95px;padding-top: 56px;}
		.header{color: #FFF;}
		.header h2{font-size: 32px;font-family: "Microsoft YaHei";letter-spacing:2px;margin: 0;}
		.header{font-size: 14px;}
		.header p{margin-top: 18px;font-family:"Simsun" }
		.header img{vertical-align: middle;margin-right:10px; }
		.remind{color: #C5DEFF;margin-top: 70px;font-size:14px;font-family:"Simsun";}
		.address,.admin,.yanzheng{ font-size: 12px;color: #C5DEFF;font-family:"Simsun";}
		.address{margin-top: 60px;}
		.address select{width: 120px;margin-right: 20px;}
		.admin{margin-top: 38px;margin-left: 20px;}
		.admin input,.yanzheng input{width: 115px;margin-right: 20px;}
		.yanzheng{margin:38px 0;margin-left: -65px;}
		.yanzheng img{vertical-align: middle; margin-right: 8px;}
		button{background: #234697; border:none;cursor: pointer;}
		a{text-decoration: none;}
	 </style>
</head>
<body>
	<div class="content">
		<div class="header">
			<img src="../static/images/${systitleimg}">
			<p><!-- <img src="../static/images/tel.png">技术支持电话：021-54963300-116 --></p>
		</div>
			<p class="remind">为了保证您账号的安全性，请经常更换密码</p>
			<p class="remind">
			<c:if test="${msg!=null}">${msg}</c:if>
			</p>
			
		<form id="from" name="form" role="form" action="${ctx}/account/login" method="POST">
		<input id="loginType" name="loginType" type="hidden" value="0"/>
		<input id="roleId" name="roleId" type="hidden" value="${roleId}"/>
			<div class="input">
				<div class="admin">
					操作员： <input type="text" id="userName" name="userName" value="">
					
					 密码：<input type="password" id="password" name="password" value="" autocomplete="off" onfocus="this.type='password'">请注意密码的安全
				</div>
				<div class="yanzheng">
					<!-- 验证码： <input type="text"> <img src="../static/images/yanzhengma.jpg"> <a href="#">看不清楚点击这里</a> -->
				</div>
				<div class="address" style="margin-top:0px; "> 
				权限：<select class="mSelect"  class="mSelect"  id="identity" name="identity">
				    <c:forEach items="${roleList}" var="role" varStatus="status">
				    	<c:choose>
				    	   <c:when test="${'hospital_manager'==role.identity}"></c:when>
				    	   <c:when test="${roleId==role.identity}">
						        <option value="${role.identity}" selected="selected">${role.name}</option>
					       </c:when>
					       <c:otherwise>
					            <option value="${role.identity}">${role.name}</option>
					       </c:otherwise>
						</c:choose>
				    </c:forEach>
				    </select>
				</div>
				<div class="yanzheng"></div>
				<input type="submit" id="sub" value="" style="border:0px;cursor:hand;width:217px;background-image:url('../static/images/button-enter.jpg');height:53px" />  
			</div>
			
		</form>
	</div>
	
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	$("#password").val('');
	var result = "<%=session.getAttribute("error")%>";
	if(result!=''&&result!=null&&result!='null'){
	     alert(result);
	}
});

$("#sub").click(function() {
	var name =$("#userName").val();
	
	$("#password").val(hex_encrypt($("#password").val()));
	//alert($("#password").val());

	if(name==""||password==""){
		alert("请输入用户名密码");
		return false;
	}
});
</script>	
</body>
</html>