<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>标准科室编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">标准科室编辑</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/standardDep/save" method="POST">
	    <c:if test="${sdInfo!=null}">
			<input id="standardDepartmentId" name="standardDepartmentId" type="hidden" value="${sdInfo.standardDepartmentId}"/>
	    </c:if>
	    <c:if test="${departmentName!=null}">
	    <div class="form-group">
			<label for="departmentName" class="col-sm-2 control-label">上&nbsp;级&nbsp;科&nbsp;室：</label>
			<div class="col-sm-5">
				<span>${departmentName}</span>
				<input id="parentId" name="parentId" type="hidden" value="${parentId}"/>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		</c:if>
		<div class="form-group">
			<label for="departmentName" class="col-sm-2 control-label">科&nbsp; &nbsp;室&nbsp; &nbsp;名 &nbsp; &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="departmentName" name="departmentName" placeholder="科室名称" datatype="*1-20"
					nullmsg="请输入科室名称！" errormsg="科室名称至少1个字符,最多20个字符！" value="${sdInfo.departmentName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="departmentNum" class="col-sm-2 control-label">科&nbsp; &nbsp;室&nbsp; &nbsp;编 &nbsp; &nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="departmentNum" name="departmentNum"  value="${sdInfo.departmentNum}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="brevityCode" class="col-sm-2 control-label">科&nbsp; &nbsp;室&nbsp; &nbsp;简 &nbsp;&nbsp;码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="brevityCode" name="brevityCode" placeholder="科室简码" datatype="*1-10"
					nullmsg="请输入科室简码！" errormsg="科室简码至少1个字符,最多10个字符！" value="${sdInfo.brevityCode}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label">排 &nbsp; &nbsp;序：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="sort" name="sort" placeholder="1" datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！" value="${sdInfo.sort}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<c:if test="${sdInfo==null}">
			<div class="form-group">
				<label for="isEnabled" class="col-sm-2 control-label">是&nbsp;否&nbsp;启&nbsp;用：</label>
				<div class="col-sm-4">
					<select class="sSelect"  class="sSelect"  id="isEnabled" name="isEnabled">
					 <c:if test="${sdInfo.isEnabled==1||sdInfo.isEnabled==null}">
					 <option value="1" selected="selected">启用</option>
					 <option value="2">禁用</option>
					 </c:if>
					 <c:if test="${sdInfo.isEnabled==2}">
					 <option value="1">启用</option>
					 <option value="2" selected="selected">禁用</option>
					 </c:if>
					</select>
				</div>
				<div class="col-sm-5 help-block Validform_checktip"></div>
			</div>
		</c:if>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
	</form>
	<br />
<%-- </div> --%>
<script type="text/javascript">
	$(document).ready(function() {
		var tag = "${sdInfo}";
		var ctx = "${ctx}";
		if(tag!=""){
			document.form1.action=ctx+"/standardDep/update"; 
			
		}
		$(".form-input").Validform({
			showAllError : true,
			tiptype : function(msg, o, cssctl) {
				if (!o.obj.is("form")) {
					//alert($(o.obj.parent().parent().find(".Validform_checktip")).html());
					var objtip = o.obj.parent().parent().find(".Validform_checktip");
					cssctl(objtip, o.type);
					objtip.text(msg);
				} else {
					var objtip = o.obj.find("#msg-info");
					cssctl(objtip, o.type);
					objtip.text(msg);
				};
			},
			postonce : true,
			ajaxPost : true,
			beforeSubmit:function(curform){
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						window.location.reload();
						//window.location.href = '${ctx}/link/list';
					});
				} else {
					errorValidate('msg-info', json.message + ',' + "");
					
				}
				$('#fat-btn').button('reset');
			}
		});

	});
</script>
</html>