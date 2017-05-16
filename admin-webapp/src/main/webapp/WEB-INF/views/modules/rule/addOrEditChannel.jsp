<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>渠道编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">渠道编辑</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/channel/save" method="POST">
	    <c:if test="${channelInfo!=null}">
			<input id="channelId" name="channelId" type="hidden" value="${channelInfo.channelId}"/>
	    </c:if>
	    <input id="ifExist" name="ifExist" type="hidden"/>
	    
		<div class="form-group">
			<label for="channelName" class="col-sm-2 control-label"><span style="color:red;">*</span>渠道名称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="channelName" name="channelName" placeholder="渠道名称" datatype="*2-100"
					nullmsg="请输入渠道名称名称！" errormsg="渠道名称至少2个字符,最多100个字符！" value="${channelInfo.channelName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="isEnabled" class="col-sm-2 control-label">状 &nbsp;&nbsp;态 ：</label>
			<div class="col-sm-4">
				<select class="sSelect"  class="sSelect"  id="isEnabled" name="isEnabled">
				 <c:if test="${channelInfo.isEnabled==0}">
				 <option value="0" selected="selected">禁用</option>
				 <option value="1">启用</option>
				 </c:if>
				 <c:if test="${channelInfo.isEnabled==1||channelInfo.isEnabled==null}">
				 <option value="0">禁用</option>
				 <option value="1" selected="selected">启用</option>
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
		var channel = "${channelInfo}";
		var channelId = null;
		var ctx = "${ctx}";
		if(channel!=""){
			document.form1.action=ctx+"/channel/update"; 
			channelId = $("#channelId").val();
		}
		
		//验证渠道名称有没有重复
		$("input[name='channelName']").blur(function (){
		var url = "${ctx}/channel/ifExist";
		var channelName = $("#channelName").val();
		 $.post(url,{'channelName':channelName,'channelId':channelId},function (data){
				if(!data.success){
					$('#wmessage').text("该渠道名称已存在！");
					document.getElementById("wmessage").style.display="block";
					//alert("该地区名称已存在！");
					$("#ifExist").val("1");
				}else{
					$("#ifExist").val("0");
					document.getElementById("wmessage").style.display="none";
				}
		 });
		});
		
		
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
				var ifExist = $("#ifExist").val();
				if(ifExist=="1"){
					alert("该渠道名称已存在！");
					return false;
				}
				
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						//window.location.reload();
						window.location.href = '${ctx}/channel/list';
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