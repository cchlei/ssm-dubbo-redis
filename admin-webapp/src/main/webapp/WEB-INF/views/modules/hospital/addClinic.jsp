<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院挂号类型编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/hospital/toAddorEdit?hospId=${hospId}">医院基本信息编辑</a></li>
		<li class="active"><a href="${ctx}/hospital/addClinic?hospId=${hospId}">挂号类型信息编辑</a></li>
		<li><a href="${ctx}/hospDep/list?hospId=${hospId}&flag=hierarchy">医院科室列表</a></li>
	</ul>
	<div style="margin-left:300px;margin-top:10px">
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/hospital/saveClinic" method="POST">
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	<c:forEach items="${dicList}" var="dic" varStatus="status">
	    <c:if test="${status.count%1==0}"><br/><br/></c:if>
	    <c:if test="${selectedDics[dic.dictId]!=null}">
	    <input type="checkbox" id="clinics" name="clinics" checked="checked"  disabled="disabled" value="${dic.dictId}"/>${dic.dictName}&nbsp; &nbsp;
	    <input name="clinics" type="hidden" value="${dic.dictId}"/>
	    </c:if>
	    <c:if test="${selectedDics[dic.dictId]==null}">
	    <input type="checkbox" id="clinics" name="clinics" value="${dic.dictId}"/>${dic.dictName}&nbsp; &nbsp;
	    </c:if>
    </c:forEach><br/><br/><br/>
	
	<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
	</form>
    </div>

<script type="text/javascript">
	$(document).ready(function() {
		var ctx = "${ctx}";
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
						//挂号类型添加成功后跳转到医院科室编辑页面
						var hospId = "${hospId}";
						if(hospId==""){
							//alert(json.errors);
							hospId = json.errors;
						}else{
							hospId = $('#hospId').val();
						}
						//alert(hospId);
						window.location.href = ctx+'/hospital/list?hospId='+hospId;
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