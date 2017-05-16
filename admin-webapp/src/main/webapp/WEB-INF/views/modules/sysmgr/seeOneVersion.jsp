<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>系统版本管理</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">系统版本管理</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/tag/save" method="POST">
		<div class="form-group">
			<label for="versionCode" class="col-sm-2 control-label">版&nbsp; &nbsp;本&nbsp; &nbsp;号：</label>
			<div class="col-sm-5">
			    1111
				${version.versionCode}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="versionName" class="col-sm-2 control-label">版&nbsp;本&nbsp;名&nbsp;称：</label>
			<div class="col-sm-5">
			1.0.0
				${version.versionName}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="versionType" class="col-sm-2 control-label">版&nbsp;本&nbsp;类&nbsp;型：</label>
			<div class="col-sm-4">
			<c:if test="${version.versionType==0}">apk</c:if>
			<c:if test="${version.versionType==1}">android资源文件</c:if>
			<c:if test="${version.versionType==2}">ios</c:if>
			<c:if test="${version.versionType==3}">ios资源文件</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="fileAddress" class="col-sm-2 control-label">文&nbsp;件&nbsp;地&nbsp;址：</label>
			<div class="col-sm-5">
				${version.fileAddress}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="isForceUpdate" class="col-sm-2 control-label">是否强制更新：</label>
			<div class="col-sm-4">
			<c:if test="${version.isForceUpdate==0}">是</c:if>
			<c:if test="${version.isForceUpdate==1}">否</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		 <div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">生&nbsp;效&nbsp;时&nbsp;间：</label>
			<div class="col-sm-5">
				<fmt:formatDate value="${version.effectTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="functionDes" class="col-sm-2 control-label">功&nbsp;能&nbsp;描&nbsp;述：</label>
			<div class="col-sm-5">
			${version.functionDes}
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength1"></div>
		</div>
		
		<div class="form-group">
			<label for="remark" class="col-sm-2 control-label">备&nbsp;&nbsp;注：</label>
			<div class="col-sm-5">
			${version.remark}
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength2"></div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
	</form>
	<br />
<%-- </div> --%>
<script type="text/javascript">
</script>
</html>