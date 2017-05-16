<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>注册用户列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">注册用户列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/whitelist/toAddWhitelist" method="GET">
	手机号：<input type="text"  id="phone" name="phone"  value="<c:out value='${params.phone}'/>"/>&nbsp;&nbsp;&nbsp;
	身份证号：<input type="text"  id="cardNo" name="cardNo"   value="${params.cardNo}"/>&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;<input type="button"  onclick="searchBut();" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</form>
	
	</div>
	<div class="panel panel-default">
	<div class="panel-heading">
		<h4 class="panel-title">
			<i class="glyphicon glyphicon-list"></i> 注册用户列表
		</h4>
	</div>
	<div id="selCon1">
	<form class="form-horizontal form-input" name="form2" id="form2" action="${ctx}/whitelist/saveAddWhitelist" method="POST">
	<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center" width="5%">全选<input type='checkbox'  onclick="selectAll(this,'selCon1')"></th>
			    <th class="text-center">用户ID</th>
			    <th class="text-center">用户名</th>
				<th class="text-center">身份证号</th>
				<th class="text-center">手机号</th>
			</tr>
			</thead>
			<c:forEach items="${whiteList}" var="whiteList" varStatus="status">
			<tr>
			    <td class="text-center"><input type="checkbox" name="uids" value="${whiteList.uid}"/></td>
				<td>${whiteList.uid}</td>
				<td>${whiteList.username}...</td>
				<td>${whiteList.cardNo}</td>
				<td>${whiteList.phone}</td>
			</tr>
			</c:forEach>
		</table>
		<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<span id="msg-info" style="margin-left:280px;"><button type="button" class="btn btn-primary" onclick="addWhiteBut()">确定</button></span>
		</div>
	</div>
		</form>
	</div>
	<%-- <page:page pager="${page}" linkUrl="${ctx}/whitelist/whitelist?cardNo=${params.cardNo}&phone=${params.phone}"/> --%>
	</div>
	
	
	
<script type="text/javascript">
$(document).ready(function() {
	
});
function searchBut(){
	this.form.submit();
}

function addWhiteBut(){
	if(checkedNum()<1){
		alert("请勾选注册用户！");
		return;
	}else{
		//this.form2.submit();
		 var AjaxURL= "${ctx}/whitelist/saveAddWhitelist";    
		 //alert(AjaxURL);
         //alert($('#form2').serialize());
             $.ajax({
                 type: "POST",
                 dataType: "json",
                 url: AjaxURL,
                 data: $('#form2').serialize(),
                 success: function (data) {
                     $.alert(data.message, function(){
         				window.location.href = '${ctx}/whitelist/whitelist';
         			});
                 },
                 error: function(data) {
                     alert("error:"+data.message);
                  }
             });
	}
	
}

//判断勾选的复选框个数
function checkedNum(){
	var checks = document.getElementsByName("uids");
	n = 0;
	for(i=0;i<checks.length;i++){
		if(checks[i].checked)
			n++;
	}
	return n;
}

</script>
</body>
</html>