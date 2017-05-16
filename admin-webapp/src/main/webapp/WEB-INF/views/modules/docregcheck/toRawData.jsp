<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生注册审核所填信息</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生注册审核所填信息</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/docregcheck/checkThrough" method="POST">
	    <c:if test="${userDoctor!=null}">
			<input id="userId" name="userId" type="hidden" value="${userDoctor.userId}"/>
	    </c:if>
	    <input id="areaId" name="areaId" type="hidden" value="${userDoctor.areaId}"/>
	    <input id="standDeptId" name="standDeptId" type="hidden" value="${userDoctor.standDeptId}"/>
	    <input id="gradeText" name="gradeText" type="hidden" value="${userDoctor.gradeText}"/>
	    <input id="areaName" name="areaName" type="hidden" value="${userDoctor.areaName}"/>
	    <input id="standDeptName" name="standDeptName" type="hidden" value="${userDoctor.standDeptName}"/>
	    <input id="auditStatus" name="auditStatus" type="hidden" value="${userDoctor.auditStatus}"/>
		<div class="form-group">
			<label for="areaName" class="col-sm-2 control-label">姓&nbsp; &nbsp;名 ：</label>
			<div class="col-sm-5">
			${userDoctor.name}	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group" >
			<label for="doctorCode" class="col-sm-2 control-label">所&nbsp;在&nbsp;地 &nbsp;区：</label>
			<div class="col-sm-5">
			    ${areaMap[parAreaId]}-${areaMap[userDoctor.areaId]}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="zipCode" class="col-sm-2 control-label">所&nbsp;在&nbsp;医&nbsp;院：</label>
			<div class="col-sm-5">
			${userDoctor.hospName}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="zipCode" class="col-sm-2 control-label">所&nbsp;在&nbsp;科&nbsp;室：</label>
			<div class="col-sm-5">
			${userDoctor.deptName}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label">标&nbsp;准&nbsp;科&nbsp;室：</label>
			<div class="col-sm-4">
			${sdMap[parDepartmentId]}-${sdMap[userDoctor.standDeptId]}  
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="doctorGrade" class="col-sm-2 control-label">医 &nbsp;生 &nbsp;职 &nbsp;称：</label>
			<div class="col-sm-5">
            <c:forEach items="${dicList}" var="dic" varStatus="status">
		    <c:if test="${dic.dictId==userDoctor.grade}">
		    	${dic.dictName}
		    </c:if>
			</c:forEach>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">医 &nbsp;院 &nbsp;电 &nbsp;话：</label>
			<div class="col-sm-5">
			${userDoctor.telExt}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">推&nbsp;荐&nbsp;码：</label>
			<div class="col-sm-5">
			${userDoctor.referralCode}
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<c:if test="${flag!=1}">
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">上&nbsp;传&nbsp;图&nbsp;片：</label>
			<div class="col-sm-5" id="img_div">
				<c:forEach items="${fn:split(userDoctor.activeImgUrl, ',')}" var="imgUrl" varStatus="status1">
					<img src="${imgUrl}" id="img" width="50px" height="50px"  />
				</c:forEach>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		</c:if>
		
		<div class="form-group">
			<label for="imageType" class="col-sm-2 control-label">图&nbsp;片&nbsp;类&nbsp;型</label>
			<div class="col-sm-5">
			 <c:if test="${userDoctor.imageType==1}">
				   手持医院工作证
			    </c:if>
			    <c:if test="${userDoctor.imageType==2}">
				   手持医院资格证
			    </c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
	</form>
	<br />
<%-- </div> --%>
<script type="text/javascript">
	var ctx = "${ctx}";
	$(document).ready(function() {

	});
	
	
</script>
</html>