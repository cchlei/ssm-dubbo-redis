<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>就诊人端</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">系统版本管理</a></li>
	</ul>
	<br/>
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/sysmgr/save" method="POST">
		
	<input id="appType" name="appType" value="0" type="hidden">
	<input id="md5" name="md5" type="hidden"/>
		<div class="form-group">
			<label for="versionCode" class="col-sm-2 control-label">版&nbsp; &nbsp;本&nbsp; &nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="versionCode" name="versionCode" placeholder="1" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="versionName" class="col-sm-2 control-label">版&nbsp;本&nbsp;名&nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="versionName" name="versionName" placeholder="版本名称" datatype="*1-10"
					nullmsg="请输入版本名称！" errormsg="版本名称至少1个字符,最多10个字符！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="versionType" class="col-sm-2 control-label">版&nbsp;本&nbsp;类&nbsp;型：</label>
			<div class="col-sm-4">
				<select id="versionType" name="versionType" onchange="showAddressInput(this.value)">
				 <option value="0">apk</option>
				 <option value="1">android资源文件</option>
				 <option value="2">ios</option>
				 <option value="3">ios资源文件</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
	    <div id="addressDiv" class="form-group">
			<label for="fileAddress" class="col-sm-2 control-label">文&nbsp;件&nbsp;地&nbsp;址：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="fileAddress" name="fileAddress" placeholder="文件地址" datatype="*1-100"
					nullmsg="请输入文件地址！" errormsg="版本名称至少1个字符,最多100个字符！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div> 
		
		<div id="uploadDiv"  class="form-group">
			<label for="title" class="col-sm-2 control-label"> 版&nbsp;本&nbsp;上&nbsp;传：</label>
			<div class="col-sm-5">
				 <input type="file" name="file" id="file"/><br/><input type="button" value="上传" onclick="upFile();" />  	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"><span id="wmessage" style="color:red;"></span></div>
		</div>
		
		<div class="form-group">
			<label for="isForceUpdate" class="col-sm-2 control-label">是否强制更新：</label>
			<div class="col-sm-4">
				<select id="isForceUpdate" name="isForceUpdate">
				 <option value="0">否</option>
				 <option value="1">是</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		 <div class="form-group">
			<label for="effectTime" class="col-sm-2 control-label">生&nbsp;效&nbsp;时&nbsp;间：</label>
			<div class="col-sm-5">
				<input id="d424" class="Wdate" type="text" name="effectTime" id="effectTime"  onfocus="WdatePicker({dateFmt:'yyyy-M-d H:mm:ss'})"/>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="functionDes" class="col-sm-2 control-label">功&nbsp;能&nbsp;描&nbsp;述：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="functionDes" name="functionDes" clos="15" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength1">最多输入1000个字符</div>
		</div>
		
		<div class="form-group">
			<label for="remark" class="col-sm-2 control-label">备&nbsp;&nbsp;注：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="remark" name="remark" clos="15" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength2">最多输入1000个字符</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
	</form>
	<br /><br /><br /><br /><br /><br />
<a href="${ctx}/sysmgr/list?appType=0">版本列表</a>
<%-- </div> --%>
<script type="text/javascript">
		var ctx = "${ctx}";
	 $(document).ready(function() {
		
		 $('#addressDiv').hide();
		
		//控制描述信息输入字数
		 $("#functionDes").keyup(function(){
			 var a=1000-$("#functionDes").val().length;
			 $("#nLength1").html("您还可以输入"+a+"个字符");
			 if(a<=0){
			   alert("字数不能超过1000");
			 }
		 });
		
		//控制备注输入字数
		 $("#remark").keyup(function(){
			 var a=1000-$("#remark").val().length;
			 $("#nLength2").html("您还可以输入"+a+"个字符");
			 if(a<=0){
			   alert("字数不能超过1000");
			 }
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
				var effectTime = $("#effectTime").val();
				if(effectTime==""){
						$('#wmessage').text("请选择生效时间！");
						document.getElementById("wmessage").style.display="block";
						return false;
					}  
				if($("#fileAddress").val()==""){
					alert("请上传文件！");
					return false;
				}
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						window.location.reload();
						//window.location.href = '${ctx}/link/list';
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
	
	function showAddressInput(versionType)
	{
	    	$('#fileAddress').val('');
			if(versionType == 2)//ios apk版本
			{				
				$('#addressDiv').show();
				$('#uploadDiv').hide();
			}else
			{
				$('#addressDiv').hide();
				$('#uploadDiv').show();
			}
	}
	//文件上传
	
	function upFile() {
		$.ajaxFileUpload({
			url : ctx + '/sysmgr/upload', //用于文件上传的服务器端请求地址
			secureuri : false, //是否需要安全协议，一般设置为false
			fileElementId : 'file', //文件上传域的ID
			dataType : 'json',
			success : function(data, status) //服务器成功响应处理函数
			{
				//alert(data.imgurl);
				$('#wmessage').text(data.message);
				if(data.errors == "failed"){
					alert(data.message);
					return;
				}
				//提交表单用
				$("#fileAddress").val(data.results.fileAddress);
				$("#md5").val(data.results.md5);
				if (typeof (data.message) != 'undefined'
						&& data.message != null) {
					alert(data.message);
				}

			},
			error : function(data, status, e)//服务器响应失败处理函数
			{
				alert(e);
			}
		});
		return false;

	}
</script>
</html>