<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>数据字典编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">数据字典编辑</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/dic/save" method="POST">
	    <c:if test="${dictInfo!=null}">
			<input id="dictId" name="dictId" type="hidden" value="${dictInfo.dictId}"/>
	    </c:if>
	    	<input id="dictCode" name="dictCode" type="hidden" value="${dictInfo.dictCode}"/>
	    
	 <%-- <div class="form-group">
			<label for="dictCode" class="col-sm-2 control-label">字&nbsp; &nbsp;典&nbsp; &nbsp;编 &nbsp; &nbsp;码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="dictCode" name="dictCode" placeholder="字典编码" datatype="*2-20"
					nullmsg="请输入字典编码！" errormsg="字典编码至少2个字符,最多20个字符！" value="${dictInfo.dictCode}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div> --%>
		
		<div class="form-group">
			<label for="dictName" class="col-sm-2 control-label">字&nbsp; &nbsp;典&nbsp; &nbsp;名 &nbsp; &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="dictName" name="dictName" placeholder="字典名称" datatype="*2-20"
					nullmsg="请输入字典名称！" errormsg="字典名称至少2个字符,最多20个字符！" value="${dictInfo.dictName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label">排 &nbsp; &nbsp;序：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="sort" name="sort" placeholder="1" datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！" value="${dictInfo.sort}">
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
		var dic = "${dictInfo}";
		var code = "${code}";
		var ctx = "${ctx}";
		if(dic!=""){
			document.form1.action=ctx+"/dic/update"; 
			
		}
		if(code!=""){
			$("#dictCode").val(code);
			
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