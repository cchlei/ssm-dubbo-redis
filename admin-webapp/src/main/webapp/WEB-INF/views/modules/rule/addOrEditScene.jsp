<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>场景编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">场景编辑</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/scene/save" method="POST">
	    <c:if test="${sceneInfo!=null}">
			<input id="sceneId" name="sceneId" type="hidden" value="${sceneInfo.sceneId}"/>
	    </c:if>
	    <input id="ifExist" name="ifExist" type="hidden"/>
	    
	    <div class="form-group">
			<label for="sceneId" class="col-sm-2 control-label">所属渠道：</label>
			<div class="col-sm-5">
				<select class="mSelect"  class="mSelect"  id="channelId" name="channelId">
			    <option value="0">请选择</option>
			    <c:forEach items="${channelList}" var="channel" varStatus="status">
			       <c:if test="${sceneInfo.channelId==channel.channelId}">
				    	<option value="${channel.channelId}" selected="selected">${channel.channelName}</option>
				   </c:if> 	
				   <c:if test="${sceneInfo.channelId!=channel.channelId}">
				    	<option value="${channel.channelId}">${channel.channelName}</option>
				   </c:if> 	
			    </c:forEach>
			    </select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
	    
		<div class="form-group">
			<label for="sceneName" class="col-sm-2 control-label"><span style="color:red;">*</span>场景名称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="sceneName" name="sceneName" placeholder="场景名称" datatype="*2-100"
					nullmsg="请输入场景名称名称！" errormsg="场景名称至少2个字符,最多100个字符！" value="${sceneInfo.sceneName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group" id="ruleCode" >
			<label for="sceneType" class="col-sm-2 control-label"><span style="color:red;">*</span>场&nbsp;景&nbsp;类 &nbsp;型：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="sceneType" name="sceneType" placeholder="场景类型" datatype="n1-10"
					nullmsg="请输入场景类型！" errormsg="场景类型为10位数字！" value="${sceneInfo.sceneType}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">10位数字</div>
		</div>
		
		<div class="form-group">
			<label for="isEnabled" class="col-sm-2 control-label">状 &nbsp;&nbsp;态 ：</label>
			<div class="col-sm-4">
				<select class="sSelect"  class="sSelect"  id="isEnabled" name="isEnabled">
				 <c:if test="${sceneInfo.isEnabled==0}">
				 <option value="0" selected="selected">禁用</option>
				 <option value="1">启用</option>
				 </c:if>
				 <c:if test="${sceneInfo.isEnabled==1||sceneInfo.isEnabled==null}">
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
		var scene = "${sceneInfo}";
		var ctx = "${ctx}";
		var sceneId = null;
		if(scene!=""){
			document.form1.action=ctx+"/scene/update"; 
			sceneId = $("#sceneId").val();
		}
		
		//验证场景名称有没有重复
		$("input[name='sceneName']").blur(function (){
		var url = "${ctx}/scene/ifExist";
		var sceneName = $("#sceneName").val();
		 $.post(url,{'sceneName':sceneName,'sceneId':sceneId},function (data){
				if(!data.success){
					$('#wmessage').text("该场景名称已存在！");
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
					alert("该场景名称已存在！");
					return false;
				}
				
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						//window.location.reload();
						window.location.href = '${ctx}/scene/list';
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