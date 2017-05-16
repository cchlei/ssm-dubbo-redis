<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>添加陪整人员</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">添加陪整人员</a></li>
	</ul>
	<br/>
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/accomperson/savePerson" method="POST">
	    <c:if test="${accomPerson!=null}">
			<input id="id" name="id" type="hidden" value="${accomPerson.id}"/>
	    </c:if>
		<div class="form-group">
			<label for="accomName" class="col-sm-2 control-label">姓名:</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="accomName" name="accomName" placeholder="姓名" datatype="*2-100"
					nullmsg="请输入供应商名称！" errormsg="姓名至少2个字符,最多100个字符！" value="${accomPerson.accomName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<!-- 性别 -->
		<div class="form-group">
			<label for="gender" class="col-sm-2 control-label">性别:</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="gender" name="gender" placeholder="性别" datatype="*2-100"
					nullmsg="请输入性别！"  value="${accomPerson.gender}"><!--  errormsg="性别至少1个字符,最多100个字符！ -->
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
	    <!-- 手机号 -->
		<div class="form-group">
			<label for="phone" class="col-sm-2 control-label">手机号:</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="phone" name="phone" placeholder="手机号" datatype="*2-100"
					nullmsg="请输入手机号！" errormsg="手机号至少1个字符,最多100个字符！" value="${accomPerson.phone}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		 <!--状态 --> 	
		 <div class="form-group">
				<label for="isEnabled" class="col-sm-2 control-label">是&nbsp;否&nbsp;启&nbsp;用：</label>
				<div class="col-sm-4">
					<select class="sSelect"  class="sSelect"  id="status" name="status">
					 <c:if test="${accomPerson.status==1||accomPerson.status==null}">
					 <option value="1" selected="selected">启用</option>
					 <option value="0">禁用</option>
					 </c:if>
					 <c:if test="${accomPerson.status==0}">
					 <option value="1">启用</option>
					 <option value="0" selected="selected">禁用</option>
					 </c:if>
					</select>
				</div>
				<div class="col-sm-5 help-block Validform_checktip"></div>
			</div>
		<!--保存或者返回  -->
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
	</form>
	<br/>
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
								window.location.href = '${ctx}/accom/toAddorEdit';
							}else
							{
								window.location.href = '${ctx}/news/toAddorEdit4Hosp';
							}
						}else{
							window.location.href = '${ctx}/accomperson/accomPersonList';
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
 
  
 
		    	 	
	 	
		
		
		

		