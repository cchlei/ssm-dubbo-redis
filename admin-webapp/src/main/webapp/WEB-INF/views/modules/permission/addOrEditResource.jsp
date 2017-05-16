<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>地区编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">资源编辑</a></li>
	</ul>
	<br />
	
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/resource/save" method="POST">
	    <c:if test="${resource!=null}">
			<input id="rid" name="rid" type="hidden" value="${resource.rid}"/>
	    </c:if>
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">资&nbsp; &nbsp;源&nbsp; &nbsp;名 &nbsp; &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="name" name="name" placeholder="资源名称" datatype="*2-50"
					nullmsg="请输入资源名称！" errormsg="资源名称至少2个字符,最多50个字符！" value="${resource.name}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="url" class="col-sm-2 control-label">资&nbsp;&nbsp;源&nbsp;&nbsp;路&nbsp;&nbsp;径：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="url" name="url" placeholder="资源路径" datatype="*5-100"
					nullmsg="请输入资源路径！" errormsg="资源路径至少5个字符！" value="${resource.url}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="type" class="col-sm-2 control-label">资源类型 ：</label>
			<div class="col-sm-4">
				<select class="mSelect"  class="mSelect"  id="type" name="type">
				 <c:if test="${resource.type=='normal' || resource.type==null}">
				 <option value="normal" selected="selected">PATH</option>
				 <option value="menu">菜单</option>
				 <option value="button">按钮</option>
				 </c:if>
				 <c:if test="${resource.type=='menu'}">
				 <option value="menu" selected="selected">菜单</option>
				 <option value="normal">PATH</option>
				 <option value="button">按钮</option>
				 </c:if>
				 <c:if test="${resource.type=='button'}">
				 <option value="button" selected="selected">按钮</option>
				 <option value="normal">PATH</option>
				 <option value="menu">菜单</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="type" class="col-sm-2 control-label">上级菜单 ：</label>
			<div class="col-sm-4">
				<select class="mSelect"  class="mSelect"  id="menuid" name="menuid">
				 <option value="${localmenu.rid}" selected="selected">${localmenu.name}</option>
					<c:forEach items="${menus}" var="menu" varStatus="status">
			   			<option value="${menu.rid}">${menu.name}</option>
			    	</c:forEach>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="permission" class="col-sm-2 control-label">资&nbsp;&nbsp;源&nbsp;&nbsp;标&nbsp;&nbsp;识：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="permission" name="permission" placeholder="资源标识" datatype="*2-100"
					nullmsg="请输入资源标识编码！" errormsg="资源标识编码至少2个字符！" value="${resource.permission}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
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
		var tag = "${resource}";
		var ctx = "${ctx}";
		if(tag!=""){
			document.form1.action=ctx+"/resource/update"; 
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
						//window.location.reload();
						window.location.href = '${ctx}/resource/list';
					});
				} else {
					errorValidate("msg-info", '');
					if (json.data.title) {
						errorValidate('title', json.message + ',' + json.data.title);
					}
				}
				$('#fat-btn').button('reset');
			}
		});

	});
</script>
</html>