<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>资讯标签编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">资讯标签编辑</a></li>
	</ul>
	<%-- <a href="${ctx}/tag/list">跳转到标签列表页面</a> --%>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/tag/save" method="POST">
	    <c:if test="${newsTag!=null}">
			<input id="tagId" name="tagId" type="hidden" value="${newsTag.tagId}"/>
	    </c:if>
		<div class="form-group">
			<label for="tagName" class="col-sm-2 control-label">标&nbsp; &nbsp;签&nbsp; &nbsp;名 &nbsp; &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="tagName" name="tagName" placeholder="标签名称" datatype="*2-100"
					nullmsg="请输入标签名称！" errormsg="标签名称至少2个字符,最多100个字符！" value="${newsTag.tagName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="saytext" class="col-sm-2 control-label">排 &nbsp; &nbsp;序：</label>
			<div class="col-sm-4">
			<c:if test="${newsTag.weight=='' || newsTag.weight==null}">
				<input type="text" class="form-control" id="weight" name="weight"  datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！" value="1">
			</c:if>
			<c:if test="${newsTag.weight!='' && newsTag.weight!=null}">
				<input type="text" class="form-control" id="weight" name="weight"  datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！" value="${newsTag.weight}">
			</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip">(越小越靠前)</div>
		</div>
		<div class="form-group">
			<label for="isEnabled" class="col-sm-2 control-label">是&nbsp;否&nbsp;启&nbsp;用：</label>
			<div class="col-sm-4">
				<select class="sSelect"  class="sSelect"  id="status" name="status">
				 <c:if test="${newsTag.status==1||newsTag.status==null}">
				 <option value="1" selected="selected">启用</option>
				 <option value="2">禁用</option>
				 </c:if>
				 <c:if test="${newsTag.status==2}">
				 <option value="1">启用</option>
				 <option value="2" selected="selected">禁用</option>
				 </c:if>
				</select>
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
		var tag = "${newsTag}";
		var ctx = "${ctx}";
		if(tag!=""){
			document.form1.action=ctx+"/tag/update"; 
			
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
				if($('#weight').val()<1){
					alert("排序必须大于等于1！");
					return false;
				}
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						//window.location.reload();
						var flag = "${flag}";
						if(flag!=""){
							if(flag ==1)
							{
								window.location.href = '${ctx}/news/toAddorEdit';
							}else
							{
								window.location.href = '${ctx}/news/toAddorEdit4Hosp';
							}
						}else{
							window.location.href = '${ctx}/tag/list';
						}
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
